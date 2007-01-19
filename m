Return-Path: <linux-kernel-owner+w=401wt.eu-S932510AbXASQFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbXASQFF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbXASQFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 11:05:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:60590 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbXASQFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 11:05:02 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cWixIlz6u7mxrSRB6OEys7MzqsJgE5Fz0GRm2eIxb5PvQM3HlYfyv883eenLu3jmH8lQ6E0e77o9nWufdeVBPSCC6WmZcgNbOQwzm4WEzWTRzdnFKcsBBJD56CvhFQjC3GWMs1b/r2VLVhgxzIN1s2jeQ4+TsMSOkkEcMhzhHV8=
Message-ID: <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
Date: Sat, 20 Jan 2007 00:05:01 +0800
From: "Aubrey Li" <aubreylee@gmail.com>
To: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>
In-Reply-To: <45B0DB45.4070004@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
	 <45B0DB45.4070004@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>
>
> Hi Aubrey,
>
> The idea of creating separate flag for pagecache in page_alloc is
> interesting.  The good part is that you flag watermark low and the
> zone reclaimer will do the rest of the job.
>
> However when the zone reclaimer starts to reclaim pages, it will
> remove all cold pages and not specifically pagecache pages.  This
> may affect performance of applications.
>
> One possible solution to this reclaim is to use scan control fields
> and ask the shrink_page_list() and shrink_active_list() routines to
> target only pagecache pages.  Pagecache pages are not mapped and
> they are easy to find on the LRU list.
>
> Please review my patch at http://lkml.org/lkml/2007/01/17/96
>

So you mean the existing reclaimer has the same issue, doesn't it?
In your and Roy's patch, balance_pagecache() routine is called on file
backed access.
So you still want to add this checking? or change the current
reclaimer completely?

-Aubrey

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVKOIuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVKOIuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVKOIuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:50:05 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:63332 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751384AbVKOIuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:50:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rmqq8uM3OoomTgSAiFSZABxWL5vuQcswn+NH9uPh699+z3ERUHdipv6AGbTqoeOnHn84YZU+q8HN6jtaL2F8JEDGsQ7DZ+9Lsde82Ufzf2WVeEqgxONHpd5smodJrn3ERsGD+JKcAL+1U0xbqtkEhwgqyepygtRDLJi1QbUVt8Y=  ;
Message-ID: <4379A1C4.509@yahoo.com.au>
Date: Tue, 15 Nov 2005 19:52:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>
Subject: Re: [PATCH 01/05] mm fix __alloc_pages cpuset ALLOC_* flags
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Two changes to the setting of the ALLOC_CPUSET flag in
> mm/page_alloc.c:__alloc_pages()
> 
>  1) A bug fix - the "ignoring mins" case should not be honoring
>     ALLOC_CPUSET.  This case of all cases, since it is handling a
>     request that will free up more memory than is asked for (exiting
>     tasks, e.g.) should be allowed to escape cpuset constraints
>     when memory is tight.
> 
>  2) A logic change to make it simpler.  Honor cpusets even on
>     GFP_ATOMIC (!wait) requests.  With this, cpuset confinement
>     applies to all requests except ALLOC_NO_WATERMARKS, so that
>     in a subsequent cleanup patch, I can remove the ALLOC_CPUSET
>     flag entirely.  Since I don't know any real reason this
>     logic has to be either way, I am choosing the path of the
>     simplest code.
> 

Hi,

I think #1 is OK, however I was under the impression that you
introduced the exception reverted in #2 due to seeing atomic
allocation failures?!

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

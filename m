Return-Path: <linux-kernel-owner+w=401wt.eu-S1751371AbXAPTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXAPTw3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXAPTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:52:29 -0500
Received: from smtp-out.google.com ([216.239.45.13]:25098 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXAPTw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:52:28 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=U17OV/kkAEDxlkG7vLuspW6Z7ocFcxfkcYLbzakPyUPMnS5FOJ/142hPJyfKWSgC/
	ynUpBHReBtXEqqj2KO3/w==
Message-ID: <6599ad830701161152q75ff29cdo7306c9b8df5c351b@mail.gmail.com>
Date: Tue, 16 Jan 2007 11:52:13 -0800
From: "Paul Menage" <menage@google.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [RFC 8/8] Reduce inode memory usage for systems with a high MAX_NUMNODES
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       "Andi Kleen" <ak@suse.de>, "Paul Jackson" <pj@sgi.com>,
       "Dave Chinner" <dgc@sgi.com>
In-Reply-To: <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Christoph Lameter <clameter@sgi.com> wrote:
>
> This solution may be a bit hokey. I tried other approaches but this
> one seemed to be the simplest with the least complications. Maybe someone
> else can come up with a better solution?

How about a 64-bit field in struct inode that's used as a bitmask if
there are no more than 64 nodes, and a pointer to a bitmask if there
are more than 64 nodes. The filesystems wouldn't need to be involved
then, as the bitmap allocation could be done in the generic code.

Paul

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUJHNOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUJHNOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269952AbUJHNOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:14:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28346 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267926AbUJHNN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:13:56 -0400
Date: Fri, 8 Oct 2004 08:06:37 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Leonid Petrov <nouser@lpetrov.net>
Cc: linux-kernel@vger.kernel.org, user@lpetrov.net
Subject: Re: Out of Memory: Killed process while 1 Gb is free
Message-ID: <20041008110636.GF16028@logos.cnet>
References: <E1CD2GS-0006EF-7b@server14.totalchoicehosting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CD2GS-0006EF-7b@server14.totalchoicehosting.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 10:50:36AM -0400, Leonid Petrov wrote:
> Summary: 
>     "Out of Memory: Killed process" when more than 1 Gb of free memory
>      is available.
> 
> Description:
>   My Linux-server after 2-10 days starts killing processes claiming
>   that it is "Out of memory". Top does not show any processess which
>   occupy more than several percent of memory. It always occur when 
>   the amount of available memory (1Gb) is about half of the total 
>   memory (2Gb). Killing a process does not help and the kernel 
>   continue mass murder till the state then it becomes non-operational. 
>   During agony vmstat showed that the occupied 1Gb of memory was used 
>   mainly by cache and buffers. Analazing kernel log I found 245 events 
>   for last 3 weeks. All events occured when anount of Normal memory 
>   was in the range [0,2052]Kb (and about 1Gb of free high memory). 
>   It did not occur before upgrade to 2.6.8.1. Out of memory events 
>   occured in both Hyperthreading enabled and Hyperthreading disabled 
>   mode.
> 
> Keywords:
>   Virtual memory managment

Hi,

There have been several changes in this area since 2.6.8.1, it 
would be nice if you can repeat the tests with a recent -mm kernel 
(where most of the changes are).

One information is that there are not many freeable pages in 
the normal zone (active+inactive) lists:

 DMA free:1904kB min:16kB low:32kB
high:48kB active:112kB inactive:0kB present:16384kB
Sep 30 08:53:22 lacerta kernel: protections[]: 8 476 732
Sep 30 08:53:22 lacerta kernel: Normal free:1512kB min:936kB low:1872kB
high:2808kB active:216kB inactive:436kB present:901120kB

For me it looks like you might be seeing a kernel memory leak (what else
could cause such condition?)

IIRC quite some kernel memory leaks have been fixed since 2.6.8.1 
(cdrom driver, NFS, ...)


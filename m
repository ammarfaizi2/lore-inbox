Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUFYNKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUFYNKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUFYNKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:10:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266199AbUFYNKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:10:03 -0400
Date: Fri, 25 Jun 2004 09:34:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Ashley <dash@xdr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache memory never gets released
Message-ID: <20040625123457.GA25501@logos.cnet>
References: <200406250031.i5P0VfpP028660@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406250031.i5P0VfpP028660@xdr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 05:31:41PM -0700, David Ashley wrote:
> I tried upgrading to 2.4.26 and this has the CONFIG_OOM_KILLER which will
> probably improve the situation, but the kernel still has the cache problem.
> 
> Is there some way I can get a report of all the cached memory, wether it
> is inodes or blocks or whatever? I can deal with modifying the kernel to
> put in printk's if needbe.
> 
> The approach I'm thinking of is
> 1) Get report on all kernel cached memory
> 2) do what it takes to increase the cached memory so that it can't get reduced
> 3) Get another report, and see what's changed.
> 
> Thanks for any suggestions.
> 
> -Dave
> PS Basically what causes the problem the worst is repeatedly doing this:
> 1) Launch mozilla browser with latest flash plugin (x86)
> 2) Load a flash site that uses a large japanese unicode font
> 3) goto step 2 (that is, reload)
> 
> Mozilla + flash have a memory leak so every time the japanese font is reloaded
> mozilla uses up 3 more megs of ram. A watchdog mechanism kills mozilla when
> it uses up too much memory. But after a while doing this, the cached memory
> as reported by "free" grows and can't be reduced. 

Cached memory can be easily reclaimed, take a look at /proc/meminfo "Inactive" list.

> So finally rather than the
> watchdog killing mozilla and all being ok, the linux kernel kills the XFree86
> server in order to free up memory and the system is dead.

Add more swap.

>  This last is the
> original reason for us tracking down the problem, however the kernel killing
> processes is not required for the cache problem to occur.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTLDSnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTLDSnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:43:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39573 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263462AbTLDSnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:43:08 -0500
Date: Thu, 4 Dec 2003 19:42:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Bergmann <bergmann.peter@gmx.net>
Cc: Maciej Zenczykowski <maze@cela.pl>, linux-kernel@vger.kernel.org
Subject: Re: oom killer in 2.4.23
Message-ID: <20031204184248.GJ1086@suse.de>
References: <Pine.LNX.4.44.0312041801560.26684-100000@gaia.cela.pl> <9405.1070562818@www45.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9405.1070562818@www45.gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04 2003, Peter Bergmann wrote:
> > 
> > Yes, and as a side question, couldn't oom killer be made into a config 
> > option?
> > 
> > Cheers,
> > MaZe.
> 
> I just tried it and - no it does not work.  
> At least not with the following changes:
> 
> added #define PF_MEMDIE  0x00001000 to sched.h
> 
> replaced oom_kill.c with the 2.4.22 version
> 
> added out_of_memory() to the end of try_to_free_pages_zone()
> 
> replaced if (current->flags & PF_MEMALLOC && !in_interrupt()) {
> with
> replaced if ((current->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()
> ) {
> in page_alloc.c
> 
> 
> effect is still unchanged. 
> processes get killed by VM and not oom_kikll.c
> 
> any hints ??

You probably want to look at the change to
vmscan.c:try_to_free_pages_zone().

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVATR1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVATR1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVATR1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:27:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2193 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262240AbVATR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:26:27 -0500
Date: Thu, 20 Jan 2005 12:00:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: oom killer gone nuts
Message-ID: <20050120140033.GQ2240@logos.cnet>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120131556.GC10457@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 02:15:56PM +0100, Andries Brouwer wrote:
> On Thu, Jan 20, 2005 at 01:34:06PM +0100, Jens Axboe wrote:
> 
> > Using current BK on my x86-64 workstation, it went completely nuts today
> > killing tasks left and right with oodles of free memory available.
> 
> Yes, the fact that the oom-killer exists is a serious problem.
> People work on trying to tune it, instead of just removing it.
> 
> I am getting reports that also in overcommit mode 2 (no overcommit,
> no oom-killer ever needed) processes are killed by the oom-killer
> (on 2.6.10).

Hi Andries,

There is a user requirement for overcommit mode, you know. 

Saying "hey, there's no more overcommit mode in future v2.6 releases, you 
run out of memory and get -ENOMEM" is not really an option is it?

You propose to remove the OOM killer and do what? Lockup solid?  

It is _WAY_ off right now: look at the amount of free pages:

DMA free:4536kB min:60kB low:72kB high:88kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
Normal free:524648kB min:4028kB low:5032kB high:6040kB active:76508kB inactive:81760kB present:1031360kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 556*4kB 155*8kB 65*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4536kB
Normal: 29800*4kB 25115*8kB 6953*16kB 1251*32kB 326*64kB 103*128kB 31*256kB 12*512kB 3*1024kB 1*2048kB 0*4096kB = 524648kB
HighMem: empty

v2.4 gets it pretty much right for most cases, and its obviously screwed up right now in v2.6.

Andrea/Thomas were working on getting it fixed ??

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSJGBso>; Sun, 6 Oct 2002 21:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262337AbSJGBso>; Sun, 6 Oct 2002 21:48:44 -0400
Received: from tapu.f00f.org ([66.60.186.129]:39890 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262331AbSJGBsn>;
	Sun, 6 Oct 2002 21:48:43 -0400
Date: Sun, 6 Oct 2002 18:54:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Bob McElrath <bob+linux-kernel@mcelrath.org>
Cc: Roberto Nibali <ratz@drugphish.ch>, linux-kernel@vger.kernel.org,
       gareth@nvidia.com
Subject: Re: nvidia 2.5.40+ patch?
Message-ID: <20021007015421.GA20279@tapu.f00f.org>
References: <20021006090255.GA13253@tapu.f00f.org> <20021006185412.GA3140@draal.physics.wisc.edu> <3DA0958A.9050809@drugphish.ch> <20021006203142.GD10884@draal.physics.wisc.edu> <3DA0A1C1.1080700@drugphish.ch> <20021007014225.GC894@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007014225.GC894@draal.physics.wisc.edu>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 08:42:26PM -0500, Bob McElrath wrote:

> I applied these patches (I did not disable preempt, and how do you
> enable stack frame pointer support?)

You need preempt to get this debugging.

> and there are 2 oopses in bootup:

Oopses or warnings?  There are plenty of locking violations, you see
these during init right now, but there they do little harm.  Once the
system in up --- then they are a problem.

>     Trace; c01387ca <slabinfo_write+32a/6c0>
>     Trace; c0213e05 <blk_cleanup_queue+105/180>
>     Trace; c0213e97 <blk_init_queue+17/2c0>
>     Trace; c0225fd9 <save_match+c9/130>
>     Trace; c022d9d0 <do_ide_request+0/30>
>     Trace; c022620e <init_irq+1ce/560>
>     Trace; c022dd80 <ide_intr+0/180>
>     Trace; c0226678 <hwif_init+d8/260>
>     Trace; c0225ec4 <probe_hwif_init+24/70>
>     Trace; c0235530 <ide_setup_pci_device+50/80>
>     Trace; c02251f6 <generic_mii_ioctl+1286/1c70>
>     Trace; c010507a <stext+7a/1e0>
>     Trace; c0105040 <stext+40/1e0>
>     Trace; c0105625 <show_regs+165/170>

IDE warning, know problem ... fix is pending

>     Trace; c0252cb2 <usb_hub_port_disable+482/8c0>
>     Trace; c0115ac2 <schedule+192/300>
>     Trace; c011c8b4 <reparent_to_init+e4/180>
>     Trace; c0253035 <usb_hub_port_disable+805/8c0>
>     Trace; c0115c66 <preempt_schedule+36/50>
>     Trace; c0115c80 <default_wake_function+0/a0>
>     Trace; c0253000 <usb_hub_port_disable+7d0/8c0>
>     Trace; c0105625 <show_regs+165/170>

USB people know about this and many others, fixes sure to come soon I
guess.

>     However I cannot get the nvidia driver to compile with Chris' patch:
>     (0)<mcelrath@navi:/usr/src/NVIDIA_kernel-1.0-3123.cw> sudo insmod ./NVdriver 
>     ./NVdriver: unresolved symbol create_workqueue
>     ./NVdriver: unresolved symbol destroy_workqueue
>     ./NVdriver: unresolved symbol flush_workqueue
>     ./NVdriver: unresolved symbol queue_work
>     ./NVdriver: 

What kernel?  My patch requires stuff only in
bk://linux.bkbits.net/linux-2.5 at present, the next release will have
the workqueue stuff too.




  --cw

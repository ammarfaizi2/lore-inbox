Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbUKHVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbUKHVmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUKHVmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:42:07 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58338 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261253AbUKHVlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:41:36 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 22:28:32 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
Message-ID: <20041108212832.GB4217@bytesex>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net> <87bre88zt8.fsf@bytesex.org> <20041108185249.GK5360@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108185249.GK5360@magma.epfl.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 07:52:49PM +0100, Gregoire Favre wrote:
> On Mon, Nov 08, 2004 at 10:17:39AM +0100, Gerd Knorr wrote:
> 
> > Well, if it happens almost independant of the kernel/driver version it
> > most likely is buggy hardware.  I can't do much about it ...
> 
> ? Why couldn't it be a bug present in all kernels/drivers ?

bttv runs rock solid for many people.  Well, at least most versions,
some *are* buggy.  I'm not perfect after all ;)

> > Well known example are some via chipsets which have trouble with
> > multiple devices doing DMA at the same time (those tend to run stable
> > with bttv once you've turned off ide-dma ...).
> 
> I had those xawtv crash with an SCSI only system, and on all my
> MB/CPU/RAM test I doubt that all hardware configuration were buggy.

The point isn't IDE, the point is two devices doing DMA at the same
time.  The usual system diagnose tools don't do that btw, they test one
device after another.  For simliar reasons memtest may run perfectly
fine and neverless gcc segfaults on kernel builds due to bad RAM ...

What most people see is that the machine freezes are much more likely as
soon as they do disk I/O in parallel to watching TV.  It doesn't really
matter whenever the IDE controller or the SCSI hostadapter does the DMA.

PCI-PCI transfers (i.e. DMA from bt878 to graphics card for overlay) are
another case which often broken in chipsets.

> I only have DVB hardware, is that also considered as bttv ?

Full-featured DVB cards (i.e. those with hardware mpeg decoder) do
things compareble to b878.

> Some things I have noticed : xawtv and kdetv don't need CPU to achieve
> the best quality I know about BUT they make the system crash.
> kvdr and tvtime needs lots of time and there quality are really lower
> than the two others, BUT they don't crash my system.

Then it's likely the PCI-PCI transfers which kill the system.

Try switching xawtv into grabdisplay mode, it most likely shows the
same behavior like tvtime then, i.e. eat CPU time and don't crash the
machine.  Thats simply the fact that PCI-PCI transfers are not used
then.  And it's almost certainly not a driver bug then, the driver
just has to setup stuff once and then let the hardware run on its
own (which sometimes has the funny effect that the video overlay
continues to run even after a kernel panic ;)

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)

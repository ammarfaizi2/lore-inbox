Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVBAXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVBAXSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVBAXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:18:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:26294 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262163AbVBAXS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:18:27 -0500
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ee21rh@surrey.ac.uk
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>
	 <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 10:18:20 +1100
Message-Id: <1107299901.5624.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 20:22 +0000, Richard Hughes wrote:
> On Tue, 01 Feb 2005 12:57:33 +0100, Michael Brade wrote:
> 
> > Hi,
> > 
> > since at least kernel 2.6.9 I'm having a problem booting linux - it hangs 
> > after this
> > 
> > Probing IDE interface ide0...
> > hda: HITACHI_DK23DA-30, ATA DISK drive
> > elevator: using anticipatory as default io scheduler
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > Probing IDE interface ide1...
> > hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI CD/DVD-ROM drive
> > ide1 at 0x170-0x177,0x376 on irq 15
> > 
> > After about 30 seconds everything continues fine with
> > 
> > hda: max request size: 128KiB
> > 
> > I found additional lines in the log just before the line above:
> 
> Same here on 2.6.11-rc2-bk3 using a *Toshiba* Satellite Pro A10.
> 
> messages can be found here:
> 
> http://hughsie.no-ip.com/write/kernel/messages

This looks like bogus HW, or bogus list of IDE interfaces ...

The IDE layer waits up to 30 seconds for a device to drop it's busy bit,
which is necessary for some drives that aren't fully initialized yet.

I suspect in your case, it's reading "ff", which indicates either that
there is no hardware where the kernel tries to probe, or that there is
bogus IDE interfaces which don't properly have the D7 line pulled low so
that BUSY appears not set in absence of a drive.

I'm not sure how the list of intefaces is probed on this machine, that's
probably where the problem is.

Ben.



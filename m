Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSHWK7u>; Fri, 23 Aug 2002 06:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318752AbSHWK7u>; Fri, 23 Aug 2002 06:59:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17169 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318751AbSHWK7t>; Fri, 23 Aug 2002 06:59:49 -0400
Date: Fri, 23 Aug 2002 12:03:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020823120350.A20963@flint.arm.linux.org.uk>
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org> <3D62BC10.3060201@mandrakesoft.com> <3D62C2A3.4070701@mandrakesoft.com> <m1sn17pici.fsf@frodo.biederman.org> <3D656FDC.8040008@mandrakesoft.com> <m1ofbupfe1.fsf@frodo.biederman.org> <3D658F2C.1080400@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D658F2C.1080400@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Aug 22, 2002 at 09:26:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 09:26:04PM -0400, Jeff Garzik wrote:
> Well, this only applies if you are slack and letting the kernel init 
> your ATA from scratch, instead of doing proper ATA initialization in 
> firmware ;-)

Assuming that you have firmware.  What about the case of PCMCIA drives
that you plug in after the kernel has booted and get registered with
IDE almost immediately?

> Seriously, if you are a handed an ATA device that is actually in 
> operation when the kernel boots, you are already out of spec.  I would 
> prefer to barf if the BSY or DRDY bits are set, because taking over the 
> ATA bus while a device is in the middle of a command shouldn't be 
> happening at Linux kernel boot, ever.

Erm, no.  Read the spec.  When the drive is spinning up from power on,
BSY is set.  BSY may be set for up to 30 seconds or so until the platters
are at full speed.  (Some drives take even longer, maybe 40 seconds.)
Once this is so, there are magic bytes you can read from the drive
register that tell you if the device is AT or ATA.  These aren't valid
until that BSY bit has cleared.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


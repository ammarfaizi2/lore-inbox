Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSHWNSX>; Fri, 23 Aug 2002 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318807AbSHWNSX>; Fri, 23 Aug 2002 09:18:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59260 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318806AbSHWNSV>; Fri, 23 Aug 2002 09:18:21 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
References: <Pine.LNX.4.10.10208201452210.3867-100000@master.linux-ide.org>
	<3D62BC10.3060201@mandrakesoft.com>
	<3D62C2A3.4070701@mandrakesoft.com>
	<m1sn17pici.fsf@frodo.biederman.org>
	<3D656FDC.8040008@mandrakesoft.com>
	<m1ofbupfe1.fsf@frodo.biederman.org>
	<3D658F2C.1080400@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Aug 2002 07:09:03 -0600
In-Reply-To: <3D658F2C.1080400@mandrakesoft.com>
Message-ID: <m1k7mhpvrk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Eric W. Biederman wrote:
> > The problem is that immediately after bootup ATA devices do not respond until
> > their media has spun up.  Which is both required by the spec, and observed in
> > practice.   Which is likely a problem if this code is run a few seconds after
> > bootup.  Which makes it quite possible the drive will ignore the EXECUTE
> DEVICE
> 
> > DIAGNOSTICS and your error code won't be valid when the bsy flag
> > clears.   I don't know how serious that would be.
> 
> 
> Well, this only applies if you are slack and letting the kernel init your ATA
> from scratch, instead of doing proper ATA initialization in firmware ;-)

That would be nice.  I do admit it is hard to trigger if you don't do
it deliberately. 

The x86 BIOS specifications say only the boot devices must be
initialized, before the BIOS gives up control.  A more likely
reproducer is a plug-in ata controller that the BIOS does not
recognize, and the kernel does.
 
> Seriously, if you are a handed an ATA device that is actually in operation when
> the kernel boots, you are already out of spec.  I would prefer to barf if the
> BSY or DRDY bits are set, because taking over the ATA bus while a device is in
> the middle of a command shouldn't be happening at Linux kernel boot, ever.

Throwing an error and giving up would certainly be a safe response,
though it is a strange way to handle in spec hardware and firmware
behavior.  On the other hand it is a rare enough case deliberately not
coping with it is probably fine.

Eric

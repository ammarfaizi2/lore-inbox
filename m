Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292959AbSBVTcN>; Fri, 22 Feb 2002 14:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292960AbSBVTcE>; Fri, 22 Feb 2002 14:32:04 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:3878 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S292959AbSBVTbq> convert rfc822-to-8bit; Fri, 22 Feb 2002 14:31:46 -0500
Date: Thu, 21 Feb 2002 21:31:20 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222154011.B5783@suse.cz>
Message-ID: <20020221211606.F1418-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Feb 2002, Vojtech Pavlik wrote:

> On Fri, Feb 22, 2002 at 02:16:39PM +0000, Arjan van de Ven wrote:
>
> > > I think it'd be even better if the chipset drivers did the probing
> > > themselves, and once they find the IDE device, they can register it with
> > > the IDE core. Same as all the other subsystem do this.
> >
> > Please send me your scsi subsystem then ;)
>
> I must agree that SCSI controllers aren't doing their probing in a
> uniform and clean way even on PCI, but at least they do the probing
> themselves and don't have the mid-layer SCSI code do it for them like
> IDE.

The problem that bites us since years is not the PCI probing, but the
order in which SCSI devices are attached. Microsoft O/Ses have been smart
enough for ordering hard disks in the way user sets it from system setup,
but Unices just messed up the thing.

There have been exceptions to this. People that use sym53c8xx HBA with
NVRAM for hard disk devices with either the sym53c8xx or the sym53c8xx_2
drivers see their hard disks under Linux in the expected order. The work
is performed by the low level driver by:

1) Detecting a controller with NVRAM that contains the HBA attachment
   order.
2) Attaching the HBAs in this order.
   2.1 For each HBA, attaching the devices configured for SCAN at BOOT.

Then other devices can be probed after boot by user in the order it
desires.

Basically at the moment, if the driver allows upper 'seeming cleaner and
smarter' PCI probing things to deal with the HBA attachment order, at
least all my machines running Linux will not even reboot.

Being smart is doing what user expects, here.

  Gérard.


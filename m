Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSGPOBW>; Tue, 16 Jul 2002 10:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317842AbSGPOBV>; Tue, 16 Jul 2002 10:01:21 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:22494 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317836AbSGPOBN>; Tue, 16 Jul 2002 10:01:13 -0400
Date: Tue, 16 Jul 2002 16:02:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207161402.g6GE2Un9021910@burner.fokus.gmd.de>
To: dalecki@evision-ventures.com, schilling@fokus.gmd.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From dalecki@evision-ventures.com Tue Jul 16 13:43:18 2002

>>>                  User Level
>>>--------------------------------------------------------------
>>=20
>>=20
>>>+----------------+   +---------------------+
>>>| Block Interface|   | Character Interface |
>>>+----------------+   +---------------------+
>>>        |                        |
>>>        |   +--------------------+
>>=20
>>=20
>> Why should the character interface be connected to the block layer?
>> This would contradict UNIX rules.

>Bullshit. UNIX sees even every single block device as both: char and bloc=
>k
>even under the same major number. The reason above is - tape devices.

Don't make conclusions from Linux, have a look at UNIX first:

-	All traditional UNIXes including vanilla SVSvr4 use different
	major numbers for block and char dev entries.

	... I call this a design bug, but take it for given.

-	UNOS, a real time UNIX clone from 1982 did have a unique driver
	switch table and the same major for block/character devices.
	UNOS has no connection to the UNIX genealogy tree.

-	Solaris 2.1 introduced together with dynamic and virtual major device
	numbers a unique interface for block and character devices.

The fact that Linux did not have character device nodes for disks until shortly
should not confuse you.

Tape block drivers only make sense with something like DECtapes.
DECtapes used as block device have been used to boot emergency recovery systems
on PDP-11 sty computers. Booting took a long long time then.

>>>The driving vision for this is to move into the generic block layer as =
>much of=20
>>>the individual transport stack as makes sense (i.e. if other transports=
> can=20
>>>make use of the functions), so, for example, Tag command queueing is al=
>ready=20
>>>in there and shared between IDE and SCSI.
>>=20
>>=20
>> AFAIK, tagged command queuing is a SCSI specific property, why should t=
>his
>> be part of a generif block layer?

>Becouse it is not SCSI specific. SerialATA will *nearly* require it.
>And there are ATA disks out there which do it *right now* too.

How do you access these properties then? Using SCSI commands?


>Your proposal has one flaw - it thinks that SCSI is the mother of
>all block devices and thinks that the kernel should have a SCSI driver
>with some kind of direct translation for any other devices. This is
>wrong becouse you go:

>1. abstract access.

Which is not a problem

>2. SCSI access.

Not a problem too for all drives that support SCSI commands.

>3. back to abstract access.

??? Looks like you missundertood even the ATAPI layering.
BTW: I don't reqiest that SCSI commands are used for ATA only drives.

>4. ATA access.

See above...

>This is at least not fine. The proposal by James takes in to
>account that dealing with ATAPI ver. SCSI MMC shouldn't be done
>on any kind of "layer" it fits better in the abstraction
>of an utility library supposed to help unify code. But not an
>additional layer between the generic one and the device transfer.
>You have to have an independant transport layer for IDE attached
>devices becouse the whole handling of the transfer works significantly
>different from SCSI.

Please show me how you would like to read a sector of audio data off
a MMC ATAPI drive without using SCSI commands. Vanilla ATA read access
is of vely limited use.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

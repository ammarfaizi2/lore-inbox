Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUHGMSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUHGMSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUHGMSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:18:15 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:985 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261724AbUHGMSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:18:09 -0400
Date: Sat, 7 Aug 2004 14:17:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Martin Mares <mj@ucw.cz>

>> It seems that you are not really interested to understand how it works :-(

>I am interested, but I life is too short to read the full docs of all existing
>OS's. Can you give me at least a pointer to the relevant section?

I already did! ---> "man path_to_inst"

>> If you behave this way, I tend to believe that you have a precasted opinion 
>> that you are not willing to change.

>I think that most people around there tend to believe exactly the same about you :-)
>But let's change that.

I _am_ always open to new experiences but the problem with most if not all
of the people in LKML is that they only know things about Linux while I know 
many different operating systems.

>Most of all, I would like to know (I see I'm repeating myself, but I still
>haven't seen an answer to that) what's so special about the SCSI-like devices,
>that they would have to be addressed in a completely different way from the
>other UNIX devices. For the classical SCSI, you might argue that addressing
>by the physical topology is more realistic, but for ATAPI or USB disks,
>the SCSI triplets have nothing to do with the physical topology.

I did introduce Generic SCSI in August 1986. The interface used by libscg today 
is exactly the same interface as it has been used in August 1986.

The problem with Linux is that the "interfaces" constantly change.
Let us talk again in October 2018 (then the /dev/hd* Interface on Linux
would have the same age as my libscg has now) and check what happened to this
interface. If the interface did not change and is still binary compatible, you 
_may_ be right. However this is most improbable.

>From the > 20 platforms that libscg provides abstractions from, _most_
platforms do not allow the "UNIX" /dev/something method to work with
Generic SCSI:

-	DOS

-	Win9x

-	WinNT

-	VMS

-	MacOS X

-	AmigaOS

-	Apollo DomainOS

-	BeOS (uses CAM)

-	FreeBSD (uses CAM)

-	Next Step (Generic SCSI only works only with a special /dev/sg%d)

-	OS/2

-	OSF-1 / True-64 (uses CAM)

-	QNX (uses CAM)

-	SunOS-4.x

-	Linux (all older versions)

-	SCO OpenServer

-	SCO UnixWare

These are the platforms where /dev/something could work:

-	Linux-2.6 

-	AIX

-	BSD-OS

-	OpenBSD

-	HP-UX

-	SGI IRIX

-	Solaris (newer versions only)

As you see, the vast majority does not allow the adressing method the
people on LKML seem to prefer recently.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTAVPa3>; Wed, 22 Jan 2003 10:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTAVPa3>; Wed, 22 Jan 2003 10:30:29 -0500
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:56195 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S261723AbTAVPa1>; Wed, 22 Jan 2003 10:30:27 -0500
Date: Wed, 22 Jan 2003 16:38:13 +0100 (CET)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200301221538.h0MFcDS3023247@burner.fokus.gmd.de>
To: axboe@suse.de, cdwrite@other.debian.org, greg@ulima.unil.ch,
       linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de Wed Jan 22 09:35:39 2003

>> >How helpful. How about saying what's broken instead and I'd be happy to
>> >fix it.
>> 
>> I thought it's obvious: It is most likely a problem caused by the broken 
>> bit #defines in the Linux kernel for the SCSI status byte. I assume that
>> status should be 0x02 instead of 0x01. In addition, I would guess that

>Sounds plausible. Patch attached. Anyone care to expand on _why_ these
>status bytes are shifted one bit?

I have no idea... About 3-4 years ago, I tried to convice some of the kernel
people to change this but as you see, it did not happen.


>===== drivers/ide/ide-cd.c 1.35 vs edited =====
>--- 1.35/drivers/ide/ide-cd.c	Thu Nov 21 22:56:59 2002
>+++ edited/drivers/ide/ide-cd.c	Wed Jan 22 09:34:28 2003
>@@ -706,7 +706,7 @@
> 		 * scsi status byte
> 		 */
> 		if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
>-			rq->errors = CHECK_CONDITION;
>+			rq->errors = CHECK_CONDITION << 1;
> 
> 		/* Check for tray open. */
> 		if (sense_key == NOT_READY) {

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fhg.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.fhg.de/usr/schilling   ftp://ftp.berlios.de/pub/schily

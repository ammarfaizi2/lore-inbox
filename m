Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUHILsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUHILsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUHILsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:48:43 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:13481 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266490AbUHILsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:48:10 -0400
Date: Mon, 9 Aug 2004 13:46:58 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091146.i79Bkw9i009508@burner.fokus.fraunhofer.de>
To: James.Bottomley@steeleye.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From James.Bottomley@SteelEye.com  Sat Aug  7 17:01:00 2004

>On Thu, 2004-08-05 at 08:00, Jens Axboe wrote:
>> On Thu, Aug 05 2004, Joerg Schilling wrote:
>> > -	Parallel (50 bin) SCSI (unknown HBA) on Linux-2.6 does not work if
>> > 	DMA size is not a multiple of 4. The data transferred from the SCSI
>> > 	device is OK for the first part that is a multiple of 4.
>> > 	The remainder of bytes arrive as binary zeroes.
>> > 
>> > 	This is a new bug (I received the related information this week).
>> 
>> Might be a hardware issue.

>Probably it is.  Lots of hardware FIFO chips are 4 or 8 bytes wide and
>can't do partial transfers (because of the way the cycle the data off
>the bus).  Usually they have logic that sends only partial fragments on
>to the device for commands, but its not unknown for them to forget this
>on actual data transfers

I did already prove that is is a driver bug. Writing again that it _may_
be a hw bug does not help.

>> That's bogus, the SCSI stack (as well as the block layer) is very well
>> capable of reporting residual counts, and if the hardware can do it (we
>> can't get it from some ide hardware :/), we will report residuals.
>> 
>> So if it doesn't work it's a bug, but not a design bug.

>Well...more likely a driver bug.  Residuals have to be reported by the
>driver.  I thought all of the drivers that could were now doing this,
>but I might have missed some...which driver is it?

For Adaptec HW

>A selection timeout is reported as DID_NO_CONNECT.

>DID_TIME_OUT is for cards that can watchdog their commands in hw and is
>what they return when the watchdog fires.

>If you actually want visibility into the SCSI mid layer timeout, that's
>harder since it feeds directly into the error handler that tries to
>ready the transport and device for action.  In general, a command that
>times out this way is retried.  If you set the FASTFAIL flag, it will
>come out with DRIVER_TIMEOUT set in its result area.

-	Retrying commands that have been send via Generic SCSI is wrong.

-	A flag called "FASTFAI" does not exist :-( 


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

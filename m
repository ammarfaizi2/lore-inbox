Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSGQNpr>; Wed, 17 Jul 2002 09:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSGQNpq>; Wed, 17 Jul 2002 09:45:46 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:41927 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S313743AbSGQNpq>; Wed, 17 Jul 2002 09:45:46 -0400
Date: Wed, 17 Jul 2002 15:46:37 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207171346.g6HDkb1l028358@burner.fokus.gmd.de>
To: riel@conectiva.com.br, schilling@fokus.gmd.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From riel@imladris.surriel.com Wed Jul 17 15:37:18 2002

>> >Error handling is more than local.  Some errors, you are correct, can only be
>> >handled at the SCSI layer.  However, a large class of drivers (Think
>> >multi-path or software raid) want the ability to direct how SCSI handles
>> >errors themselves.  It is unacceptable to have SCSI all on its own retry a
>> >medium error command x times, taking minutes before the upper layers become
>> >aware anything went wrong.
>>
>> It looks like you have the wrong ideas about software raid. If you have
>> software raid, you will stack a SW raid driver just on top of the disk
>> drivers that handle the access to the real drives. The real drives first
>> do own error handling and if they cannot correct errors, the error is
>> handled inside the raid layer.

>Did you even read what James wrote ?

>When one of the disks in a RAID array develops a bad block
>it shouldn't stall the box for minutes when the error can
>be handled by simply doing the IO from other disks instead.

Is there any problem with using a ioctl() from upper layer kernel to the low 
level drivers (living under the SW raid) to reduce the number of retries to a 
reasonable value in this case?

The main design goal for UNIX as to keep it simple. There is no need for a 
complex cross layer error control.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGQNeO>; Wed, 17 Jul 2002 09:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGQNeO>; Wed, 17 Jul 2002 09:34:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26387 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314546AbSGQNeN>; Wed, 17 Jul 2002 09:34:13 -0400
Date: Wed, 17 Jul 2002 10:36:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: James.Bottomley@steeleye.com, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207171232.g6HCWhbE027917@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44L.0207171033000.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Joerg Schilling wrote:
> >From James.Bottomley@SteelEye.com Tue Jul 16 16:33:32 2002

> >Error handling is more than local.  Some errors, you are correct, can only be
> >handled at the SCSI layer.  However, a large class of drivers (Think
> >multi-path or software raid) want the ability to direct how SCSI handles
> >errors themselves.  It is unacceptable to have SCSI all on its own retry a
> >medium error command x times, taking minutes before the upper layers become
> >aware anything went wrong.
>
> It looks like you have the wrong ideas about software raid. If you have
> software raid, you will stack a SW raid driver just on top of the disk
> drivers that handle the access to the real drives. The real drives first
> do own error handling and if they cannot correct errors, the error is
> handled inside the raid layer.

Did you even read what James wrote ?

When one of the disks in a RAID array develops a bad block
it shouldn't stall the box for minutes when the error can
be handled by simply doing the IO from other disks instead.

> >But the new scheme allows that.  The block queues accept translated requests
> >(that's really what sg does).
>
> A SCSI request is _not_ a translated request. It is the real request itself.
> You usually even cannot translate a SCSI request into something else.

This suggests we shouldn't put all kinds of non-scsi devices
under the SCSI stack and should have a more generic block and
character device layer instead ...

> >But you're still too SCSI transport specific.  The ongoing goal is to make the
> >physical transport protocol an adjunct to the Linux internal transport (the
> >struct request) so that we can treat all block/character devices on an equal
> >footing.
>
> You seem to forget that all main control is done via SCSI commands. You
> are too anti SCSI wthout a real reason.

... and here you contradict what you said above.

Will you do the honours or are you waiting for somebody else
to godwinate the thread ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


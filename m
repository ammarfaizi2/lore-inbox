Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUHSPwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUHSPwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUHSPwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:52:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56561 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266553AbUHSPwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:52:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: new tool:  blktool
Date: Thu, 19 Aug 2004 17:51:19 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca>
In-Reply-To: <4124C135.7050200@rtr.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191751.19101.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Thursday 19 August 2004 17:03, Mark Lord wrote:
> >> But HDIO_DRIVE_CMD is rather easy to implement as well,
> >> and perhaps both should be there for an overlap.
> >>
> >> Especially since the former is in rather widespread use right now.
> >> Yup, it's missing a separate data-phase parameter,
> >> and lots of taskfile stuff, but it's configured by default
> >> into every kernel (the same is not true for taskfile support),
> >> and there's really only a few limited cases of it being used
> >> for non-data commands:  IDENTIFY, SMART, and the odd READ/WRITE
> >> SECTOR (pio, single sector).
> >
> > If HDIO_DRIVE_CMD was easy to do, I would have already done it.  I agree
> > with you that supporting it has benefits, but you are ignoring the
> > obstacles:
>
> "Ignoring"?  Hardly.  I even listed a few of them above.
> But in practice, HDIO_DRIVE_CMD only requires support for a very
> limited set of commands.  It was never intended for arbitrary
> command acceptance.  And it's not like Joe User can abuse it,

Most people used it for as much arbitrary commands as they could.

> since it requires SYSADMIN and RAWIO capabilities to execute.
>
> The command subset that accounts for just about all uses of it today is:
>
> SET_FEATURES, SMART, IDENTIFY, READ_SECTOR, WRITE_SECTOR.
> Period.

WRITE_SECTOR?

IDE version of HDIO_DRIVE_CMD only implements READ_SECTOR and it is
already an abuse of this ioctl (because it does PIO-in command if buffer
is provided and no-data command otherwise).

> Pretty easy to support those, especially in SATA.
> I know, since I've just taken a couple of hours and added it
> to my SATA/RAID driver (a queuing controller with tag support).
>
> For more generic interface, Curtis's document looks rather good.
> But for backward compatibility with existing tools like the
> smartmontools and hdparm, all that is needed is a limited subset
> of HDIO_DRIVE_CMD (for the opcodes listed above) and also
> the closely related HDIO_DRIVE_TASK ioctl for some of the SMART
> commands (all non-data).

IMO it is a perfect moment to add one generic interface and start
deprecating three strange ioctls (HDIO_DRIVE_CMD / HDIO_DRIVE_TASK / 
HDIO_DRIVE_TASKFILE).

Bartlomiej

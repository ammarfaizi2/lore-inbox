Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTELBdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 21:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTELBdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 21:33:21 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.43.38.154]:24069
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S261823AbTELBdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 21:33:19 -0400
Message-ID: <003f01c31828$c8e9f480$7c07a8c0@kennet.coplanar.net>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Rusty Russell" <rusty@rustcorp.com.au>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0305111712230.8722-100000@mion.elka.pw.edu.pl>
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique.
Date: Sun, 11 May 2003 21:49:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool stuff.

As far as making the parameters easy to parse, I think you would want to
have a single static tag before the = (equal) sign.  The kernel command line
parsing stuff provides parsing up to that point and dispatches to each
subsystem (or at least it used to), so:

ata.dev_noprobe=hda

should be

ata=dev_noprobe:hda,if_io_irq:0,0x1f0,7

or some such to use the generic code that's already there.

and possibly instead of io/irq pass PCI bus:device:fn and make passing raw
ioports a special case

Cheers,

Jeremy
----- Original Message -----
From: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Jeremy Jackson" <jerj@coplanar.net>
Cc: "Rusty Russell" <rusty@rustcorp.com.au>; "Alan Cox"
<alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Sunday, May 11, 2003 11:32 AM
Subject: Re: [PATCH] Switch ide parameters to new-style and make them
unique.


>
> On Sun, 11 May 2003, Jeremy Jackson wrote:
>
> > Haven't tested, but I have a few comments.
> >
> > First, I think this is a great step in the right
> > direction for the ide driver.
>
> Thanks.
>
> > I think at some point, the kernel command line parameters should be
> > consolidated behind a single ata=hda,noprobe or ata=if0,io0x1f0,irq7
type
> > parameter, instead of the hda= and ide0=.  Taking that one step furthur,
a
> > new syntax is needed, and having it go into 2.6 might pave the way for
> > removing the old cruft in 2.8?
>
> Yes, I was thinking about it.
> I prefer as easily parsable parameters as possible :-)
> fe. ata.dev_noprobe=hda and ata.if_io_irq=0,0x1f0,7.
>
> It is a question of shorter command line vs shorter parsing code.
>
> About a 2.6:
> I want to mark old command line plus HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
> ioctls as obsoleted for 2.6.x and remove these cruft early in 2.7.x.
> I hope I will manage to do it, but it depends on Linus.
>
> > That would seem necessary, as I see it, to remove static ide_hwifs and
> > eventually support better hotswap.  (But even if it doesn't it would
still
> > clean up the ide parameters)
>
> FYI I have just done dynamic ide_hwifs allocations, patch needs
>     finishing (pdc4030 special case), polishing and testing.
>
> Regards,
> --
> Bartlomiej
>


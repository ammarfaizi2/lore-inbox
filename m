Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275202AbTHGLXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275226AbTHGLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:23:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:4309 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275202AbTHGLXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:23:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 13:23:07 +0200 (MEST)
Message-Id: <UTC200308071123.h77BN7x00083.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Cc: alan@lxorguk.ukuu.org.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

    > In order to be able to troubleshoot problems we need to be able
    > to reconstruct the information involved.

    What problems are we talking about? :-)

I am happy that you think there are no problems.
I spent a considerable time eliminating.
On the other hand, if you don't know from experience
then a simple google search will tell you that this
has been a very painful area in the past.

    > One part is the disk identity info that existed at boot time.
    > It was read by the kernel, and stored. It is returned by the
    > HDIO_GET_IDENTIFY ioctl, as used in e.g. hdparm -i.
    >
    > There is also the current disk identity info.
    > It is found by asking the disk now, and is returned by e.g. hdparm -I.

    What is a value of having these two identities

It helps a little in two ways. One, to help people with fdisk/LILO/..
disk geometry problems. Two, to investigate new disks.

It is good to have clean data.

Long ago distributions contained privately modified versions of packages.
Today they use rpms where the pristine sources and the patches are
clearly visible. Much better.

    > Second: if we ask the disk for identity again, you'll see that
    > more than this single field was changed.

    We are updating drive->id for changing DMA modes,
    should this be "fixed" as well?

Yes.

drive->id is what the drive says it can do.
If the kernel is satisfied with that then it just uses this data.
If the kernel is of the opinion that it also has to check
what kind of cable, and what kind of controller, then it
does not change drive->id->* but determines the mode it wants to use
and writes that to drive->*.

Moreover, drive->id tells you the situation after the BIOS did its setup.
Sometimes the BIOS knows things the kernel doesnt know. It is good to
have the information. Destroying information serves no useful purpose.

    >   > So, the clean way is to examine what the disk reported,
    >   > never change it
    >
    >   Even if disk's info changes?  I don't think so.
    >
    > Yes. The disk geometry data that we use is drive->*
    > What the disk reported to us is drive->id->*.

    This is a contradiction if geometry of disk was changed cause
    disk reported to us geometry data second time.

I am not sure I can parse that.

Andries

-----
>From "man hdparm"

       -i     Display the identification info that  was  obtained
              from the drive at boot time, if available.
       -I     Request  identification  info  directly  from   the
              drive.


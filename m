Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267077AbUBMQJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267079AbUBMQJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:09:57 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56961 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267077AbUBMQJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:09:52 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Daniel Blueman" <daniel.blueman@gmx.net>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Date: Fri, 13 Feb 2004 17:15:33 +0100
User-Agent: KMail/1.5.3
References: <20040213142719.GA28100@mail.shareable.org> <17899.1076683453@www11.gmx.net>
In-Reply-To: <17899.1076683453@www11.gmx.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402131715.33710.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 of February 2004 15:44, Daniel Blueman wrote:
> It is a small loss that the TCQ-support implementation hasn't been stable
> on linux so far. I guess mostly due to the great I/O scheduling Linux has
> (ie anticipatory scheduler).
>
> Yes, a growing number of IDE disk manufacturers are using native S-ATA
> controllers in their disks, and TCQ is one of the core features (ie unique
> selling point), as well as being implemented on the more lavish P-ATA
> controllers.

Ugh, you are messing PATA drive TCQ, PATA host TCQ and SATA TCQ.

> It's just a shame that there are still issues saturating a bunch of IDE
> disks with software RAID in the 2.6 series, but I guess that'll be ironed
> out in time...
>
> > Daniel Blueman wrote:
> > > many modern IDE disks and
> > > controllers also have tagged command queuing, so it is even more of a
> >
> > corner case.
> >
> > Linux doesn't use tagged command queueing, though - the code has been
> > disabled for some time.  I thought the TCQ stuff was disabled because
> > only very few disks supported it and the code wasn't reliable.

You can re-enable it quite simply 8).

--- Kconfig.orig	2004-02-10 16:29:19.000000000 +0100
+++ Kconfig	2004-02-13 17:06:57.628617096 +0100
@@ -441,7 +441,7 @@
 # TCQ is disabled for now
 config BLK_DEV_IDE_TCQ
 	bool "ATA tagged command queueing (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && n
+	depends on EXPERIMENTAL
 	help
 	  Support for tagged command queueing on ATA disk drives. This enables
 	  the IDE layer to have multiple in-flight requests on hardware that

> > Yet you say many modern disks support it?

No, only IBM/Hitachi and some WD disks support IDE TCQ.


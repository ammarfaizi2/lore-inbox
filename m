Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSJILdI>; Wed, 9 Oct 2002 07:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261564AbSJILdI>; Wed, 9 Oct 2002 07:33:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44251 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261551AbSJILdH>; Wed, 9 Oct 2002 07:33:07 -0400
Date: Wed, 9 Oct 2002 13:38:45 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rob Landley <landley@trommello.org>
cc: Matt Porter <porter@cox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021008215220.68BF3544@merlin.webofficenow.com>
Message-ID: <Pine.NEB.4.44.0210091335450.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Rob Landley wrote:

>...
> Go into make menuconfig in 2.4.19.  Switch off "scsi support".  Back to the
> main menu, try to descend into "fusion mpt device support".  The menu still
> shows up (at the top level, I might add), but you can't go into it.
>
> That's been broken for over a year now.  It's in the top level of menuconfig.
>  I first reported it back around 2.4.6 or so.  It just doesn't get in
> anybody's way, and that area of code is a mess, and not fixing it isn't
> embarassing anybody specific.
>...

I assume the patch below fixes this for i386 (similar patches are needed
for at most four other architectures)?

> Rob

cu
Adrian

--- l/arch/i386/config.in.old	2002-10-09 13:28:59.000000000 +0200
+++ l/arch/i386/config.in	2002-10-09 13:31:44.000000000 +0200
@@ -357,7 +357,11 @@
 fi
 endmenu

-source drivers/message/fusion/Config.in
+if [ "$CONFIG_SCSI" != "n" ]; then
+   if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
+      source drivers/message/fusion/Config.in
+   fi
+fi

 source drivers/ieee1394/Config.in



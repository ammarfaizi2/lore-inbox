Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbRGaBMY>; Mon, 30 Jul 2001 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269135AbRGaBMO>; Mon, 30 Jul 2001 21:12:14 -0400
Received: from [209.226.93.226] ([209.226.93.226]:39164 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269134AbRGaBME>; Mon, 30 Jul 2001 21:12:04 -0400
Date: Mon, 30 Jul 2001 21:12:05 -0400
Message-Id: <200107310112.f6V1C5e13968@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Donald Thompson <dlt@dataventures.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Stallion EasyIO and devfs
In-Reply-To: <Pine.LNX.4.31.0107161135530.13603-100000@dv1.dataventures.com>
In-Reply-To: <Pine.LNX.4.31.0107161135530.13603-100000@dv1.dataventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Donald Thompson writes:
> I've got a stallion EasyIO PCI 4 port card running on kernel 2.4.4.
> Loading the stallion.o module does not seem to create the proper device files
> for me using devfs.
> 
> Upon loading the module I get the following devices created:
> 
> /dev/ttyE
> /dev/cue
> /dev/staliomem/0
> /dev/staliomem/1
> /dev/staliomem/2
> /dev/staliomem/3
> 
> I don't get /dev/ttyE0 through /dev/ttyE3 or /dev/ttyE/0 through
> /dev/ttyE/3, which is what I believe should be happening.

Please apply the following patch to drivers/char/stallion.c and let me
know if that helps.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

--- stallion.c~	Fri Mar  2 14:12:07 2001
+++ stallion.c	Mon Jul 30 21:08:34 2001
@@ -139,8 +139,13 @@
 static char	*stl_drvtitle = "Stallion Multiport Serial Driver";
 static char	*stl_drvname = "stallion";
 static char	*stl_drvversion = "5.6.0";
+#ifdef CONFIG_DEVFS_FS
+static char	*stl_serialname = "ttyE/%d";
+static char	*stl_calloutname = "cue/%d";
+#else
 static char	*stl_serialname = "ttyE";
 static char	*stl_calloutname = "cue";
+#endif
 
 static struct tty_driver	stl_serial;
 static struct tty_driver	stl_callout;

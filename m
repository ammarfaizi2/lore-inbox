Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUAZSRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUAZSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:17:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:37512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbUAZSRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:17:02 -0500
Date: Mon, 26 Jan 2004 10:12:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: mdharm-kernel@one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc1-mm3] drivers/usb/storage/dpcm.c
Message-Id: <20040126101209.67c9edc6.rddunlap@osdl.org>
In-Reply-To: <40138599.1030406@jpl.nasa.gov>
References: <20040125050342.45C3E13A354@mrhankey.megahappy.net>
	<20040125084141.GA14215@one-eyed-alien.net>
	<40138599.1030406@jpl.nasa.gov>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 01:00:09 -0800 Bryan Whitehead <driver@jpl.nasa.gov> wrote:

| Matthew Dharm wrote:
| > One message a day to report a particular bug is really enough.... :)
| > 
| > That said, I think it would be better to add the ifdef's instead of more
| > substantial code changes.
| 
| No problemo, I was just getting my feet wet on small compiler warning 
| fixes and the SubmitingPatches doc said ifdefs were from the devil. ;)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FWIW, I prefer Bryan's patch instead of the #ifdefs.

--
~Randy


| I'll sent a patch later sunday...
| 
| > 
| > Matt
| > 
| > On Sat, Jan 24, 2004 at 09:03:42PM -0800, Bryan Whitehead wrote:
| > 
| >>In function dpcm_transport the compiler complains about ret not being used:
| >>drivers/usb/storage/dpcm.c: In function `dpcm_transport':
| >>drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'
| >>
| >>ret is not used if CONFIG_USB_STORAGE_SDDR09 is not set. Instead of adding
| >>more ifdef's to the code this patch puts ret to use for the other 2 cases in
| >>the switch statement (case 0 and default).
| >>
| >>--- drivers/usb/storage/dpcm.c.orig     2004-01-24 20:51:40.631038904 -0800
| >>+++ drivers/usb/storage/dpcm.c  2004-01-24 20:50:05.155553384 -0800
| >>@@ -56,7 +56,8 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
| >>     /*
| >>      * LUN 0 corresponds to the CompactFlash card reader.
| >>      */
| >>-    return usb_stor_CB_transport(srb, us);
| >>+    ret = usb_stor_CB_transport(srb, us);
| >>+    break;
| >>  
| >> #ifdef CONFIG_USB_STORAGE_SDDR09
| >>   case 1:
| >>@@ -72,11 +73,12 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
| >>     ret = sddr09_transport(srb, us);
| >>     srb->device->lun = 1; us->srb->device->lun = 1;
| >>  
| >>-    return ret;
| >>+    break;
| >> #endif
| >>  
| >>   default:
| >>     US_DEBUGP("dpcm_transport: Invalid LUN %d\n", srb->device->lun);
| >>-    return USB_STOR_TRANSPORT_ERROR;
| >>+    ret = USB_STOR_TRANSPORT_ERROR;
| >>   }
| >>+  return ret;
| >> }
| >>
| >>--

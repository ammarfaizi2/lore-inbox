Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUKGKNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUKGKNk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUKGKNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:13:40 -0500
Received: from services.exanet.com ([212.143.73.102]:27240 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S261567AbUKGKNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:13:34 -0500
Message-ID: <418DF54C.5040803@argo.co.il>
Date: Sun, 07 Nov 2004 12:13:32 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rg_Spilker?= <js@jetsys.de>
CC: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Apple Ipod doesn't work with USB on linux (but works with FireWire)
References: <200411071004.15605.js@jetsys.de>
In-Reply-To: <200411071004.15605.js@jetsys.de>
Content-Type: multipart/mixed;
 boundary="------------060200030407090307040704"
X-OriginalArrivalTime: 07 Nov 2004 10:13:32.0296 (UTC) FILETIME=[6F40D880:01C4C4B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060200030407090307040704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jörg Spilker wrote:

>Hi,
>
>i recently purchased a new Ipod Mini which i initially used via Firewire on my Laptop with windows.
>Then i tried to change to Linux (using gtkpod for managing my playlists). Because i want to leave the
>firewire cable connected to the laptop, i tried using the USB variant on Linux. My first try was with
>SuSE 9.0 and a 2.4.x kernel. Unfortunately with no success. Same errors as you see here (now with
>SuSE 9.2 and kernel 2.6.8).
>  
>
I recently posted a patch which fixes the problem; see attached.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick 
to panic.


--------------060200030407090307040704
Content-Type: text/plain;
 name="ipod-is-an-unusual-dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipod-is-an-unusual-dev.patch"

As jeffmock notes in http://tinyurl.com/6lmwp, the Apple iPod lies about its
size. It hurts particularly badly in this case, since if you access the iPod
beyond its real (not advertised) size, it locks up, and as some partition
tables (EFI) are stored at the end of the device, it locks up on the instant
you plug it in.

Note that contrary to what Jeff says, the error is only one sector. Maybe he
tried to read using the block device and got bitten by readahead.

Signed-off-by: Avi Kivity <avi@argo.co.il>

--- linux-2.6.8-1.624.aviipod/drivers/usb/storage/unusual_devs.h.ipod	2004-10-29 19:25:48.884603153 +0200
+++ linux-2.6.8-1.624.aviipod/drivers/usb/storage/unusual_devs.h	2004-10-29 20:27:40.799654665 +0200
@@ -424,6 +424,13 @@
 		0 ),
 #endif
 
+/* Reported by Avi Kivity <avi@argo.co.il> */
+UNUSUAL_DEV( 0x05ac, 0x1203, 0x0001, 0x0001,
+		"Apple",
+		"iPod",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_FIX_CAPACITY ),
+
 #ifdef CONFIG_USB_STORAGE_JUMPSHOT
 UNUSUAL_DEV(  0x05dc, 0x0001, 0x0000, 0x0001,
 		"Lexar",

--------------060200030407090307040704--


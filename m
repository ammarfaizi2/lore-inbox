Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131264AbQLJQ5L>; Sun, 10 Dec 2000 11:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130842AbQLJQ5B>; Sun, 10 Dec 2000 11:57:01 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:34567 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130580AbQLJQ4n>; Sun, 10 Dec 2000 11:56:43 -0500
Date: Sun, 10 Dec 2000 16:25:28 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: <torvalds@transmeta.com>, <sharp@ihug.co.nz>,
        Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11 
In-Reply-To: <20001210121512.A08BD418A@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.30.0012101622100.25294-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Hakan Lennestal wrote:

> The problem being that the kernel hangs after a dma timeout in the
> partition detection phase during bootup for speeds higher than udma 44.
> This is an IBM-DTLA-307030 connected to a hpt366 pci card on a BH6
> motherboard.

Until we manage to get a response from HPT on what they changed in the
1.26 version of their BIOS to accomodate these drives, we shouldn't
attempt to run them at that speed on the HPT366.

Linus, please apply.

--- linux-test/drivers/ide/hpt366.c	Tue Dec  5 13:30:40 2000
+++ linux-2.4/drivers/ide/hpt366.c	Tue Nov 21 13:42:40 2000
@@ -55,6 +55,9 @@
 };

 const char *bad_ata66_4[] = {
+	"IBM-DTLA-307075",
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
 	"WDC AC310200R",
 	NULL
 };


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279840AbRKFRMn>; Tue, 6 Nov 2001 12:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279917AbRKFRLl>; Tue, 6 Nov 2001 12:11:41 -0500
Received: from main.sonytel.be ([195.0.45.167]:54674 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S279893AbRKFRK2>;
	Tue, 6 Nov 2001 12:10:28 -0500
Date: Tue, 6 Nov 2001 18:09:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <laughing@shared-source.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.13-ac6
In-Reply-To: <20011102142512.A9558@lightning.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0111061806320.17730-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Alan Cox wrote:
> 2.4.13-ac6
> o	IDE driver updates				(Andre Hedrick
> 							 Michael Cornwell)
> 	| Taskfile framework
> 	| Disk suspend cache flushing
> 	| Driver updates
> 	| UDMA133

--- linux-2.4.13-ac5/include/asm-parisc/ide.h	Tue Dec  5 21:29:39 2000
+++ linux-2.4.13-ac6/include/asm-parisc/ide.h	Mon Nov  5 10:10:00 2001
@@ -90,7 +90,19 @@
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
 	} b;
-	} select_t;
+} select_t;
+
+typedef union {
+	unsigned all			: 8;	/* all of the bits together */
+	struct {
+		unsigned bit0		: 1;
+		unsigned nIEN		: 1;	/* device INTRQ to host */
+		unsigned SRST		: 1;	/* host soft reset bit */
+		unsigned bit3		: 1;	/* ATA-2 thingy */
+		unsigned reserved456	: 3;
+		unsigned HOB		: 1;	/* 48-bit address ordering */
+	} b;
+} control_t;

Any special reason why this is the little-endian control_t definition? AFAIK
PA-RISC$ is big-endian (and asm-parisc/byteorder.h seems to agree).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


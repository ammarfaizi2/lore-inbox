Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131010AbRANRWy>; Sun, 14 Jan 2001 12:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRANRWo>; Sun, 14 Jan 2001 12:22:44 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:51206 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131010AbRANRW2>; Sun, 14 Jan 2001 12:22:28 -0500
Date: Sun, 14 Jan 2001 17:22:06 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101130903580.1959-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101141712310.18663-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Linus Torvalds wrote:

> Somebody who can test it needs to send me a patch - I'm NOT going to apply
> patches that haven't been tested and that I cannot test myself.

This patch has worked for me and is obvious enough that I haven't bothered 
to rewire my box to put the IBM drive back on the HPT366 - the lid's 
actually screwed on for once.

It adds all the IBM Deskstar 75GXP and 40GV drives to the HPT366's UDMA
mode 4 blacklist, forcing them to drop to mode 3, with which myself and
the one other tester who responded were unable to find problems.

IIRC the drives actually used in the testing were the 30GB and 45GB 75GXP
models - IBM-DTLA-3070{30,45}. I've blacklisted the 40GV models too with
this patch, just to be on the safe side. It's a reasonable assumption that
the IDE interfaces on the slower drives share the same compatibility
problems with the HPT366.

(And I've fixed the Pine bug which was stripping trailing whitespace and 
making my patches fail to apply too :)

Index: drivers/ide/hpt366.c
===================================================================
RCS file: /inst/cvs/linux/drivers/ide/Attic/hpt366.c,v
retrieving revision 1.1.2.7
diff -u -r1.1.2.7 hpt366.c
--- drivers/ide/hpt366.c	2001/01/05 11:10:44	1.1.2.7
+++ drivers/ide/hpt366.c	2001/01/14 17:15:23
@@ -55,6 +55,15 @@
 };
 
 const char *bad_ata66_4[] = {
+	"IBM-DTLA-307075",
+	"IBM-DTLA-307060",
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
+	"IBM-DTLA-307020",
+	"IBM-DTLA-307015",
+	"IBM-DTLA-305040",
+	"IBM-DTLA-305030",
+	"IBM-DTLA-305020",
 	"WDC AC310200R",
 	NULL
 };

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

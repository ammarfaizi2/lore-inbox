Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRKMPhv>; Tue, 13 Nov 2001 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRKMPhl>; Tue, 13 Nov 2001 10:37:41 -0500
Received: from [212.18.232.186] ([212.18.232.186]:7442 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S273213AbRKMPh3>; Tue, 13 Nov 2001 10:37:29 -0500
Date: Tue, 13 Nov 2001 15:37:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011113153715.A21298@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 11:01:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pesky linux/irq.h include found its way back into drivers/char/vt.c
again (maybe Alan didn't merge it).

linux/irq.h is not required by vt.c, and, since it includes asm/hw_irq.h
which architectures many not provide, generic code should not be including
this file in the first place.

Here's a patch to fix this bogosity up:

--- orig/drivers/char/vt.c	Thu Nov  8 17:47:59 2001
+++ linux/drivers/char/vt.c	Tue Nov 13 15:24:21 2001
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
-#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCVI47>; Fri, 22 Mar 2002 03:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310742AbSCVI4j>; Fri, 22 Mar 2002 03:56:39 -0500
Received: from mail.fh-wedel.de ([195.37.86.23]:19718 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id <S310501AbSCVI4a>;
	Fri, 22 Mar 2002 03:56:30 -0500
Date: Fri, 22 Mar 2002 09:56:28 +0100
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac5
Message-ID: <20020322095628.A28751@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <00e401c1d13e$d5d92580$02c8a8c0@kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kernel BUG at ide-cd.c:790!
> invalid operand: 0000

The code appears to be too paranoid here. In case noone else submitted
a patch yet, here is mine.
Apply with patch -p0.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike

--- drivers/ide/ide-cd.c	Fri Mar 22 09:48:42 2002
+++ drivers/ide/ide-cd.c.new	Fri Mar 22 09:52:59 2002
@@ -786,9 +786,6 @@
 			return startstop;
 	}
 
-	if (HWGROUP(drive)->handler == NULL)	/* paranoia check */
-		BUG();
-
 	/* Arm the interrupt handler. */
 	ide_set_handler (drive, handler, timeout, cdrom_timer_expiry);
 

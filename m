Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTALKJB>; Sun, 12 Jan 2003 05:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTALKJB>; Sun, 12 Jan 2003 05:09:01 -0500
Received: from [80.66.38.208] ([80.66.38.208]:47117 "HELO cerberos")
	by vger.kernel.org with SMTP id <S267348AbTALKJA>;
	Sun, 12 Jan 2003 05:09:00 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Alexander Puchmayr <alexander.puchmayr@jku.at>
Reply-To: alexander.puchmayr@jku.at
To: linux-kernel@vger.kernel.org
Subject: USB-Printer status flags question
Date: Sun, 12 Jan 2003 11:17:41 +0100
User-Agent: KMail/1.4.3
Organization: =?iso-8859-1?q?Universit=E4t?= Linz
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301121117.41856.alexander.puchmayr@jku.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After looking at cups (1.1.18) backend/usb.c and the kernel's 
(2.4.19-gentoo-r10) drivers/usb/printer.c I've found some different 
interpretations of the LP_* flags from linux/lp.h

While the kernel seems to use the 8255 status port definitions, which use
(amongst others) the flags,

#define LP_PSELECD      0x10  /* unchanged input, active high */
#define LP_PERRORP      0x08  /* unchanged input, active low */

the same bits are defined by POSIX guidelines a few lines above in 
linux/lp.h:

#define LP_OFFL  0x0008
#define LP_NOPA  0x0010

Obviously, this leads the cups usb-backend to incorrectly report an empty 
media tray when the printer is online, idle and has enough paper.

This doesn't seem to be something serious, its just a wrong message in cups 
log-file.

Greetings
	Alex

PS: Since two different specifications are mixed up, this problem could also 
be a kernel problem.
 
-- 
Alexander Puchmayr            Systemadministrator for Theoretical Physics
University Linz, Austria      e-mail: alexander.puchmayr@jku.at
Altenbergerstrasse 69         phone: +43/732/2468-8633
A-4040 Linz-Auhof             FAX:   +43/732/2468-8585


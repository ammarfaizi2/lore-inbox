Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266418AbSKGJOG>; Thu, 7 Nov 2002 04:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266420AbSKGJOF>; Thu, 7 Nov 2002 04:14:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10898 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266418AbSKGJOB>; Thu, 7 Nov 2002 04:14:01 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Nov 2002 11:15:22 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] dsb usb radio fix
Message-ID: <20021107101522.GA1896@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes stupid cut+paste bug in dsbr100.

please apply,

  Gerd

--- linux-2.5.46/drivers/usb/media/dsbr100.c	2002-11-07 09:19:26.000000000 +0100
+++ linux/drivers/usb/media/dsbr100.c	2002-11-07 09:22:16.000000000 +0100
@@ -265,7 +265,8 @@
 		case VIDIOCSFREQ:
 		{
 			int *freq = arg;
-			*freq = radio->curfreq;
+
+			radio->curfreq = *freq;
 			if (dsbr100_setfreq(radio, radio->curfreq)==-1)
 				warn("set frequency failed");
 			return 0;

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20

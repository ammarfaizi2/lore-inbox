Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJ2Pxq>; Tue, 29 Oct 2002 10:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJ2Pxq>; Tue, 29 Oct 2002 10:53:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:52371 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261955AbSJ2Pxq>; Tue, 29 Oct 2002 10:53:46 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 29 Oct 2002 18:06:14 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [trivial patch] dsb radio fix
Message-ID: <20021029170614.GA23224@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes a stupid cut+paste bug in dsbr100 ...

  Gerd

==============================[ cut here ]==============================
--- linux-2.5.44/drivers/usb/media/dsbr100.c	Wed Oct 23 18:53:55 2002
+++ linux/drivers/usb/media/dsbr100.c	Wed Oct 23 18:54:50 2002
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

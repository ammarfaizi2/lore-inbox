Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVGUE0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVGUE0L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVGUEYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:24:02 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:64154 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261608AbVGUEXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:23:12 -0400
Message-ID: <42DF232A.9090805@m1k.net>
Date: Thu, 21 Jul 2005 00:23:06 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mkrufky@m1k.net, linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Mac Michaels <wmichaels1@earthlink.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [2.6.13 PATCH 3/4] 03-lgdt3302-suppress-compile-warning.patch
References: <42DF2196.5040503@m1k.net>
In-Reply-To: <42DF2196.5040503@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------060208010403020600000609"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060208010403020600000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> This patch series spans both video4linux and linux-dvb trees.
> Remove the dvb_pll_desc from the lgdt3302 frontend and replace with a 
> pll_set-callback to isolate the tuner programming from the frontend.
>
> Select the RF input connector based upon the type of demodulation 
> selected. ANT RF connector is selected for 8-VSB and CABLE RF 
> connector is selected for QAM64/QAM256. Implement this along the lines 
> posted to linux-dvb list (subscribers only) by Patrick Boettcher. ( 
> http://linuxtv.org/pipermail/linux-dvb/2005-July/003557.html ) This 
> only affects the cards that use the Microtune 4042 tuner. This is not 
> ideal, but there is no current specification for selecting RF inputs. 
> It makes the card work the same way as the Windows driver thus it may 
> reduce user confusion.
>



--------------060208010403020600000609
Content-Type: text/plain;
 name="03-lgdt3302-suppress-compile-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-lgdt3302-suppress-compile-warning.patch"

Suppress the following during compile:
warning: `i2c_readbytes' defined but not used
This code will either be re-enabled or deleted in a future patch.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 lgdt3302.c |    2 ++
 1 files changed, 2 insertions(+)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 22:53:42.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 23:01:58.000000000 +0000
@@ -94,6 +94,7 @@
 	return 0;
 }
 
+#if 0
 static int i2c_readbytes (struct lgdt3302_state* state,
 			  u8 addr, /* demod_address or pll_address */
 			  u8 *buf, /* holds data bytes read */
@@ -109,6 +110,7 @@
 	}
 	return 0;
 }
+#endif
 
 /*
  * This routine writes the register (reg) to the demod bus

--------------060208010403020600000609--

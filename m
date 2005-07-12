Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVGLPIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVGLPIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVGLPIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:08:50 -0400
Received: from kirby.webscope.com ([204.141.84.57]:49370 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S261475AbVGLPGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:06:47 -0400
Message-ID: <42D3DC5A.3010807@m1k.net>
Date: Tue, 12 Jul 2005 11:06:02 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
Content-Type: multipart/mixed;
 boundary="------------080304040009010900040308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080304040009010900040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There was a change made in 2.6.13-rc2-mm2 within both of the following 
patches:

v4l-saa7134-hybrid-dvb.patch
v4l-cx88-update.patch

The specific change that caused this problem is:

- Let Kconfig decide whether to include frontend-specific code.

I had tested this change against 2.6.13-rc2-mm1, and it worked perfectly as expected, but it caused problems in today's 2.6.13-rc2-mm2 release.  For some reason, the symbols don't get set properly.  The following patch corrects this problem and restores previous behavior.  We will eventually have to remove these symbols alltogether when we find a better solution, but this will fix the bug until then.





--------------080304040009010900040308
Content-Type: text/plain;
 name="v4l-broken-hybrid-dvb-inclusion-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-broken-hybrid-dvb-inclusion-fix.patch"

Always include dvb frontend code for hybrid cx88 and saa7134 boards.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 cx88/cx88-dvb.c       |    5 +++++
 saa7134/saa7134-dvb.c |    3 +++
 2 files changed, 8 insertions(+)

diff -upr linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c	2005-07-12 08:56:58.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-12 09:01:13.000000000 +0000
@@ -30,6 +30,11 @@
 #include <linux/file.h>
 #include <linux/suspend.h>
 
+#define CONFIG_DVB_MT352 1
+#define CONFIG_DVB_CX22702 1
+#define CONFIG_DVB_OR51132 1
+#define CONFIG_DVB_LGDT3302 1
+
 #include "cx88.h"
 #include "dvb-pll.h"
 
diff -upr linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-12 08:56:59.000000000 +0000
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-12 09:01:55.000000000 +0000
@@ -30,6 +30,9 @@
 #include <linux/kthread.h>
 #include <linux/suspend.h>
 
+#define CONFIG_DVB_MT352 1
+#define CONFIG_DVB_TDA1004X 1
+
 #include "saa7134-reg.h"
 #include "saa7134.h"
 

--------------080304040009010900040308--


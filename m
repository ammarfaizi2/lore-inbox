Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBKC1N>; Sun, 10 Feb 2002 21:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBKC1E>; Sun, 10 Feb 2002 21:27:04 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:65037 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S286339AbSBKC0w>; Sun, 10 Feb 2002 21:26:52 -0500
Message-ID: <3C672BE8.EF4C703F@delusion.de>
Date: Mon, 11 Feb 2002 03:26:48 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.4-pre6 apm compile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The attached patch fixes the following compiler warning in -pre6:

apm.c: In function `apm_mainloop':
apm.c:1376: warning: comparison between pointer and integer
apm.c:1384: warning: comparison between pointer and integer

nr_running is really a function and not an integer.

I believe this had already been applied in earlier 2.5 and then somehow
vanished, probably due to an update by whoever maintains apm.c

Regards,
-Udo.


--- linux-2.5.4-pre-vanilla/arch/i386/kernel/apm.c      Mon Feb 11 03:04:25 2002
+++ linux-2.5.4-pre/arch/i386/kernel/apm.c      Mon Feb 11 03:04:51 2002
@@ -1348,7 +1348,7 @@
  * decide if we should just power down.
  *
  */
-#define system_idle() (nr_running == 1)
+#define system_idle() (nr_running() == 1)
 
 static void apm_mainloop(void)
 {

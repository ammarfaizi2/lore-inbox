Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSBJBlH>; Sat, 9 Feb 2002 20:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSBJBk6>; Sat, 9 Feb 2002 20:40:58 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:20498 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289166AbSBJBkr>;
	Sat, 9 Feb 2002 20:40:47 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: <chaffee@cs.berkeley.edu>
Cc: "Dave Jones" <davej@suse.de>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: [patch][2.5.4-dj4] cleanup to use strsep in 
Date: Sun, 10 Feb 2002 02:40:40 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODEEMCCJAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch changes the use of strtok() to strsep().
Strtok() isn't SMP/thread safe. strsep is considered safer.


--
	Alex (alex@packetstorm.nu)


-------------------------- cut here -------------------------
diff -uN linux-2.5.3-dj4/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux-2.5.3-dj4/fs/vfat/namei.c     Mon Jan 28 22:20:44 2002
+++ linux/fs/vfat/namei.c       Sun Feb 10 03:41:26 2002
@@ -114,7 +114,9 @@
        save = 0;
        savep = NULL;
        ret = 1;
-       for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+       while ((this_char = strsep(&options,",")) != NULL) {
+               if (!*this_char)
+                       continue;
                if ((value = strchr(this_char,'=')) != NULL) {
                        save = *value;
                        savep = value;



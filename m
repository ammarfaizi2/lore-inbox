Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSBJBs2>; Sat, 9 Feb 2002 20:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289172AbSBJBsU>; Sat, 9 Feb 2002 20:48:20 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:21266 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289161AbSBJBsJ>;
	Sat, 9 Feb 2002 20:48:09 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: <chaffee@cs.berkeley.edu>
Cc: "Dave Jones" <davej@suse.de>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: [patch][2.5.4-dj4] cleanup to use strsep for fs/fat/inode.c
Date: Sun, 10 Feb 2002 02:48:07 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODKEMCCJAA.alex@packetstorm.nu>
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

This patch changes all use of strtok() to strsep().
Strtok() isn't SMP/thread safe. strsep is considered safer.


--
	Alex (alex@packetstorm.nu)


-------------------------- cut here -------------------------
diff -uN linux-2.5.3-dj4/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.3-dj4/fs/fat/inode.c      Sat Feb  9 21:57:39 2002
+++ linux/fs/fat/inode.c        Sun Feb 10 03:47:48 2002
@@ -223,8 +223,9 @@
                goto out;
        save = 0;
        savep = NULL;
-       for (this_char = strtok(options,","); this_char;
-            this_char = strtok(NULL,",")) {
+       while ((this_char = strsep(&options,",")) != NULL) {
+               if (!*this_char)
+                       continue;
                if ((value = strchr(this_char,'=')) != NULL) {
                        save = *value;
                        savep = value;



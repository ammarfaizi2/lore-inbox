Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289578AbSBJM0Q>; Sun, 10 Feb 2002 07:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289580AbSBJM0G>; Sun, 10 Feb 2002 07:26:06 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:48658 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289578AbSBJMZt>;
	Sun, 10 Feb 2002 07:25:49 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: <jani@astechnix.ro>
Cc: "Dave Jones" <davej@suse.de>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: [patch][2.5.4-dj4] cleanup, use strsep in tridentfb.c
Date: Sun, 10 Feb 2002 13:25:46 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODEEMOCJAA.alex@packetstorm.nu>
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

This patch changes strtok() use to strsep().
Strtok() isn't SMP/thread safe. strsep is considered safer.


--
	Alex (alex@packetstorm.nu)


-------------------------- cut here -------------------------
diff -Nru linux-2.5.3-dj4/drivers/video/tridentfb.c linux/drivers/video/tridentfb.c
--- linux-2.5.3-dj4/drivers/video/tridentfb.c Sat Feb  9 21:03:01 2002
+++ linux/drivers/video/tridentfb.c Sat Feb  9 21:03:01 2002
@@ -1259,8 +1259,8 @@
        char * opt;
        if (!options || !*options)
                return 0;
-       for(opt = strtok(options,",");opt;opt = strtok(NULL,",")){
-               if (!opt) continue;
+       while((opt=strsep(&options,",")) != NULL) {
+               if (!*opt) continue;
                if (!strncmp(opt,"noaccel",7))
                        noaccel = 1;
                else if (!strncmp(opt,"accel",5))



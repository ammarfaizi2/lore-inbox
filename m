Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUFTG34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUFTG34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 02:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUFTG3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 02:29:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:9103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265253AbUFTG3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 02:29:45 -0400
Date: Sat, 19 Jun 2004 23:28:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       vojtech@ucw.cz
Subject: Re: [PATCH 6/11] serio dynamic allocation
Message-Id: <20040619232844.1a0a872b.akpm@osdl.org>
In-Reply-To: <20040619232717.69b1b6e9.akpm@osdl.org>
References: <200406180335.52843.dtor_core@ameritech.net>
	<200406180340.55615.dtor_core@ameritech.net>
	<20040619220700.08425715.akpm@osdl.org>
	<200406200030.53331.dtor_core@ameritech.net>
	<20040619232717.69b1b6e9.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> You'll be needing this...

And this

 25-sparc64-akpm/drivers/serial/sunsu.c    |    9 ++++++---
 25-sparc64-akpm/drivers/serial/sunzilog.c |    9 +++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff -puN drivers/serial/sunsu.c~input-serio-dynamic-allocation-fix-3 drivers/serial/sunsu.c
--- 25-sparc64/drivers/serial/sunsu.c~input-serio-dynamic-allocation-fix-3	2004-06-19 23:20:15.415255216 -0700
+++ 25-sparc64-akpm/drivers/serial/sunsu.c	2004-06-19 23:23:02.148907848 -0700
@@ -1316,12 +1316,15 @@ static int __init sunsu_kbd_ms_init(void
 		up->serio.type = SERIO_RS232;
 		if (up->su_type == SU_PORT_KBD) {
 			up->serio.type |= SERIO_SUNKBD;
-			up->serio.name = "sukbd";
+			strlcpy(up->serio.name, "sukbd",
+					sizeof(up->serio.name));
 		} else {
 			up->serio.type |= (SERIO_SUN | (1 << 16));
-			up->serio.name = "sums";
+			strlcpy(up->serio.name, "sums",
+					sizeof(up->serio.name));
 		}
-		up->serio.phys = (i == 0 ? "su/serio0" : "su/serio1");
+		strlcpy(up->serio.phys, (i == 0 ? "su/serio0" : "su/serio1"),
+			sizeof(up->serio.phys));
 
 		up->serio.write = sunsu_serio_write;
 		up->serio.open = sunsu_serio_open;
diff -puN drivers/serial/sunzilog.c~input-serio-dynamic-allocation-fix-3 drivers/serial/sunzilog.c
--- 25-sparc64/drivers/serial/sunzilog.c~input-serio-dynamic-allocation-fix-3	2004-06-19 23:20:15.432252632 -0700
+++ 25-sparc64-akpm/drivers/serial/sunzilog.c	2004-06-19 23:24:48.002815608 -0700
@@ -1554,13 +1554,14 @@ static void __init sunzilog_init_kbdms(s
 	up->serio.type = SERIO_RS232;
 	if (channel == KEYBOARD_LINE) {
 		up->serio.type |= SERIO_SUNKBD;
-		up->serio.name = "zskbd";
+		strlcpy(up->serio.name, "zskbd", sizeof(up->serio.name));
 	} else {
 		up->serio.type |= (SERIO_SUN | (1 << 16));
-		up->serio.name = "zsms";
+		strlcpy(up->serio.name, "zsms", sizeof(up->serio.name));
 	}
-	up->serio.phys = (channel == KEYBOARD_LINE ?
-			  "zs/serio0" : "zs/serio1");
+	strlcpy(up->serio.phys,
+		(channel == KEYBOARD_LINE ? "zs/serio0" : "zs/serio1"),
+		sizeof(up->serio.phys));
 
 	up->serio.write = sunzilog_serio_write;
 	up->serio.open = sunzilog_serio_open;
_


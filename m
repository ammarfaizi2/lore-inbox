Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSFKBI0>; Mon, 10 Jun 2002 21:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSFKBIY>; Mon, 10 Jun 2002 21:08:24 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:61663 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315746AbSFKBIB>;
	Mon, 10 Jun 2002 21:08:01 -0400
Date: Mon, 10 Jun 2002 17:53:42 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir250_checker.diff
Message-ID: <20020610175342.F21783@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir250_checker.diff :
------------------
	o [CORRECT] Fix two bugs found by the Stanford checker in IrCOMM




diff -u -p linux/net/irda/ircomm/ircomm_core.d0.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda/ircomm/ircomm_core.d0.c	Mon Jun 10 11:28:44 2002
+++ linux/net/irda/ircomm/ircomm_core.c	Mon Jun 10 11:30:01 2002
@@ -512,7 +512,7 @@ int ircomm_proc_read(char *buf, char **s
 
 	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
 	while (self != NULL) {
-		ASSERT(self->magic == IRCOMM_MAGIC, return len;);
+		ASSERT(self->magic == IRCOMM_MAGIC, break;);
 
 		if(self->line < 0x10)
 			len += sprintf(buf+len, "ircomm%d", self->line);
diff -u -p linux/net/irda/ircomm/ircomm_tty.d0.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d0.c	Mon Jun 10 11:28:57 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Mon Jun 10 11:31:09 2002
@@ -523,6 +523,9 @@ static void ircomm_tty_close(struct tty_
 	if (!tty)
 		return;
 
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
+
 	save_flags(flags); 
 	cli();
 
@@ -533,9 +536,6 @@ static void ircomm_tty_close(struct tty_
 		IRDA_DEBUG(0, __FUNCTION__ "(), returning 1\n");
 		return;
 	}
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	if ((tty->count == 1) && (self->open_count != 1)) {
 		/*

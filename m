Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268529AbTBWTmS>; Sun, 23 Feb 2003 14:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268530AbTBWTmS>; Sun, 23 Feb 2003 14:42:18 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:37045 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268529AbTBWTmR>; Sun, 23 Feb 2003 14:42:17 -0500
Date: Sun, 23 Feb 2003 20:52:07 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: cs.c bugfix (Russell King)
Message-ID: <20030223195207.GA3227@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small bugfix to pcmcia's cs.c - without it, we end up inquiring the same 
socket all the time.

Please apply,
	Dominik

diff -ruN linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-23 20:49:56.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-23 13:12:23.000000000 +0100
@@ -360,7 +360,7 @@
 		if (j == sockets) sockets++;
 
 		init_socket(s);
-		s->ss_entry->inquire_socket(i, &s->cap);
+		s->ss_entry->inquire_socket(s->sock, &s->cap);
 #ifdef CONFIG_PROC_FS
 		if (proc_pccard) {
 			char name[3];

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDIRaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDIRaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDIRaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 13:30:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:21906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750824AbWDIRaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 13:30:39 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in drivers/scsi/sim710.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 19:30:36 +0200
Message-Id: <1144603836.22688.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #480.
Since id_array is declared as id_array[MAX_SLOTS],
the check for i>MAX_SLOTS is obviously false.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/scsi/sim710.c.orig	2006-04-09 19:25:13.000000000 +0200
+++ linux-2.6.17-rc1/drivers/scsi/sim710.c	2006-04-09 19:27:07.000000000 +0200
@@ -75,7 +75,7 @@ param_setup(char *str)
 		else if(!strncmp(pos, "id:", 3)) {
 			if(slot == -1) {
 				printk(KERN_WARNING "sim710: Must specify slot for id parameter\n");
-			} else if(slot > MAX_SLOTS) {
+			} else if(slot >= MAX_SLOTS) {
 				printk(KERN_WARNING "sim710: Illegal slot %d for id %d\n", slot, val);
 			} else {
 				id_array[slot] = val;



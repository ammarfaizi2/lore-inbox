Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUAYW1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAYW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:27:18 -0500
Received: from mail4.edisontel.com ([62.94.0.37]:60641 "EHLO
	mail4.edisontel.com") by vger.kernel.org with ESMTP id S265306AbUAYW1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:27:14 -0500
From: Eduard Roccatello <lilo@roccatello.it>
Organization: SPINE
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/ptrace.c BUG_ON fixes
Date: Sun, 25 Jan 2004 23:28:56 +0100
User-Agent: KMail/1.5.4
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oMEFAGEIMaOAghx"
Message-Id: <200401252328.56344.lilo@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oMEFAGEIMaOAghx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

ptrace.c has some references to BUG() in form

if (condition)
	BUG();

I've changed them in BUG_ON(condition);

Cheers,
Eduard Roccatello

--Boundary-00=_oMEFAGEIMaOAghx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ptrace_clean.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ptrace_clean.patch"

--- /usr/src/linux/kernel/ptrace.c.orig	2004-01-25 23:19:22.000000000 +0100
+++ /usr/src/linux/kernel/ptrace.c	2004-01-25 23:20:58.000000000 +0100
@@ -28,8 +28,8 @@
  */
 void __ptrace_link(task_t *child, task_t *new_parent)
 {
-	if (!list_empty(&child->ptrace_list))
-		BUG();
+	BUG_ON(!list_empty(&child->ptrace_list));
+
 	if (child->parent == new_parent)
 		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
@@ -46,8 +46,8 @@ void __ptrace_link(task_t *child, task_t
  */
 void __ptrace_unlink(task_t *child)
 {
-	if (!child->ptrace)
-		BUG();
+	BUG_ON(!child->ptrace);
+		
 	child->ptrace = 0;
 	if (list_empty(&child->ptrace_list))
 		return;

--Boundary-00=_oMEFAGEIMaOAghx--


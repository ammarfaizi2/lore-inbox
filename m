Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVDEFpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVDEFpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 01:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVDEFpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 01:45:17 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:749
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261510AbVDEFpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 01:45:13 -0400
Date: Mon, 4 Apr 2005 22:44:09 -0700
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH]: Fix get_compat_sigevent()
Message-Id: <20050404224409.1a34e732.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have no idea how a bug like this lasted so long.
Anyways, obvious memset()'ing of incorrect pointer.

Please apply, thanks.

Signed-off-by: David S. Miller <davem@davemloft.net>

===== kernel/compat.c 1.46 vs edited =====
--- 1.46/kernel/compat.c	2005-03-13 15:29:47 -08:00
+++ edited/kernel/compat.c	2005-04-04 22:36:13 -07:00
@@ -640,7 +640,7 @@
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event)
 {
-	memset(&event, 0, sizeof(*event));
+	memset(event, 0, sizeof(*event));
 	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
 		__get_user(event->sigev_value.sival_int,
 			&u_event->sigev_value.sival_int) ||

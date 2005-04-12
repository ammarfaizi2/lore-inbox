Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVDLKbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVDLKbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVDLKbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:52423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262105AbVDLKax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:53 -0400
Message-Id: <200504121030.j3CAUmxl005155@shell0.pdx.osdl.net>
Subject: [patch 011/198] Fix get_compat_sigevent()
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davem@davemloft.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "David S. Miller" <davem@davemloft.net>

I have no idea how a bug like this lasted so long.  Anyways, obvious
memset()'ing of incorrect pointer.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/compat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/compat.c~fix-get_compat_sigevent kernel/compat.c
--- 25/kernel/compat.c~fix-get_compat_sigevent	2005-04-12 03:21:06.070214088 -0700
+++ 25-akpm/kernel/compat.c	2005-04-12 03:21:06.074213480 -0700
@@ -640,7 +640,7 @@ long compat_sys_clock_nanosleep(clockid_
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event)
 {
-	memset(&event, 0, sizeof(*event));
+	memset(event, 0, sizeof(*event));
 	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
 		__get_user(event->sigev_value.sival_int,
 			&u_event->sigev_value.sival_int) ||
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270467AbUJTTjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270467AbUJTTjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270451AbUJTTco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:32:44 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52642
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S269186AbUJTT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:29:33 -0400
Subject: [PATCH] sunrpc: replace sleep_on_timeout()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098300093.20821.58.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 21:21:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use wait_event_timeout() instead of the obsolete sleep_on_timeout()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>
---

 2.6.9-bk-041020-thomas/net/sunrpc/clnt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN net/sunrpc/clnt.c~sunrpc net/sunrpc/clnt.c
--- 2.6.9-bk-041020/net/sunrpc/clnt.c~sunrpc	2004-10-20
15:56:37.000000000 +0200
+++ 2.6.9-bk-041020-thomas/net/sunrpc/clnt.c	2004-10-20
15:56:37.000000000 +0200
@@ -231,7 +231,8 @@ rpc_shutdown_client(struct rpc_clnt *cln
 		clnt->cl_oneshot = 0;
 		clnt->cl_dead = 0;
 		rpc_killall_tasks(clnt);
-		sleep_on_timeout(&destroy_wait, 1*HZ);
+		wait_event_timeout(destroy_wait,
+			atomic_read(&clnt->cl_users) > 0, 1*HZ);
 	}
 
 	if (atomic_read(&clnt->cl_users) < 0) {
_



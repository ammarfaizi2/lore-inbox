Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031388AbWKUUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031388AbWKUUU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031390AbWKUUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:20:27 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:40126 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1031388AbWKUUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:20:26 -0500
Date: Tue, 21 Nov 2006 12:20:19 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 smpboot: remove unused variable
In-Reply-To: <BAY107-F1209C38A8D8079599E1ECF9CEC0@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611211218180.25455@attu4.cs.washington.edu>
References: <BAY107-F1209C38A8D8079599E1ECF9CEC0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused bound variable in sync_tsc().

Reported by D Binderman <dcb314@hotmail.com>.

Cc: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@redhat.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/x86_64/kernel/smpboot.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index 62c2e74..6bc0ec5 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -271,7 +271,7 @@ static __cpuinit void sync_tsc(unsigned 
 {
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
-	unsigned long flags, rt, master_time_stamp, bound;
+	unsigned long flags, rt, master_time_stamp;
 #ifdef DEBUG_TSC_SYNC
 	static struct syncdebug {
 		long rt;	/* roundtrip time */
@@ -300,11 +300,8 @@ #endif
 	{
 		for (i = 0; i < NUM_ROUNDS; ++i) {
 			delta = get_delta(&rt, &master_time_stamp);
-			if (delta == 0) {
+			if (delta == 0)
 				done = 1;	/* let's lock on to this... */
-				bound = rt;
-			}
-
 			if (!done) {
 				unsigned long t;
 				if (i > 0) {

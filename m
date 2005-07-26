Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVGZRx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVGZRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVGZRvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:51:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34951 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261960AbVGZRt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:49:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/23] Call emergency_reboot from panic
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
	<m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
	<m1wtndcvwe.fsf_-_@ebiederm.dsl.xmission.com>
	<m1sly1cvnd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1oe8pcvii.fsf_-_@ebiederm.dsl.xmission.com>
	<m1k6jdcvgk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:49:23 -0600
In-Reply-To: <m1fyu1cvd7.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:47:32 -0600")
Message-ID: <m1br4pcva4.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We know the system is in trouble so there is no question if this
is an emergecy :)

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 kernel/panic.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

fd248dd54c86f633bd2618d8c475c39465f8d552
diff --git a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -111,12 +111,11 @@ NORET_TYPE void panic(const char * fmt, 
 			mdelay(1);
 			i++;
 		}
-		/*
-		 *	Should we run the reboot notifier. For the moment Im
-		 *	choosing not too. It might crash, be corrupt or do
-		 *	more harm than good for other reasons.
+		/*	This will not be a clean reboot, with everything
+		 *	shutting down.  But if there is a chance of
+		 *	rebooting the system it will be rebooted.
 		 */
-		machine_restart(NULL);
+		emergency_restart();
 	}
 #ifdef __sparc__
 	{

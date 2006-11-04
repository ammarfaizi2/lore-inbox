Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965546AbWKDQt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965546AbWKDQt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965547AbWKDQt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 11:49:28 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48257 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S965546AbWKDQt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 11:49:28 -0500
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: ipc/msg.c "cleanup" breaks fakeroot on Alpha
From: Falk Hueffner <falk@debian.org>
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
Date: Sat, 04 Nov 2006 17:49:26 +0100
Message-ID: <87d583f97t.fsf@debian.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this hunk

commit 5a06a363ef48444186f18095ae1b932dddbbfa89
Author: Ingo Molnar <mingo@elte.hu>
Date:   Sun Jul 30 03:04:11 2006 -0700

    [PATCH] ipc/msg.c: clean up coding style
    
    Clean up ipc/msg.c to conform to Documentation/CodingStyle.  (before it was
    an inconsistent hodepodge of various coding styles)
    
    Verified that the before/after .o's are identical.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/ipc/msg.c b/ipc/msg.c
index cd92d34..2b4fccf 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -47,12 +47,12 @@
 struct msg_receiver {
 	struct list_head	r_list;
 	struct task_struct	*r_tsk;
 
 	int			r_mode;
 	long			r_msgtype;
 	long			r_maxsize;
 
-	struct msg_msg* volatile r_msg;
+	volatile struct msg_msg	*r_msg;
 };
 
breaks fakeroot on Alpha (variously hangs or oopses). Backing it out
of 2.6.19-rc4 fixes the issue. Is it possible that this change (which
clearly does change semantics) was made in error?

-- 
	Falk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWAFOT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWAFOT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWAFOT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:19:27 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44102 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751447AbWAFOT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:19:26 -0500
Message-ID: <43BE7C76.6040402@sw.ru>
Date: Fri, 06 Jan 2006 17:19:34 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] oom kill of current task
Content-Type: multipart/mixed;
 boundary="------------030405020308070505090003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030405020308070505090003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When oom_killer kills current there's no need
to call schedule_timeout_interruptible() since task
must die ASAP.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

P.S. against 2.6.15


--------------030405020308070505090003
Content-Type: text/plain;
 name="diff-ms-oomkill-suicide-exit-20060106"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-oomkill-suicide-exit-20060106"

--- ./mm/oom_kill.c.oomkill	2006-01-06 15:16:45.000000000 +0300
+++ ./mm/oom_kill.c	2006-01-06 15:19:21.130652864 +0300
@@ -298,7 +298,8 @@ retry:
 
 	/*
 	 * Give "p" a good chance of killing itself before we
-	 * retry to allocate memory.
+	 * retry to allocate memory unless "p" is current
 	 */
-	schedule_timeout_interruptible(1);
+	if (!test_thread_flag(TIF_MEMDIE))
+		schedule_timeout_interruptible(1);
 }


--------------030405020308070505090003--


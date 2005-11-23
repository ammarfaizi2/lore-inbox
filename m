Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKWNJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKWNJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVKWNJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:09:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35295 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750773AbVKWNJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:09:39 -0500
Message-ID: <43847B85.4B97A782@tv-sign.ru>
Date: Wed, 23 Nov 2005 17:24:05 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kill_proc_info_as_uid: don't use hardcoded constants
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use symbolic names instead of hardcoded constants.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/kernel/signal.c~1_KUID	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15-rc2/kernel/signal.c	2005-11-23 19:17:35.000000000 +0300
@@ -1163,8 +1163,7 @@ int kill_proc_info_as_uid(int sig, struc
 		ret = -ESRCH;
 		goto out_unlock;
 	}
-	if ((!info || ((unsigned long)info != 1 &&
-			(unsigned long)info != 2 && SI_FROMUSER(info)))
+	if ((info == SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSER(info)))
 	    && (euid != p->suid) && (euid != p->uid)
 	    && (uid != p->suid) && (uid != p->uid)) {
 		ret = -EPERM;

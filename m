Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVHOByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVHOByE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 21:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVHOByD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 21:54:03 -0400
Received: from everest.sosdg.org ([66.93.203.161]:49799 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S932627AbVHOByD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 21:54:03 -0400
Date: Sun, 14 Aug 2005 20:53:57 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: akpm@osdl.org
Cc: mikew@google.com, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: [patch] unexport __mntput()
Message-ID: <20050815015357.GA16778@everest.sosdg.org>
Reply-To: coywolf@sosdg.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Unexport __mntput() was talked about two months ago. http://lkml.org/lkml/2005/6/9/69
Modules should not call __mntput() directly. If autofs or nfsd does that, it's
 being wrong.

		Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@sosdg.org>
--- 2.6.13-rc6/fs/namespace.c~unexport-__mntput	2005-08-12 08:21:22.000000000 -0500
+++ 2.6.13-rc6/fs/namespace.c	2005-08-14 20:32:01.000000000 -0500
@@ -180,8 +180,6 @@
 	deactivate_super(sb);
 }
 
-EXPORT_SYMBOL(__mntput);
-
 /* iterator */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {

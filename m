Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRB0NF2>; Tue, 27 Feb 2001 08:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRB0NFS>; Tue, 27 Feb 2001 08:05:18 -0500
Received: from janeway.cistron.net ([195.64.65.23]:35844 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S129191AbRB0NFB>; Tue, 27 Feb 2001 08:05:01 -0500
Date: Tue, 27 Feb 2001 14:03:33 +0100
From: Ivo Timmermans <irt@cistron.nl>
To: linux-kernel@vger.kernel.org
Subject: binfmt_script and ^M
Message-ID: <20010227140333.C20415@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running a script (perl in this case) that has DOS-style newlines
(\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
recognize the \r.  The following patch should fix this (untested).

Please Cc me on replies, I'm not on this list.  Thanks.


--- binfmt_script.c~	Mon Feb 26 17:42:09 2001
+++ binfmt_script.c	Tue Feb 27 13:39:47 2001
@@ -36,6 +36,8 @@
 	bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
 	if ((cp = strchr(bprm->buf, '\n')) == NULL)
 		cp = bprm->buf+BINPRM_BUF_SIZE-1;
+	if (cp - 1 == '\r')
+	  cp--;
 	*cp = '\0';
 	while (cp > bprm->buf) {
 		cp--;

-- 
Ivo Timmermans

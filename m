Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTJFRBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTJFRA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:00:29 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:4879 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264027AbTJFQ6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:58:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] lib/parser: Not recognize nul string as "%s" (6/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:58:47 +0900
Message-ID: <87wubinvzs.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Current match_token recognize "foo=" as "foo=%s". So this change the
nul string does not recognize as "%s".

(Umm... this should be check by caller?)



 linux-2.6.0-test6-hirofumi/lib/parser.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN lib/parser.c~parser-zero-string lib/parser.c
--- linux-2.6.0-test6/lib/parser.c~parser-zero-string	2003-10-07 01:51:51.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/lib/parser.c	2003-10-07 01:51:51.000000000 +0900
@@ -45,7 +45,9 @@ static int match_one(char *s, char *p, s
 		args[argc].from = s;
 		switch (*p++) {
 		case 's':
-			if (len == -1 || len > strlen(s))
+			if (strlen(s) == 0)
+				return 0;
+			else if (len == -1 || len > strlen(s))
 				len = strlen(s);
 			args[argc].to = s + len;
 			break;

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

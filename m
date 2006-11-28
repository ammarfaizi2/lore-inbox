Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757549AbWK1WPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbWK1WPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757574AbWK1WPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:15:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:41226 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757565AbWK1WPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:15:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kqyk0g+BPr7Xgna75tY8/5xDaCOJqWfLAvc0IEI/XsAJwKNvU7t3tVTQPwMzYYZjUr2GbYoZyDuKpCinvl3OOJk3PE512ZAv2OAwSVn1hKR2b8j3qRJlYmrgBhOfEWY2QKJ5mZHfHXte3CYX/Fk07F51i7/iPu50bksurXGAYFM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
Date: Tue, 28 Nov 2006 23:17:13 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       trivial@kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611282317.14020.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In kernel/sys.c::sys_prctl() the argument named 'arg2' is very clearly 
of type 'unsigned long', and when compiling with "gcc -W" gcc also warns :
  kernel/sys.c:2089: warning: comparison of unsigned expression < 0 is always false

So this patch removes the test of "arg2 < 0".

For those of us who compile their kernels with "-W" this gets rid of an 
annoying warning. For the rest of you it saves a few bytes of source code ;-)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/kernel/sys.c b/kernel/sys.c
index 98489d8..086ea37 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2086,7 +2086,7 @@ asmlinkage long sys_prctl(int option, un
 			error = current->mm->dumpable;
 			break;
 		case PR_SET_DUMPABLE:
-			if (arg2 < 0 || arg2 > 1) {
+			if (arg2 > 1) {
 				error = -EINVAL;
 				break;
 			}



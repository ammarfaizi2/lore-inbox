Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVH2Rx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVH2Rx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVH2Rx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:53:27 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:5294 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751179AbVH2Rx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:53:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NV+Nygj2ueCEfaC6FQT/7MjmhU7FvCTJ10wZm0gj1bDRvueUiUl6/6DjDoCTh1ITVV6jIpAbXdV5Ktmz0a5+laNm2D5DcCLHOFMmVXhVCKE8Po/sQXdM8Jg7rW5O7OXPg2UvvNcPC9/uF9vU9HRqTtcwphsI+s7Z+71qDXQEkfk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Zankel <chris@zankel.net>
Subject: We also need to get rid of verify_area in entry.S
Date: Mon, 29 Aug 2005 19:54:26 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508291954.27026.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

In addition to the patch I sent a few minutes ago, there's one last reference
to verify_area left in xtensa. It's in arch/xtensa/kernel/entry.S, and I'm 
going to need your help to get rid of that one since that code is over my head
and I assume that the naive approach below would just break it : 

diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/arch/xtensa/kernel/entry.S linux-2.6.13/arch/xtensa/kernel/entry.S
--- linux-2.6.13-orig/arch/xtensa/kernel/entry.S	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/arch/xtensa/kernel/entry.S	2005-08-29 03:48:43.000000000 +0200
@@ -1102,7 +1102,7 @@ ENTRY(fast_syscall_sysxtensa)
 	s32i	a7, a2, PT_AREG7
 
 	movi	a7, 4			# sizeof(unsigned int)
-	verify_area a3, a7, a0, a2, .Leac
+	access_ok a3, a7, a0, a2, .Leac
 
 	_beqi	a6, SYSXTENSA_ATOMIC_SET, .Lset
 	_beqi	a6, SYSXTENSA_ATOMIC_EXG_ADD, .Lexg

So, could you come up with a working patch and push it to Andrew along with the
one I sent a little while ago, so I can push my verify_area removal patches? Or
you can just sign off on my previous patch if it's OK, and send me one for 
entry.S and then I'll push the entire thing onwards if you prefer that.
Thanks in advance.


-- 
 Jesper Juhl



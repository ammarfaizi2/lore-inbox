Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUL2Twf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUL2Twf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUL2Twf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:52:35 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:3938 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261407AbUL2Twb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:52:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nfKs2Gta5snUtkb1t/N4ItZHqCRGbreQ1cVXRY5i6V44o7ZdrZWq/Sx3H5FFfNS0tyzJTasAdwKwlHuwAwZKtxOiHgG19jV93/mZreMS3cpC+4tzKWtVTmpeHS2QABvaqjDgO4pNARXNRvbJSZe1yJsYoRWAZkmdB1kJbAlBgfs=
Message-ID: <2cd57c9004122911523fe7a71b@mail.gmail.com>
Date: Thu, 30 Dec 2004 03:52:30 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: akpm@osdl.org
Subject: Re: [patch] fix sparc64 cpu_idle()
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       James.Bottomley@hansenpartnership.com, paulus@samba.org,
       davem@davemloft.net, lethal@linux-sh.org, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, takata@linux-m32r.org, ak@suse.de,
       rth@twiddle.net, matthew@wil.cx, wli@holomorphy.com
In-Reply-To: <2cd57c9004122911073dea0d2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41D033FE.7AD17627@tv-sign.ru>
	 <20041227160848.GC771@holomorphy.com>
	 <2cd57c9004122911073dea0d2c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sparc and sparc64's UP cpu_idel() checks current pid. This
is paranoia.
 
Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>

 sparc/kernel/process.c   |   10 +---------
 sparc64/kernel/process.c |    6 +-----
 2 files changed, 2 insertions(+), 14 deletions(-)

diff -Nurp 2.6.10/arch/sparc/kernel/process.c
2.6.10-cy/arch/sparc/kernel/process.c
--- 2.6.10/arch/sparc/kernel/process.c	2004-12-29 01:27:57.000000000 +0800
+++ 2.6.10-cy/arch/sparc/kernel/process.c	2004-12-30 03:41:53.000000000 +0800
@@ -81,13 +81,8 @@ void default_idle(void)
 /*
  * the idle loop on a Sparc... ;)
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
-	int ret = -EPERM;
-
-	if (current->pid != 0)
-		goto out;
-
 	/* endless idle loop with no priority at all */
 	for (;;) {
 		if (ARCH_SUN4C_SUN4) {
@@ -128,9 +123,6 @@ int cpu_idle(void)
 		schedule();
 		check_pgt_cache();
 	}
-	ret = 0;
-out:
-	return ret;
 }
 
 #else
diff -Nurp 2.6.10/arch/sparc64/kernel/process.c
2.6.10-cy/arch/sparc64/kernel/process.c
--- 2.6.10/arch/sparc64/kernel/process.c	2004-12-30 02:52:40.000000000 +0800
+++ 2.6.10-cy/arch/sparc64/kernel/process.c	2004-12-30 02:57:40.000000000 +0800
@@ -60,11 +60,8 @@ void default_idle(void)
 /*
  * the idle loop on a Sparc... ;)
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
-	if (current->pid != 0)
-		return -EPERM;
-
 	/* endless idle loop with no priority at all */
 	for (;;) {
 		/* If current->work.need_resched is zero we should really
@@ -80,7 +77,6 @@ int cpu_idle(void)
 		schedule();
 		check_pgt_cache();
 	}
-	return 0;
 }
 
 #else



-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/

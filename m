Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJ0RRK>; Sat, 27 Oct 2001 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJ0RRB>; Sat, 27 Oct 2001 13:17:01 -0400
Received: from zero.tech9.net ([209.61.188.187]:4363 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S273261AbRJ0RQs>;
	Sat, 27 Oct 2001 13:16:48 -0400
Subject: Re: 2.4.14-pre3: some compilerwarnings...
From: Robert Love <rml@tech9.net>
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>, torvalds@transmeta.com
Cc: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20011027185158.A5848@Zenith.starcenter>
In-Reply-To: <20011027185158.A5848@Zenith.starcenter>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 13:16:23 -0400
Message-Id: <1004202984.3274.53.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-27 at 12:51, Sven Vermeulen wrote:
> A little grep on the stdout/stderr of "make bzImage":

You can't do much about unused variables because, as you suggested, they
may be present with a different config.  For example, the unused
attach_it label in super.c is used if NFS is defined.

As for the typecast error, we should fix that...the attached patch uses
the typed min system macro.  Linus, the attached is against
2.4.14-pre3.  Please, apply.

diff -u linux-2.4.14-pre3/drivers/char/random.c linux/drivers/char/random.c
--- linux-2.4.14-pre3/drivers/char/random.c	Sat Oct 27 13:13:03 2001
+++ linux/drivers/char/random.c	Sat Oct 27 13:13:52 2001
@@ -1245,8 +1245,9 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min(r->poolinfo.poolwords - r->entropy_count/32,
-				 sizeof(tmp) / 4);
+		int nwords = min_t(int,
+				   r->poolinfo.poolwords - r->entropy_count/32,
+				   sizeof(tmp) / 4);
 
 		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
 			  nwords * 32,


	Robert Love


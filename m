Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSECKnB>; Fri, 3 May 2002 06:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSECKnA>; Fri, 3 May 2002 06:43:00 -0400
Received: from pat.uio.no ([129.240.130.16]:38904 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315627AbSECKm7>;
	Fri, 3 May 2002 06:42:59 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.13: link failure
In-Reply-To: <20020503111617.B4319@flint.arm.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 May 2002 12:42:43 +0200
Message-ID: <shsd6wdjyvw.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Russell King <rmk@arm.linux.org.uk> writes:

     > 2.5.13 with root nfs enabled doesn't link:
     > fs/fs.o: In function `root_nfs_getport':
     > fs/fs.o(.text.init+0x187c): undefined reference to `in_ntoa'

     > I haven't looked into this one yet.

Nothing serious. Whoever it was that did that global replace missed a
spot is all...

Cheers,
  Trond

--- linux-2.5.13/fs/nfs/nfsroot.c.orig	Fri May  3 02:22:55 2002
+++ linux-2.5.13/fs/nfs/nfsroot.c	Fri May  3 12:39:18 2002
@@ -374,8 +374,8 @@
 {
 	struct sockaddr_in sin;
 
-	printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-		program, version, in_ntoa(servaddr));
+	printk(KERN_NOTICE "Looking up port of RPC %d/%d on %u.%u.%u.%u\n",
+		program, version, NIPQUAD(servaddr));
 	set_sockaddr(&sin, servaddr, 0);
 	return rpc_getport_external(&sin, program, version, proto);
 }


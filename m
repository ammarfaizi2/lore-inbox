Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSEDCAn>; Fri, 3 May 2002 22:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315763AbSEDCAm>; Fri, 3 May 2002 22:00:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315762AbSEDCAl>;
	Fri, 3 May 2002 22:00:41 -0400
Date: Fri, 03 May 2002 18:48:41 -0700 (PDT)
Message-Id: <20020503.184841.64937487.davem@redhat.com>
To: jamagallon@able.es
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: undefined reference to `in_ntoa'
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020504015655.GA8544@werewolf.able.es>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "J.A. Magallon" <jamagallon@able.es>
   Date: Sat, 4 May 2002 03:56:55 +0200

   
   It is only used in fs/nfs/nfsroot.c, and never defined (grep -r just shows that).

I've sent Marcelo the following fix for this already.
Sorry about that.

--- fs/nfs/nfsroot.c.~2~	Fri May  3 13:56:10 2002
+++ fs/nfs/nfsroot.c	Fri May  3 13:56:30 2002
@@ -343,8 +343,8 @@
 {
 	struct sockaddr_in sin;
 
-	printk(KERN_NOTICE "Looking up port of RPC %d/%d on %s\n",
-		program, version, in_ntoa(servaddr));
+	printk(KERN_NOTICE "Looking up port of RPC %d/%d on %u.%u.%u.%u\n",
+		program, version, NIPQUAD(servaddr));
 	set_sockaddr(&sin, servaddr, 0);
 	return rpc_getport_external(&sin, program, version, proto);
 }

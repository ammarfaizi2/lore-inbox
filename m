Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318254AbSHMRi1>; Tue, 13 Aug 2002 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSHMRi1>; Tue, 13 Aug 2002 13:38:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61352 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318254AbSHMRh7>;
	Tue, 13 Aug 2002 13:37:59 -0400
Date: Tue, 13 Aug 2002 10:27:37 -0700 (PDT)
Message-Id: <20020813.102737.04335380.davem@redhat.com>
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.4.20-pre2 NFS OOPS on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
References: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Meelis Roos <mroos@linux.ee>
   Date: Tue, 13 Aug 2002 19:21:30 +0300 (EEST)

   2 oopses from stock 2.4.20-pre2 during NFS startup 9mountd etc killed as
   a result). Looks like a bad use of bitops inside sunrpc. egcs64 compiler
   from debian.
   
Neil, sk_flags in struct svc_sock may not be an int, bitops require
"long".

--- include/linux/sunrpc/svcsock.h.~1~	Tue Aug 13 10:37:10 2002
+++ include/linux/sunrpc/svcsock.h	Tue Aug 13 10:37:15 2002
@@ -22,7 +22,7 @@
 
 	struct svc_serv *	sk_server;	/* service for this socket */
 	unsigned char		sk_inuse;	/* use count */
-	unsigned int		sk_flags;
+	unsigned long		sk_flags;
 #define	SK_BUSY		0			/* enqueued/receiving */
 #define	SK_CONN		1			/* conn pending */
 #define	SK_CLOSE	2			/* dead or dying */

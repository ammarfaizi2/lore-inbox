Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCPBCc>; Fri, 15 Mar 2002 20:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCPBCX>; Fri, 15 Mar 2002 20:02:23 -0500
Received: from mail.bstc.net ([63.90.24.2]:35089 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S293632AbSCPBCK>;
	Fri, 15 Mar 2002 20:02:10 -0500
Date: Sat, 16 Mar 2002 12:00:21 +1100
From: Anton Blanchard <anton@samba.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bit ops on unsigned long?
Message-ID: <20020316010021.GD3280@krispykreme>
In-Reply-To: <E16m2Qu-0007mc-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16m2Qu-0007mc-00@wagner.rustcorp.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	nfs is broken in 2.5 ATM because it does set_bit on an "int".
> Can be *please* just bite the bullet and change the prototype on these
> ops so we stop seeing the same mistakes over and over?

I present to you Exhibit A:

diff -urN linux-2.5/include/linux/sunrpc/svcsock.h linux-2.5_tmp/include/linux/sunrpc/svcsock.h
--- linux-2.5/include/linux/sunrpc/svcsock.h	Tue Mar  5 11:45:35 2002
+++ linux-2.5_tmp/include/linux/sunrpc/svcsock.h	Sat Mar 16 11:41:02 2002
@@ -22,7 +22,7 @@
 
 	struct svc_serv *	sk_server;	/* service for this socket */
 	unsigned char		sk_inuse;	/* use count */
-	unsigned int		sk_flags;
+	unsigned long		sk_flags;
 #define	SK_BUSY		0			/* enqueued/receiving */
 #define	SK_CONN		1			/* conn pending */
 #define	SK_CLOSE	2			/* dead or dying */

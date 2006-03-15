Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWCOBP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWCOBP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCOBP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:15:57 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:24472 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S932179AbWCOBP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:15:56 -0500
Date: Wed, 15 Mar 2006 11:11:32 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Valdis.Kletnieks@vt.edu, Adrian Bunk <bunk@stusta.de>, davem@davemloft.net,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] crypto/aes.c: array overrun
Message-ID: <20060315011132.GA28323@beast>
References: <20060311010339.GF21864@stusta.de> <20060311024116.GA21856@gondor.apana.org.au> <200603142025.k2EKP8Z4010175@turing-police.cc.vt.edu> <20060314225448.GA27285@beast> <20060315003212.GA20843@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20060315003212.GA20843@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Jivin Herbert Xu lays it down ...
> On Wed, Mar 15, 2006 at 08:54:48AM +1000, David McCullough wrote:
> >  
> >  struct aes_ctx {
> >  	int key_length;
> > -	u32 E[60];
> > -	u32 D[60];
> > +	u32 _KEYS[120];
> >  };
> 
> Looks good.  Thanks for this David.
> 
> Could you please change the name from _KEYS to buf and patch the x86-64
> version as well?

No problems, attached.

Cheers,
Davidm

-- 
David McCullough, david_mccullough@au.securecomputing.com, Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aes2.diff"

Index: linux-2.6.x/crypto/aes.c
===================================================================
RCS file: linux-2.6.x/crypto/aes.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 aes.c
--- linux-2.6.x/crypto/aes.c	31 Aug 2005 00:33:03 -0000	1.1.1.6
+++ linux-2.6.x/crypto/aes.c	15 Mar 2006 01:09:37 -0000
@@ -78,12 +78,11 @@
 
 struct aes_ctx {
 	int key_length;
-	u32 E[60];
-	u32 D[60];
+	u32 buf[120];
 };
 
-#define E_KEY ctx->E
-#define D_KEY ctx->D
+#define E_KEY (&ctx->buf[0])
+#define D_KEY (&ctx->buf[60])
 
 static u8 pow_tab[256] __initdata;
 static u8 log_tab[256] __initdata;
Index: linux-2.6.x/arch/x86_64/crypto/aes.c
===================================================================
RCS file: linux-2.6.x/arch/x86_64/crypto/aes.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 aes.c
--- linux-2.6.x/arch/x86_64/crypto/aes.c	31 Aug 2005 00:33:07 -0000	1.1.1.1
+++ linux-2.6.x/arch/x86_64/crypto/aes.c	15 Mar 2006 01:09:37 -0000
@@ -79,12 +79,11 @@
 struct aes_ctx
 {
 	u32 key_length;
-	u32 E[60];
-	u32 D[60];
+	u32 buf[120];
 };
 
-#define E_KEY ctx->E
-#define D_KEY ctx->D
+#define E_KEY (&ctx->buf[0])
+#define D_KEY (&ctx->buf[60])
 
 static u8 pow_tab[256] __initdata;
 static u8 log_tab[256] __initdata;

--jRHKVT23PllUwdXP--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTB1AvP>; Thu, 27 Feb 2003 19:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbTB1AvP>; Thu, 27 Feb 2003 19:51:15 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:35344 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267346AbTB1AvP>; Thu, 27 Feb 2003 19:51:15 -0500
Date: Fri, 28 Feb 2003 12:01:10 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: latten@austin.ibm.com
cc: davem@redhat.com, <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: PATCH: IPSec not using padding when Null Encryption
In-Reply-To: <200302272129.h1RLTJW28434@faith.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0302281159400.24571-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003 latten@austin.ibm.com wrote:

> I have tested it. Please let me know if all is well. 

Looks fine to me.

(Perhaps change the name of the blksize variable to padto or similar, in 
case someone later thinks it's the real block size).

> --- esp.c.orig	2003-02-20 16:07:59.000000000 -0600
> +++ esp.c	2003-02-27 10:30:25.000000000 -0600
> @@ -360,7 +360,7 @@
>  	esp = x->data;
>  	alen = esp->auth.icv_trunc_len;
>  	tfm = esp->conf.tfm;
> -	blksize = crypto_tfm_alg_blocksize(tfm);
> +	blksize = (crypto_tfm_alg_blocksize(tfm) + 3) & ~3;
>  	clen = (clen + 2 + blksize-1)&~(blksize-1);
>  	if (esp->conf.padlen)
>  		clen = (clen + esp->conf.padlen-1)&~(esp->conf.padlen-1);
> 

-- 
James Morris
<jmorris@intercode.com.au>



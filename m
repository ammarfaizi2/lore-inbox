Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVGCMPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVGCMPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 08:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVGCMPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 08:15:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3013 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261400AbVGCMPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 08:15:41 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/5] 1.be_le.patch
Date: Sun, 3 Jul 2005 15:15:28 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
References: <200506201359.23211.vda@ilport.com.ua> <20050703114111.GB4848@gondor.apana.org.au>
In-Reply-To: <20050703114111.GB4848@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507031515.29022.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 14:41, Herbert Xu wrote:
> On Mon, Jun 20, 2005 at 01:59:23PM +0300, Denis Vlasenko wrote:
> >
> > @@ -265,10 +263,10 @@ aes_set_key(void *ctx_arg, const u8 *in_
> >  
> >  	ctx->key_length = key_len;
> >  
> > -	E_KEY[0] = u32_in (in_key);
> > -	E_KEY[1] = u32_in (in_key + 4);
> > -	E_KEY[2] = u32_in (in_key + 8);
> > -	E_KEY[3] = u32_in (in_key + 12);
> > +	E_KEY[0] = load_le32(in_key,0);
> > +	E_KEY[1] = load_le32(in_key,1);
> > +	E_KEY[2] = load_le32(in_key,2);
> > +	E_KEY[3] = load_le32(in_key,3);
> 
> Please insert a space after the comma.

The second param is an index in implicit vector.
Sably store_xxx and load_xxx syntax makes that non-obvious.

I deliberately did not put space there, trying to
give reader a hint that "dst,n" part is really
"dst[n]":

	store_le32(dst,0, a);		// like "dst[0] = a" but with (u32*) cast on dst + le32 conversion on a
	store_le32(dst,1, b);

Do you still want space added?
--
vda


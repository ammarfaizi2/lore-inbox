Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUBTToq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUBTTlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:11 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:3462 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261383AbUBTTS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:18:26 -0500
Date: Fri, 20 Feb 2004 14:09:26 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@intercode.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040220190926.GB9980@certainkey.com>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040220185340.GA14358@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220185340.GA14358@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 07:53:41PM +0100, Christophe Saout wrote:
> On Fri, Feb 20, 2004 at 12:14:27PM -0500, Jean-Luc Cooke wrote:
> 
> > > > It simply hashes the sector number and the key and uses it as IV.
> > > > 
> > > > You can specify the encryption mode as "cipher-digest" like aes-md5 or
> > > > serpent-sha1 or some other combination.
> > 
> > As for naming the cipher-hash as "aes-sha256", why not just go all the way
> > and specify the mode of operation as well?
> > 
> > cipher-hash-modeop example: aes-sha256-cbc
> 
> The plan was to du <cipher>-<iv mode> where <iv mode> can be
> ecb (well, no IV at all), plain (unhashed sector number) or a
> digest (hmac_key sector number). CBC mode is implicit when you
> have some kind of IV generation. Everything else doesn't make
> sense and would be redundant. CFB and CTR are not implemented
> by cryptoloop BTW.

jlcooke:~/kern/linux-2.6.1/crypto$ grep CTR *.c
cipher.c:       case CRYPTO_TFM_MODE_CTR:
grep CFB *.c
cipher.c:       case CRYPTO_TFM_MODE_CFB:

It should be I wrote it...the crypto part anyways.

> > As for hashing the hey etc.  You should be using HMAC for that.
> >   Christophe - would you like to change your patch to use HMACs?
> 
> Yes, I alread got that suggestion.

Ok good then thanks.

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUFPCFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUFPCFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUFPCFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:05:21 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:32963 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266065AbUFPCFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:05:04 -0400
Date: Tue, 15 Jun 2004 22:04:41 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RSA
Message-ID: <20040616020441.GA12610@escher.cs.wm.edu>
References: <20040615235409.GA12186@escher.cs.wm.edu> <20040616002204.61941.qmail@web41101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616002204.61941.qmail@web41101.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In essence for a digsig module you'll require the ability to 
> 
> 1.  import a PK key [from a binary packet or a cert, preferably the
> former].

Parsing a certificate into precisely the format needed by cryptoapi
will be a task for user-space.  At least that was our plan.  Cryptoapi
can check for validity and return -EINVAL if there's a problem, but
shouldn't have to do any complicated parsing.

> 2.  free a PK key from memory (no need to waste dynamic resources like
> bignums while not being used).
> 3.  ability to sign/verify/encrypt/decrypt which amounts to a exptmod
> and PKCS #1 [v2.0 preferably] padding.

where
	sign = private_encrypt (setkey(privkey); encrypt();)
	verify = public_decrypt (setkey(pubkey); decrypt();)
	encrypt = public_encrypt (setkey(pubkey); encrypt();)
	decrypt = private_decrypt (setkey_privkey(); decrypt();)
so thus far the cipher tfm and algs suffice.

> An API exactly mirroring the symmetric side won't really work 100%. 
> For instance, symmetric operations are not likely to fail [I don't know
> how error handling is performed].  Also decrypt/verify ops may fail
> hard [due to lack of heap] or soft [invalid packet].
>
> It would probably make more sense to design a simple API for PK crypto
> [say support RSA/ECC/DH/DSA ;-)] then to mash the symmetric crypto API
> into something compatible.

Wow.  Death due to a lack of heap was not something I had considered.

So, since the include/linux/crypto.h:cipher_alg struct's encrypt and decrypt
functions return void, we may need to create a assymetric_alg struct whose
functions can return an error.

> What I propose is we can port LibTomCrypt's [by stripping out stuff
> that isn't required like symmetric crypto] PK code to a kernel module
> to be released under the GPL.  Since the code is already public domain
> [and I personally wrote all of the relevent code myself == no copyright
> issues] there shouldn't be any problems with this.
>
> As I said I'm not really a kernel-coder.  Actually just recently I've
> moved from 2.4.26 to 2.6.6.  So mostly I'd like to see someone else
> head up this task and I'd provide help porting LibTomCrypt.

Thanks, Tom.  This is precisely what we were hoping.

thanks,
-serge

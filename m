Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266033AbUFPAWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUFPAWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUFPAWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:22:10 -0400
Received: from web41101.mail.yahoo.com ([66.218.93.17]:41612 "HELO
	web41101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266033AbUFPAWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:22:05 -0400
Message-ID: <20040616002204.61941.qmail@web41101.mail.yahoo.com>
Date: Tue, 15 Jun 2004 17:22:04 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: RSA
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040615235409.GA12186@escher.cs.wm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> (repeating a privately posted question for all to respond)
> 
> Is a separate generic assymetric crypto API really necessary?

It depends on how the symmetric crypto API has been implemented
[warning: I'm a kernel looking-at-code newbie so I'm just chiming in my
crypto two cents ;-)].

> The cryptoapi usage model is to do a setkey before any encrypt or
> decrypt.
> The setkey will be done with either a public or private key.  So
> there is no
> need to have a public_key_alg with separate public_encrypt and
> private_encrypt functions, as this distinction is implied at the
> setkey
> time.  So our plan was to just add another crypto_alg for rsa_1024.

In essence for a digsig module you'll require the ability to 

1.  import a PK key [from a binary packet or a cert, preferably the
former].
2.  free a PK key from memory (no need to waste dynamic resources like
bignums while not being used).
3.  ability to sign/verify/encrypt/decrypt which amounts to a exptmod
and PKCS #1 [v2.0 preferably] padding.

An API exactly mirroring the symmetric side won't really work 100%. 
For instance, symmetric operations are not likely to fail [I don't know
how error handling is performed].  Also decrypt/verify ops may fail
hard [due to lack of heap] or soft [invalid packet].

It would probably make more sense to design a simple API for PK crypto
[say support RSA/ECC/DH/DSA ;-)] then to mash the symmetric crypto API
into something compatible.

On a side note I've been contacted about my interest in making this
happen [hence my reply here].  I'm offering my public domain
LibTomCrypt [and indirectly LibTomMath] for the task.  Currently I'm
working on reducing the stack usage in LibTomCrypt's PK operations.

What I propose is we can port LibTomCrypt's [by stripping out stuff
that isn't required like symmetric crypto] PK code to a kernel module
to be released under the GPL.  Since the code is already public domain
[and I personally wrote all of the relevent code myself == no copyright
issues] there shouldn't be any problems with this.

As I said I'm not really a kernel-coder.  Actually just recently I've
moved from 2.4.26 to 2.6.6.  So mostly I'd like to see someone else
head up this task and I'd provide help porting LibTomCrypt.

Tom


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUGZTo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUGZTo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGZTo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:44:56 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:35481 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S265732AbUGZShg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:37:36 -0400
Message-ID: <41054966.2D74437E@users.sourceforge.net>
Date: Mon, 26 Jul 2004 21:11:50 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1091709927.ed82@endorphin.org>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
			<1090672906.8587.66.camel@ghanima>
			<41039CAC.965AB0AA@users.sourceforge.net>
			<1090761870.10988.71.camel@ghanima>
			<4103ED18.FF2BC217@users.sourceforge.net>
			<1090778567.10988.375.camel@ghanima>
			<4104E2CC.D8CBA56@users.sourceforge.net> <1090845926.13338.98.camel@ghanima>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> On Mon, 2004-07-26 at 12:54, Jari Ruusu wrote:
> > Fruhwirth Clemens wrote:
> > > On Sun, 2004-07-25 at 19:25, Jari Ruusu wrote:
> > > > In short: exploit encodes watermark patterns as sequences of identical
> > > > ciphertexts.
> > >
> > > Probably I'm missing the point, but at the moment this looks like a
> > > chosen plain text attack. As you know for sure, this is trivial. For
> > > instance, AES asserts to be secure against this kind of attack. (See the
> > > author's definition of K-secure..).
> >
> > > I'm suggesting it doesn't work at all.
> >
> > Fruhwirth, your incompetence has always amazed me. And this time is no
> > exception. What is conserning is that some mainline folks seem to listening
> > to your ill opinions. No wonder that both mainline device crypto
> > implementations are such a joke.
> 
> Please don't resort to personal defamations.
> 
> To summarize for an innocent bystander:
> 
> - The attacks you brought forward are in the best case a starting point
> for known plain text attacks. Even DES is secure against this attack,
> since an attacker would need 2^47 chosen plain texts to break the cipher
> via differential cryptanalysis. (Table 12.14 Applied Cryptography,
> Schneier). First, the watermark attack can only distinguish 32
> watermarks. Second, you'd need a ~2.000.000 GB to store 2^47 chosen
> plain texts. Third, I'm talking about DES (designed 1977!), no chance
> against AES.
> 
> - The weaknesses brought forward by me are summarized  at
> http://clemens.endorphin.org/OnTheProblemsOfCryptoloop . Thanks goes to
> Pascal Brisset, who pointed out that cryptoloop is actually more secure
> than I assumed.
> 
> If you, Jari, have any arguments left, it's time to state them now.

Even more amazed...

Fruhwirth, what you have failed to understand is that the exploit does does
not exploit flaws in any cipher, but cryptoloop's and dm-crypt's insecure
use of those ciphers. Any block cipher that encrypts two identical plaintext
blocks using same key and produces two identical ciphertext blocks will do.
It is all about tricking a cipher to encrypt two identical plaintext blocks,
which, after encryption will show up as two identical ciptext blocks. And
those identical ciphertext blocks can be easily detected and counted.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

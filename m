Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUEPRqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUEPRqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUEPRqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:46:45 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:41448 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264664AbUEPRqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:46:05 -0400
Message-ID: <40A7A8F8.16426546@users.sourceforge.net>
Date: Sun, 16 May 2004 20:46:32 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1085585540.2c1d@endorphin.org>
Cc: Michal Ludvig <michal@logix.cz>, Andrew Morton <akpm@osdl.org>,
       jmorris@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
			<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
			<40A37118.ED58E781@users.sourceforge.net>
			<20040513113028.085194a3.akpm@osdl.org>
			<40A3C639.4FD98046@users.sourceforge.net>
			<40A4CA28.4E575107@users.sourceforge.net>
			<20040514140958.GA8645@ghanima.endorphin.org>
			<40A4EE3C.A80D4B5B@users.sourceforge.net> <20040516153218.GA9170@ghanima.endorphin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> Your countermeasures to optimized dictionary attacks are suboptimal. The
> following code is from your util-linux patch:
> 
>  aes_encrypt(&ctx, &loopinfo.lo_encrypt_key[ 0], &loopinfo.lo_encrypt_key[ 0]);
>  aes_encrypt(&ctx, &loopinfo.lo_encrypt_key[16], &loopinfo.lo_encrypt_key[16]);
>  /* exchange upper half of first block with lower half of second block */
>  memcpy(&tempkey[0], &loopinfo.lo_encrypt_key[8], 8);
>  memcpy(&loopinfo.lo_encrypt_key[8], &loopinfo.lo_encrypt_key[16], 8);
>  memcpy(&loopinfo.lo_encrypt_key[16], &tempkey[0], 8);
> 
> Symmetric block ciphers can't be used as hashing per se.

You nipped away part of code that does hashing.

> Neither seems the
> swapping scheme you're using to be a standard hash construction for ciphers.

Swapping upper half of first block with lower half of second block between
multiple iterations of encryption is correct way to extend block length.

> I suggest to read "Applied Cryptography", Bruce Schneier, "18.11 One-Way
> hash functions using symmetric block algorithms" as an introduction to that
> topic.

May I suggest that you read and understand the code before publishing
incorrect conclusions.

> To avoid this troubles all together, I recommend to use a standard
> MAC instead.

Recommended way of setting up encryption keys in loop-AES, is to use gpg
encrypted key file with random keys. gpg does all that salted+iterated key
setup without any user intervention. That quoted part of code is there for
backward compatibility.

> > > You have been campaigning with FUD
> > > against cryptoloop/dm-crypt for too long now. There are NO exploitable
> > > security holes in neither dm-crypt nor cryptoloop.
> >
> > In the past you, Fruhwirth, have demonstrated that you don't understand what
> > the security holes are. The fact that you still don't seem to undertand,
> > does not mean that the holes are not there.
> 
> Everyone attending a rhetoric seminar learns, "If you run out of
> arguments, attack the person itself". The attacks, you're speaking of in
> the next paragraph, apply to the key deduction. That's very different
> from IV deduction.

You said that I was spreading FUD. I said you are wrong. Fortunately
at least some of mainline kernel dudes seem to understand:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107713612713381&w=2

> > Optimized dictionary attack is exploitable. Ok, it requires major government
> > size funding, but what do you think NSA guys get paid for?
> >
> > Watermark attack is exploitable using zero budget.
> 
> As I said, not cryptoloop's responsibility.

Optimized dictionary attack can be prevented using better mount and losetup
programs. Mainline util-linux is still backdoored.

Watermark attack is very much cryptoloop's and dm-crypt's responsibility.

> Please read my mails carefully. See the following paragraph:
> 
> > > There is room for improving both IV deducation schemes, but it's a
> > > theoretic weakness, one which should be corrected nonetheless.

As long as there are only promises, and unfixed exploitable vulnerabilities
remain in mainline cryptoloop+util-linux and dm-crypt+cryptsetup, people
continue to be scammed to using backdoored crypto.

> > One cryptoloop developer
> > somehow managed to convince util-linux maintaner to drop those
> > countermeasures against optimized dictionary attacks. To protect the guilty,
> > I won't name his name here, but search linux-crypto archives for 14 Mar 2003
> > 11:12:13 -0800 posting if you want know his name.
> 
> You are talking about util-linux again. Rusuu, don't try to fool the
> audience by arguing for something totally different. Further if you try to
> provide evidence for something, provide an URL to back your claims. I wasn't
> able to find any mails in the archives dealing with that topic.

Wrong list, sorry. It was CC'd to cryptoapi-devel:

http://www.kerneli.org/pipermail/cryptoapi-devel/2003-March/000506.html

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

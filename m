Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUGYRYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUGYRYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 13:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUGYRYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 13:24:35 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:14992 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S263784AbUGYRYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 13:24:32 -0400
Message-ID: <4103ED18.FF2BC217@users.sourceforge.net>
Date: Sun, 25 Jul 2004 20:25:44 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1091625872.c783@endorphin.org>
Cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
			<1090672906.8587.66.camel@ghanima>
			<41039CAC.965AB0AA@users.sourceforge.net> <1090761870.10988.71.camel@ghanima>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> On Sun, 2004-07-25 at 13:42, Jari Ruusu wrote:
> > Fruhwirth Clemens wrote:
> > > Second, modern ciphers like Twofish || AES are designed to resist
> > > known-plaintext attacks. This is basically the FUD spread by Jari Rusuu.
> >
> > Ciphers are good, but both cryptoloop and dm-crypt use ciphers in insecure
> > and exploitable way.
> >
> > This is not FUD. Fruhwirth, did you even try run the exploit code?
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107719798631935&w=2
> 
> There is no use in running your code. It does not decipher any block
> without the proper key.

So you never ran that. That explains a lot.

> Where is the exploit?

wget -O cryptoloop-exploit.tar.bz2 "http://marc.theaimsgroup.com/?l=linux-kernel&m=107719798631935&q=p3"

> Further the link you provide in the posting above is broken (as you
> already noticed). I tried at google cache, citeseer and the rest of
> Saarien's homepage. No success.

In short: exploit encodes watermark patterns as sequences of identical
ciphertexts.

> > Can you name implementation that your "key-truncated" version is compatible
> > with that existed _before_ your version appeared?. To my knowledge, that
> > key-truncated version is only compatible with itself, and there is no other
> > version that does the same.
> 
> Actually there is a version: util-linux 2.12 official. But
> unfortunately, the official version truncates binary keys (at 0x00, 0x0a
> values), that's what my patch is for. cryptsetup handles keys the same
> way. So migration is easy, something which does not hold true for your
> strange util-linux patches.

Actually loop-AES' util-linux patch can used in mainline util-linux-2.12
compatible mode. Just specify passphrase hash type as unhashed2

But I was talking about your rmd160 compatibity with ancient mount versions
that used 160 bits of hash output + 96 zero bits. Last time I looked at your
compatibility code it used 128 bits of hash and 128 bits of zeroes.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

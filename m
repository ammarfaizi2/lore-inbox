Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUGYLmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUGYLmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 07:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUGYLmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 07:42:13 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:3766 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S261236AbUGYLmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 07:42:10 -0400
Message-ID: <41039CAC.965AB0AA@users.sourceforge.net>
Date: Sun, 25 Jul 2004 14:42:36 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens-dated-1091536908.31f8@endorphin.org>
Cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> Second, modern ciphers like Twofish || AES are designed to resist
> known-plaintext attacks. This is basically the FUD spread by Jari Rusuu.

Ciphers are good, but both cryptoloop and dm-crypt use ciphers in insecure
and exploitable way.

This is not FUD. Fruhwirth, did you even try run the exploit code?

http://marc.theaimsgroup.com/?l=linux-kernel&m=107719798631935&w=2

> But, due to a recent discussion on sci.crypt, I have been convinced that
> there is in fact a security gain by obscuring the IV. To be precise, if
> an attacker is able to find two identical cipher blocks on disk, he will
> be able to deduce the plain text difference. The chance p that two
> blocks are equal is p=1/2^128 for 128 bit block ciphers. If one of these
> blocks happens to be zero this is quite bad. The chance that there are
> no identical cipher blocks on a disk is given by p^(n(n-1)/2) with n =
> numbers of sectors on disk. Anyone with a little bit math intuition can
> see this terms will approach 0 quite quick. So it is likely that some
> information is revealed.

Exploit exists that generates watermark patterns that can be detected, and
can be detected _very_ reliably.

> This situation will not be cured by switching to dm-crypt, since
> dm-crypt suffers from the same kind of problem. Although personally, I
> neglect this security threat.

Then you should not be writing crypto code.

> - There is no suitable user space tool ready to use it. util-linux has
> been broken ever since. My patch key-trunc-fix patch has to be applied
> to make any use of losetup.

Can you name implementation that your "key-truncated" version is compatible
with that existed _before_ your version appeared?. To my knowledge, that
key-truncated version is only compatible with itself, and there is no other
version that does the same.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

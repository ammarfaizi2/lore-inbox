Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUA3SIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUA3SIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:08:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:16095 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262705AbUA3SIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:08:22 -0500
Date: Fri, 30 Jan 2004 10:02:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch
 pentium3,4
Message-Id: <20040130100247.1a0f6eb9.rddunlap@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0401301156120.16128-100000@thoron.boston.redhat.com>
References: <200401301643.13477.arnd@arndb.de>
	<Xine.LNX.4.44.0401301156120.16128-100000@thoron.boston.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 11:57:20 -0500 (EST) James Morris <jmorris@redhat.com> wrote:

| On Fri, 30 Jan 2004, Arnd Bergmann wrote:
| 
| > James Morris wrote:
| > > Have you noticed if this happens for any of the other crypto algorithms?
| > 
| > Just as a reminder, there is still an issue with extreme stack usage
| > of some of the algorithms, depending on compiler version and
| > flags.
| > 
| > The worst I have seen was around 16kb for twofish_setkey on 64 bit
| > s390 with gcc-3.1 (iirc). Right now, I get up to 4kb for this
| > function with gcc-3.3.1, which probably works but is definitely
| > a bad sign. I've seen this as well on other architectures (iirc
| > on x86_64), but not as severe.
| > 
| > Other algorithms are bad as well, these are the top scores from
| > Jörn Engel's checkstack.pl (s390 64bit 2.6.1 gcc-3.3.1):
| > 
| > 0x00000a twofish_setkey:           lay    %r15,-3960(%r15)
| > 0x0026fc aes_decrypt:              lay    %r15,-1168(%r15)
| > 0x000c0c aes_encrypt:              lay    %r15,-1000(%r15)
| > 0x00000e sha512_transform:         lay    %r15,-936(%r15)
| > 0x001292 test_deflate:             lay    %r15,-784(%r15)
| > 0x0028a2 cast6_decrypt:            lay    %r15,-696(%r15)
| > 0x00d1a0 twofish_encrypt:          lay    %r15,-664(%r15)
| > 0x001b34 setkey:                   lay    %r15,-656(%r15)
| > 0x00e2b0 twofish_decrypt:          lay    %r15,-624(%r15)
| > 0x000c9e cast6_encrypt:            lay    %r15,-600(%r15)
| > 0x000014 sha1_transform:           lay    %r15,-504(%r15)
| 
| I'm not seeing anything like this on x86 (e.g. stack usage is 8 bytes), 
| and can't see an obvious way to fix the problem for your compiler.

Here's what I see on x86 and gcc 3.2 (for Linux 2.6.1).
What Linux version of the code are you looking at?


$0x180,%esp: c01fd5aa <aes_encrypt+4/1750>
$0x1b0,%esp: c01fecfa <aes_decrypt+4/17da>
$0x230,%esp: c0206acd <test_deflate+b/2f8>
$0x10c,%esp: c0205c90 <test_hmac+6/4fc>
$0x1fc,%esp: c01e9ed8 <sha1_transform+4/178a>
$0x120,%esp: c01eb842 <sha256_transform+6/1ef0>
$0x384,%esp: c01ed988 <sha512_transform+4/17e8>
$0x10c,%esp: c01f1c90 <twofish_setkey+4/7480>


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/

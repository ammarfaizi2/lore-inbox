Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUA3Q52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUA3Q52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:57:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262123AbUA3Q50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:57:26 -0500
Date: Fri, 30 Jan 2004 11:57:20 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org, R CHAN <rspchan@starhub.net.sg>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
In-Reply-To: <200401301643.13477.arnd@arndb.de>
Message-ID: <Xine.LNX.4.44.0401301156120.16128-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Arnd Bergmann wrote:

> James Morris wrote:
> > Have you noticed if this happens for any of the other crypto algorithms?
> 
> Just as a reminder, there is still an issue with extreme stack usage
> of some of the algorithms, depending on compiler version and
> flags.
> 
> The worst I have seen was around 16kb for twofish_setkey on 64 bit
> s390 with gcc-3.1 (iirc). Right now, I get up to 4kb for this
> function with gcc-3.3.1, which probably works but is definitely
> a bad sign. I've seen this as well on other architectures (iirc
> on x86_64), but not as severe.
> 
> Other algorithms are bad as well, these are the top scores from
> Jörn Engel's checkstack.pl (s390 64bit 2.6.1 gcc-3.3.1):
> 
> 0x00000a twofish_setkey:           lay    %r15,-3960(%r15)
> 0x0026fc aes_decrypt:              lay    %r15,-1168(%r15)
> 0x000c0c aes_encrypt:              lay    %r15,-1000(%r15)
> 0x00000e sha512_transform:         lay    %r15,-936(%r15)
> 0x001292 test_deflate:             lay    %r15,-784(%r15)
> 0x0028a2 cast6_decrypt:            lay    %r15,-696(%r15)
> 0x00d1a0 twofish_encrypt:          lay    %r15,-664(%r15)
> 0x001b34 setkey:                   lay    %r15,-656(%r15)
> 0x00e2b0 twofish_decrypt:          lay    %r15,-624(%r15)
> 0x000c9e cast6_encrypt:            lay    %r15,-600(%r15)
> 0x000014 sha1_transform:           lay    %r15,-504(%r15)

I'm not seeing anything like this on x86 (e.g. stack usage is 8 bytes), 
and can't see an obvious way to fix the problem for your compiler.


- James
-- 
James Morris
<jmorris@redhat.com>



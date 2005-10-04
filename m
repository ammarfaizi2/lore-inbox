Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVJDFPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVJDFPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 01:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVJDFPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 01:15:03 -0400
Received: from mail.tnnet.fi ([217.112.240.26]:58323 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1751189AbVJDFPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 01:15:02 -0400
Message-ID: <43420F92.ABE3C821@users.sourceforge.net>
Date: Tue, 04 Oct 2005 08:13:54 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: util-linux and data encryption
References: <4341567E.4050603@esoterica.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo da Silva wrote:
> I had a loop filesystem encrypted with twofish
> algorithm.
> 
> Today, trying to mount the file, 'mount' claimed
> I needed to enter a password of 20 chars or more!
> Since I used less chars to encrypt, I was not able
> to recover the information!!!
> I tried CFLAGS="-DLOOP_PASSWORD_MIN_LENGTH=8"
> without any success. This causes 'mount' to accept
> the password, but, somehow, the decryption failled
> because the fs type remained unrecognized!
> 
> BTW, I am using gentoo and I also tried USE=old-crypt.
> No way!
> 
> I needed to install the version 2.12i to recover
> my information.
> 
> Is this related with util-linux or has something
> to do with gentoo patches or something?

Seems like gentoo has merged loop-AES' util-linux patch which has always
used better defaults.

Mainline util-linux compatible mount options for /etc/fstab

    encryption=twofish256,phash=unhashed2

Mainline util-linux compatible losetup command options

    losetup -e twofish256 -H unhashed2 ......

kerneli.org compatible mount options for /etc/fstab

    encryption=twofish256,phash=rmd160

kerneli.org compatible losetup command options

    losetup -e twofish256 -H rmd160 ......

mount and losetup programs don't enforce 20 character minimum passphrase
length when using 'rmd160' or 'unhashed2' hash functions.

Both mainline util-linux and kerneli.org compatible setups are broken
securitywise. If there still are file systems using such broken setups, now
is good time to re-encrypt them using stronger crypto.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUIYDd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUIYDd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269222AbUIYDcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:32:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28082 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269213AbUIYDaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:30:15 -0400
Message-Id: <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@novell.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1) 
In-Reply-To: Your message of "Sat, 25 Sep 2004 04:58:48 +0200."
             <20040925025848.GG3309@dualathlon.random> 
From: Valdis.Kletnieks@vt.edu
References: <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> <20040925021501.GF3309@dualathlon.random> <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu>
            <20040925025848.GG3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_109984968P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Sep 2004 23:29:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_109984968P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Sep 2004 04:58:48 +0200, Andrea Arcangeli said:

> I don't even think "save their key securely" (I mean saving anything
> related to the swapsuspend encryption key on disk) is needed. A mixture
> of a on-disk key + passphrase would not be more secure than a simple
> "passphrase" alone, because the on-disk key would be in cleartext and
> readable from the attacker. the only usable key is the one in the user memory,
> it cannot be saved in the computer anywhere. Peraphs for additional
> security (and to avoid having to type and remember it) one could use an
> usb pen to store and fetch the key... but then I leave the fun to the
> usb folks since to do that usb should kick off before resume overwrites
> the kernel image ;)

Well, obviously saving the actual key on the disk is a losing idea, but saving
"key hashed by passphrase" would work (similar to how PGP or SSH don't save the
actual key, but rather the key hashed by something).

I suspect that having the *entire* key be the passphrase remembered by the user
is also a non-starter security-wise (unless we do something like Jari Ruusu's
loop-AES stuff does and forces a minimim 20-char passphrase) - there's going to
be all too many blocks in the swsusp area that are "known plaintext" and easily
brute-forceable for most passphrases that users are likely to actually use.

So in order to make it at all secure, we really need to save on the disk
a key with O(128 bits) of entropy, perturbed by enough bits that are *not*
to be found anywhere on the machine so that it isn't a slam-dunk for an attacker.

Do any of the crypto experts lurking have ideas/opinions on just how many
bits we need to store externally (be it in a USB dongle, a thumbprint, a
passphrase, whatever)?






--==_Exmh_109984968P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBVOY1cC3lWbTT17ARAsNUAJ0XhiMJbw1BrB4vZRw3GEq/6GhEUQCg4tVc
7jYhtUDJNsnfbz0VYQ0bi+A=
=KhHk
-----END PGP SIGNATURE-----

--==_Exmh_109984968P--

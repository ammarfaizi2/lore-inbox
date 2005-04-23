Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVDWShf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVDWShf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVDWShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:37:34 -0400
Received: from quechua.inka.de ([193.197.184.2]:50106 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261663AbVDWSfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:35:16 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Git-commits mailing list feed.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050423175422.GA7100@cip.informatik.uni-erlangen.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DPPTB-0004y2-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 23 Apr 2005 20:35:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050423175422.GA7100@cip.informatik.uni-erlangen.de> you wrote:
> # This creates the signature.
> gpg --clearsign < sign_this > signature

To not destroy the syntax of the original data, you better generate a
detached signatur and append it. However in that case you have to detech the
signatur handish:

> gpg --detach-sig -a tag-file
<requirs passphrase>
> ls tag*
-rw-rw-r--  1 ecki ecki  45 Apr 23 20:25 tag-file
-rw-rw-r--  1 ecki ecki 189 Apr 23 20:26 tag-file.asc
> cat tag.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCapNy/vciZ+ODzX4RAgBcAJ92ku1fc5iwhpZ+BJ18HvRFPYa5FACdG2r0
B22yNdcyi/Opz11nbWd2LaE=
=Zt5v
-----END PGP SIGNATURE-----
2ecki@calista:~> cat tag-file
commit 123
signer Bernd Eckenfels
tag RC-123

If you skip the -a the signature file is binary. You can merge both files,
but you have to separate them before you present them to GPG:

> gpg --verify tag.asc tag
gpg: Signature made Sat Apr 23 20:26:58 2005 CEST using DSA key ID E383CD7E
gpg: Good signature from "Bernd Eckenfels <ecki@lina.inka.de>"
echo $?
0

If you dont care about the Format of the plaintext (i.e. additional GPG
Headers and Replacement of -- as well as sensitieness to line endings, then
you can use the clear sign method as well.

Greetings
Bernd

BTW: you can send gpg the passphrase via a specified FD, if you want to
cache it, however thats a bad idea generally. If you want to parse the
results from gpg verify (i.e. expired, who has signed, etc) it is better to
specify some more options which generate easyly parseable extra info:

> gpg --status-fd 1 --verify tag.asc tag
gpg: Signature made Sat Apr 23 20:26:58 2005 CEST using DSA key ID E383CD7E
[GNUPG:] SIG_ID e8Q/kei6ZdkSPK/7MCyBuXTdJIo 2005-04-23 1114280818
[GNUPG:] GOODSIG FEF72267E383CD7E Bernd Eckenfels <ecki@lina.inka.de>
gpg: Good signature from "Bernd Eckenfels <ecki@lina.inka.de>"
[GNUPG:] VALIDSIG 654F33BCA8B3868852DC731DFEF72267E383CD7E 2005-04-23 1114280818 0 3 0 17 2 00 654F33BCA8B3868852DC731DFEF72267E383CD7E
[GNUPG:] TRUST_ULTIMATE

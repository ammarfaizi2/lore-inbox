Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUKJAQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUKJAQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUKJAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:14:36 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:43140 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261796AbUKJAMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:12:23 -0500
Message-ID: <41915CE3.4080404@g-house.de>
Date: Wed, 10 Nov 2004 01:12:19 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds schrieb:
> 
> Now, if you want to get _really_ fancy, you can now look at each changeset 
> that differed, with something like
> 
> 	bk set -n -d -r1.2462 -r1.2463 | bk -R prs -h -d'<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' -
> 
> which is black magic that does a set operation and shows all the changes 
> in between the sets of "bk at 1.2462" and "bk at 1.2463".
> 
> (This is _not_ the same as "bk changes -r1.2462..1.2463", because that one 
> just shows the single merge change that is on the direct _path_ from one 
> changeset to another. The black magic thing shows the set difference of 
> changesets that comes from the full graph at two points).

hm, i still fail to see the "magic" part here. from a current tree i get:

- ---------------
$ bk set -n -d -r1.2000.5.107 -r1.2000.5.108 | bk -R prs -h \
- -d'<:P:@:HOST:>\n$each(:C:){\t(:C:)\n}\n' - | head -n5
<Matt_Domsch@dell.com>
  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR

  Some controller BIOSes have problems with the legacy int13 fn02 READ
  SECTORS command.  int13 fn42 EXTENDED READ is used in preference by most
- ---------------

which looks similiar to the next one, but with "bk changes" i get the
ChangeSet number again:

- ---------------
$ bk changes -r1.2000.5.108 | head -n5
ChangeSet@1.2000.5.108, 2004-10-20 08:36:22-07:00, Matt_Domsch@dell.com
  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR

  Some controller BIOSes have problems with the legacy int13 fn02 READ
  SECTORS command.  int13 fn42 EXTENDED READ is used in preference by most
- ---------------

...or was i supposed to alter your cmdline? i just copy'n'pasted it...
anyway, i've seen that i have a lot of "bk help" ahead of me, thanks for
the course, though ;)

greetings,
Christian.
- --
BOFH excuse #297:

Too many interrupts
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkVzi+A7rjkF8z0wRAte6AKCO8isFqWGyFK53IpVtEnAImvQq8gCfeePr
rzMnTyR3EPMqpv7+qz9iR6c=
=BB+K
-----END PGP SIGNATURE-----

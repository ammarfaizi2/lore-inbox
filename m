Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKGBYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKGBYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 20:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKGBYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 20:24:52 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:52666 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261508AbUKGBYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 20:24:45 -0500
Message-ID: <418D7959.4020206@g-house.de>
Date: Sun, 07 Nov 2004 02:24:41 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: alsa-devel@lists.sourceforge.net, perex@suse.cz
Subject: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
In-Reply-To: <418A47BB.5010305@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi again,

i *think* i found the ChangeSet leading to the bug i tried to report in
 http://marc.theaimsgroup.com/?l=linux-kernel&m=109888178603516&w=2

the error is sill present here (and only here? strange...), the latest -BK
does not fix it. i had some difficulties in telling BK to do the right
thing. to summarise the error:

- - upon loading of snd_ens1371 the Oops occurs. system is still stable
then, but no sound available.
- - this occured somewhere between 2.6.9 (released 15-Oct-2004) and 2.6.9-10
(released 22-Oct-2004)

one interesting changeset was:

ChangeSet@1.2000.7.1, 2004-10-20 20:33:06+02:00, perex@suse.cz
  Merge suse.cz:/home/perex/bk/linux-sound/linux-2.5
  into suse.cz:/home/perex/bk/linux-sound/linux-sound

i tried to back it out:

$ bk clone -r1.2000.7.1 linux-2.6-BK linux-2.6-BK-test

but the said ChangeSet was still there (of course). i tried to back it out
(now for sure):

$ bk undo -a1.2010
(hm: the changesets get renumbered everytime i "do" something with the
tree) this one reverted quite a few ChangeSets but i let it happen.

compiling & booting this thing goes fine and i am now running 2,6,9-BK(?)
with working snd_ens1371.

if someone could give me a hint here what to do next or perhaps tell me
that the whole things was totally pointless - please say so.
i am somehow lost as to which is the right person to bug here.

thank you for your time,
Christian.
- --
BOFH excuse #328:

Fiber optics caused gas main leak
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjXlZ+A7rjkF8z0wRAqaVAJ9ljiIpxi01SblgEg/ce/Vd/uYksQCfeuJ9
hRGA0/17ttZ83xRQDb8jfhs=
=DQYp
-----END PGP SIGNATURE-----

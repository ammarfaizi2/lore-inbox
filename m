Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbUKGXqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUKGXqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 18:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUKGXqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 18:46:11 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:53183 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261710AbUKGXp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 18:45:56 -0500
Message-ID: <418EB3AA.8050203@g-house.de>
Date: Mon, 08 Nov 2004 00:45:46 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net,
       linux-sound@vger.kernel.org
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
In-Reply-To: <20041107182155.M43317@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Kujau schrieb:
> On Sun, 7 Nov 2004 08:57:40 -0800 (PST), Linus Torvalds wrote
> 
>>	bk undo -a1.2000.7.2
>>
>>which should give you a tree without any of "my" stuff, ie it 
>>was what Jaroslav was working on before he merged it into the 
>>standard tree.

i did so from a current tree (bk pull, undo, -r get) and it's working
fine (url wraps):

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-no-oops-2.6.9_a1.2000.7.2.txt

so i can see with "bk changes" that the ChangeSet is still there. this is
what i expected, because -a says:

- -a<rev>   Remove all changesets which occurred after <rev>.

what i did not expect is that this ChangeSet is now *not* the culprit,
because there is no oops. am i right? [1]

>>Yes, that makes me suspicious, and is one reason why I wonder 
>>if it's just your tree not being built right.
> 
> i'll build a -bk snapshot from a tar.bz2 later on and see what it gives.

i've build from linux-2.6.10-rc1.tar.bz2 with patch-2.6.10-rc1-bk17.bz2
from kernel.org with the same .config and "modprobe snd-ens1371" oopses as
expected :(

> Hmm.. That may well have worked fine, but it sounds in that post like
> you tried to undo the ALSA stuff, and what I suggested was really to
> do the reverse: take _only_ the ALSA changes, and then if it still

yes, i wanted to undo the alsa changes because i suspected the alsa
framework (sorry guys) and wanted to see if it still oopses when the
latest alsa patch was not appied.

i did another thing: i enabled the (deprecated) OSS driver (es1371.ko)
tried to load this thing:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-OSS.txt

it oopses.
- - you said it's not a b0rken pci thingy
- - i have to assume now that it's not an ALSA issue (since oss oopses too)
- - it is OSS? the driver? i've CC'ed linux-sound...


> fails, at least you have now pinpointed it a bit more (admittedly to
> the _likely_ source, but that's as it should be: you narrow down the
> "known bad" source base until you've narrowed it down to the smallest
> change you can find that causes the problem).

yes, like Documentation/BUG-HUNTING says. but i seem to have difficulties
in using my tools (bk). sorry for that.

> Sounds like you're doing everything right, but hey, it can't hurt to
> double-check.

yes, i really hope that it's not just a user error (on my side). building
kernels since 2.0...but you never know...


thanks again for help,
Christian
(whose only wish these days is to get over this strange thing and not
wasting peoples precious time with a "sound driver". hey, at least  the
box is booting...)

- --
BOFH excuse #224:

Jan  9 16:41:27 huber su: 'su root' succeeded for .... on /dev/pts/1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjrOp+A7rjkF8z0wRAl59AKCEbRRzsGujcOlLUA74taFZJb8H0ACfUUxQ
nVQHjBXRBBn9BgSs7cLhTlY=
=wb90
-----END PGP SIGNATURE-----

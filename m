Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUKHVB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUKHVB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUKHU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:59:59 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:38615 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261220AbUKHU7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:59:22 -0500
Message-ID: <418FDE1F.7060804@g-house.de>
Date: Mon, 08 Nov 2004 21:59:11 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net,
       linux-sound@vger.kernel.org, Greg KH <greg@kroah.com>
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
> No, just gut feel. If the pre-merge ALSA works, and the post-merge one 
> doesn't, and the oops in both cases happen somewhere close to where it 
> does "pci_enable_device()", there's not a lot left. There are interrupts, 
> and there is the PCI layer...

yes, makes sense.

>>
>>i did "bk undo -a1.2463" from a current -BK tree and it oopses:
> 
> Note that "bk undo -axxx" will _leave_ xxx in place, and undo everything 
> after. 
> 
> So what you did still has the merge in the tree, and that it still oopses 
> is thus to be expected. BUT, we're getting closer.

yes, i think i understood that. that's why i wanted to revert 1.2463 too.

[...]

> 
> Now, that's fine - the USB merge is likely to be ok, so try doing
> 
> 	bk undo -a1.2462

for now i appreciate your work here but i have to postpone the the "bk
revtool" stuff because i have no X _and_ bk here. (but i'm a good student
and will do my homework)

> and you will now have a tree that is exactly the same as before, except it 
> does _not_ have the PCI merge from Greg.
> 
> And if this one does not oops, you can now officially blame Greg.

i can't wait... ;)

>> Now, if you want to get _really_ fancy, you can now look at each changeset 
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
> 
> Then you can look at each change individually and see if they matter.

will do, after the build

> 
> And once you can do the set operations, you're officially a BK poweruser.  
> Me, I just have a script, I'm a BK dabbler.
> 
> Looking at the list (appended), I don't see anything obvious, but hey, if 
> it was obvious it wouldn't have been merged in the first place. 
> 
> Thanks for your willingness to pursue this thing,

hey, thanks to you and to the folks in the Cc: field to chase a bug which
only _i_ encounter until now.

/me is building now....
thanks,
Christian.
- --
BOFH excuse #111:

The salesman drove over the CPU board.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj94f+A7rjkF8z0wRAm/uAJ0eTBa20JnX+250GpFiSED4b+arQwCggSgo
CO/MQ+1jeOOvb7WaJRKg7uY=
=Qlt1
-----END PGP SIGNATURE-----

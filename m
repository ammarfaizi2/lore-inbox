Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFYSd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFYSd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFYSd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:33:57 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:12809 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261236AbVFYSdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:33:32 -0400
Message-ID: <42BDA377.6070303@slaphack.com>
Date: Sat, 25 Jun 2005 13:33:27 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>            <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
In-Reply-To: <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 24 Jun 2005 23:10:35 CDT, David Masover said:
> 
> 
>>But Linux is better.  DOS ain't broke, but Linux is better.  So maybe
>>VFS ain't broke, but plugins would be better.  I guess we'll only know
>>if we let Reiser4 merge...
> 
> 
> No, we'll only know if we merge something that does plugins at the VFS
> level in a well-designed way.

Which will never happen, the way you see it.  (see below.)

Or maybe you could see this in action if you look at the *current* code,
not the hypothetical future code where reiser4 plugins are removed from
the FS, which is then merged, then plugins are added to VFS, then back
into reiser...   (see below)

>>This was about a hypothetical ext3 format as a reiser4 storage plugin.
>>I'm not sure how this ties into the VFS stuff.
> 
> 
> Very poorly.  There's only two interpretations of "ext3 as a reiser4 plugin"
> that make *any* sense.  The first is that reiser4 is totally violating the VFS
> layer boundary, and the second is that reiser4 is trying to be an all-singing
> all-dancing wankfest.  Later on, you say:

You'll have to be more specific and less insulting.

Actually, the way I'd like to see that is if we

>>A lot of what people like about ext3 is its stability and fairly
>>universally accepted format.  A lot of what people like about XFS is its
>>stability and speed, mainly with large files.  A lot of what people like
>>about Reiser4 (as it is today) is its speed, with large and especially
>>with small files.
> 
> 
> Now *think* for a moment - how does a hypothetical Reiser4 using ext3 format
> gain any speed advantage with small files, when the speed advantage is based
> on using a format other than ext3?

It doesn't.  It gains in other ways.  Transparent cryptocompress,
oddball other plugins, not to mention some speed optimizations that
happen in RAM.  If you do a ton of work with a dataset that stays in
RAM, Reiser probably performs as well or better than a ramdisk, because
changes that get overwritten while still in RAM never actually touch the
disk.  Reiser also doesn't fragment as quickly as ext3, and I don't
think that has anything to do with its format.

> The Reiser4 proponents would be well served to disavow that particular
> hypothetical example - I have yet to see *anything* that does more damage
> to the Reiser4 cause.

It is my example.  I don't speak for Namesys.  I don't work at Namesys.

If it does "damage", that is only in the eyes of those not paying attention.

>>So, in this hypothetical situation where ext3 is a reiser4 plugin,
>>suddenly all the ext3 developers are trying to improve the speed and
>>reliability of reiser4, which benefits both ext3 and reiser4, instead of
>>just ext3.
> 
> 
> Or we can do what *should* be done, which is:
> 
> a) Put the crack pipe down.

That was unneccesary.  Come back when you can debate technical reasons,
not imaginary personal ones.

> b) Tell reiser4 to get its grubby little paws off the VFS if it ever intends
> to have a chance of being merged in mainline.

You are saying Reiser isn't in because it shouldn't touch VFS.  Every
single other person in this thread says Reiser isn't in because it
*should* touch VFS.

> c) Have a *separate* project to improve the speed/reliability/function of
> the VFS layer, which is the only way that your vision of having the ext3 and
> reiser developers cooperating will ever happen.

Why does it have to be a separate project if it is already *done* as
part of Reiser4?  Or is the name Reiser just cursed that way?

> Yes, the VFS could probably use an overhaul.  But that *will* happen like this:
> 
> 1) A patch is submitted and passes review to change the VFS.
> 2) If appropriate, a patch for reiser4 (if it gets merged) is also submitted
> (possibly by the same people) to be the first user of the new API/functionality.

The FS that gets merged ahead of time without plugins would no longer be
Reiser4.  Go read the whitepaper, or tell me why I'm wrong, but even
symlinks are implemented as plugins.

> There's a *reason* why we see patch streams that look like:
> 
> Patch 1/3: Add moby_foo_init function to nautical core.
> Patch 2/3: Modify white_whale driver to use moby_foo_init
> Patch 3/3: Modify captain_ahab driver to use moby_foo_init

I'm not arguing that at all.  But if you've got an entirely new driver,
why not do:

Patch 1/2:  Add white_whale driver, which also adds moby_foo_init to
nautical core.
Patch 2/2:  Modify captain_ahab driver to use moby_foo_init

>>Plus, as someone else said, it's much easier to do
>>$ vim /some/encrypted/file
>>than
>>$ gpg --decrypt /some/encrypted/file > /some/decrypted/file
>>$ vim /some/decrypted/file
>>$ gpg --encrypt /some/decrypted/file > /some/encrypted/file
>>$ shred /some/decrypted/file
> 
> 
> You've totally failed to understand that the whole *point* of PGP is that 'vim
> /some/encrypted/file' *isnt* easy to do.  A better example might be the various
> crypto-loop-ish variants or Microsoft's EFS, where the key management model is
> more tractable to this sort of automation.

Actually, plugins are just as easy or easier than crypto-loop or
dm-crypt.  And why shouldn't my crypto be easy?  Most users are insecure
in all kinds of ways because of that attitude -- security is HARD, so I
won't do it.  If security is transparent, just enter a password and go,
then more people would do it.  If more people are secure in more ways,
there are less DDOS attacks and the world is a better place.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr2jd3gHNmZLgCUhAQIeihAAgifgKxYw2FECNKLsspQ7sMOmBaT1jcev
5CJdDCiDjiMEMMcsh1h749tZX38YTjqL/w8VQQ18ys/2QqRERbjNEn/lGWLjO4Hs
UwFFv/usVMv3RmRModH62P2j7QAxWhjTcfWYeIexdh20whMJLJA+BpIhnoKZ6Xjq
WQMbdc9X/NW/lS09zkthWUju8JXtjTjD5rsMF3yQ47Scijec2i67ATsnzNxdXB5/
fZmjOfWKkahHh8qdO/IXX/6nvyEEzmVThr1EskCjUwoRYUSfb9bLQMkntjvEWSDh
mDIBbwAUg88k3dM947uS55iV3QGoVkgDRvF0cpWxeaOEP+FcKmF9gPiaW0wm5jYw
n60tw7P48FVchBrAPZTwvq5po78Evj3bB09NmS3i68in56rhRI3hTB7KNR/vIbS1
9dKvYuilV0C+thGD+sfE81qqFyP/O66sjvpxRi/YhjL8hU8N3x2f5tTIkKli7Y2C
bZSxCiLiDRzKYAgCq0Rr+mrn/TZb5Ld5W8Ys062qF5l00M0I6cDO0sPiH72RexM7
PMM5tWNBDqVacUWxNYReULC5O7Q6c8FYTWcZz/zC1boLTeGpvlI8uVkbxP6K/grY
j1u7vHbjgAqsztYhA8qmw3nl5vHtXCGHCRFQJ36g14Qt3atFcMgvfE5yphWyC1P9
hYZm8EWvMqc=
=GvIJ
-----END PGP SIGNATURE-----

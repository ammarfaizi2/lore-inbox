Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUIGFu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUIGFu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUIGFux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:50:53 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:61879 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S267565AbUIGFuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:50:23 -0400
Message-ID: <413D4C18.6090501@slaphack.com>
Date: Tue, 07 Sep 2004 00:50:16 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Spam <spam@tnonline.net>, Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>
In-Reply-To: <200409070206.i8726vrG006493@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
[...]
|>Second, there are quite a few things which I might want to do, which can
|>be done with this interface and without patching programs,
|
|
| Such as?

They've been mentioned.
|
|
|>                                                           but would
|>require massive patches to userspace.  There have been numerous examples.
|
|
| Haven't seen any that made sense to me, sorry.

Sorry if they don't make sense to you, but I don't feel like discussing
them now.  Either you get it or you don't, either you agree or you
don't.  Read the archives.
|
|
|>There are some things which can't be solved without patching.
|
|
| Maybe. Question is, is it worth it (kernel modifications + userland
| support, or just userland support, or leave it alone). Sure, it might make
| your particular application easier to write (at a cost for _all_
filesystem
| hackers!), perhaps even a bit faster; but is _your_ particular convenience
| worth the cost for _everybody_?

There are far more userland developers than filesystem hackers.  If
you're a filesystem hacker, it's easier to understand how much work it
is to do something in the filesystem/kernel, and harder to understand
how it works in userland, or for the actual user.
|
|
|>                                                               Version
|>control is one such thing.
|
|
| bk, cvs, svn, rcs, ... are working just fine here, thank you so much. Used
| to work on SunOS and Solaris, even SCO Unix (I used at least rcs and cvs
| there). No Reiser4 in sight.

Transparently?

It _works_ to do
	zcat file.gz > /tmp/file
	vim /tmp/file
	gzip -c /tmp/file > file.gz
	rm /tmp/file
You can even do that as a script, call it zvim.  You could even do it as
a generic script, where "vim" is replaced with "$1".  But is it as
elegent as transparently compressed files?

I'm not sure about the version control thing -- I don't think people
have hit every conceptual issue about it yet.  But the point is:

Moving complexity from kernel space to user space (or the other way)
doesn't make it any less complex.


|>                            But then there can be more generic patches
|>- -- as soon as the transaction API is done, you only have to patch apps
|>to use that, and have a version control reiser4 plugin.
|
|
| Again, _what_ version control exactly? Will the above packages be able to
| make use of it (remember they all are cross-platform (at least
cross-Unix),
| and so quite unlikely to make use of a Reiser4 on Linux whackiness...)?

Probably.  It wasn't specified what version control would be used --
that's currently just as abstract as what compression algorithm to use
to transparently compress files.

Maybe something new.  Version control just doesn't look that complex
once you've got the interface and the data storage done.  I do
incremental backups using rsync and hardlinks -- why would version
control be so much more complex than that?

Said backup system uses hardlinks, btw, which not all systems support.
And rsync is fairly broken on some platforms.

|>| I'd go the other way around: Get userspace to agree on a common
framework,
|>| make it work in userspace; if (extensive, hopefully) experience
shows that
|>| a pure userspace solution has issues that can't be solved except by
kernel
|>| assistance, so be it.
|
|
|>We already have such a framework -- it's called "VFS".
|
|
| Right. It offers what applications need to build their own stuff. It is
| minimalistic (well, sort of) and  time-proven.

x86 assemby is minimalistic and time-proven.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQT1MGHgHNmZLgCUhAQLxoQ/+Mglz6tr0A4wQmAnP1y9q7WVqQQ8s3Cwg
b3VyOHaIIZSw3lod+bWDgE9LJJsQOxO4SThlWLyMEHipFJT0iHVIYjLSrC5e4DOb
Wl5E51yz3ZVx11mRTM7uEw+Ez6wOcaWIFLTvarDxzmDaxS6oh2ZpN2Ibnf8h/1lT
0YJnz6C964TkaA8jYIsQljIWkMMk7EGzP6UlrQOBbo4xMJNT+wIZMJWX5JAsULc2
EGzTO8dgZB0MbJ5STufS4h5tudny/lz4TO9iTv9CRGhusf2am7k7PVFPG4RcjXKU
iMgLTHKsXbDjncj39JZqwQtBZP8nuf72pMzbEe5iiYYIHGWu4Mm/JSxUmuJZ/YXX
yZIS6DKwSrKzDf/p1chvLVCaScxsaIWuetoe4ODFUoWMRUfCdxK+r7+6j9tKn+hn
LK5iYVAs3/xpU64jpBKvrKlRlISm8++GvGD+tdnZKAnetmaS0QHb2DrbwSbONvC1
4RvABUYC2IoVoDuAsueRDQxqTJjGPWn7DBvVUI5SCQZVlJPMavHmrv9qRVtNA4Y4
LBzfYK6aCprbmmX2Axs8FS4ptNGdwGpUhwuVKfSzlOgUS5gIaWlMKOGxWOTgDx7U
Q53mVhdZIinHH+/h4xBpcP3Q1fk8nTQ1gqfYVTseNlrMZvgFAax7E2VINiJWohis
KH6z9bFgkZA=
=aNM7
-----END PGP SIGNATURE-----

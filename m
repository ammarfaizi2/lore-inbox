Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUIABnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUIABnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUIABnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:43:39 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:3746 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S266353AbUIABna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:43:30 -0400
Message-ID: <4135293C.3060702@slaphack.com>
Date: Tue, 31 Aug 2004 20:43:24 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>	<Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>	<20040831203226.GB16110@elf.ucw.cz>	<Pine.LNX.4.58.0408311336580.2295@ppc970.osdl.org>	<20040831205422.GD16110@elf.ucw.cz>	<Pine.LNX.4.58.0408311357550.2295@ppc970.osdl.org>	<20040831220726.GB16428@elf.ucw.cz> <m3acwa99qz.fsf@zoo.weinigel.se>
In-Reply-To: <m3acwa99qz.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christer Weinigel wrote:
| Pavel Machek <pavel@ucw.cz> writes:
|
|
|>Okay, that does work, it just is not really nice. Just as reserving
|>fixed ammount of space for disk cache is bad, reserving fixed ammount
|>of space for ccache (and similar) is bad. When there are few of such
|>caches, balancing between them starts to matter...
|
|
| So try to convince them to use the same cache daemon or the same
| shared cache manager library then.  It isn't all that different from
| implementing a kernel interface that everyone is supposed to use.

You're right, it's not.  Is there some huge performance loss by having a
kernel interface that then turns around and calls a userland daemon?  If
yes, I can understand the argument.  If no, then the kernel interface
should ultimately be able to replace gnome-vfs -- and it should rely
heavily on userland utilities.

Caching is very generic.  It's so generic that there should be exactly
one cache manager, the way there is exactly one VM manager for Linux.
If there's a choice, choose it at boot or compile-time.

Abiword uses gzipped files.  So does gnumeric, gnucash, cube (a cute
little game engine), and many others.  There's no way every single one
will suddenly use a new library/daemon.  But with plugins and
intelligent caching, any kind of compression could be supported without
the app needing to support it natively -- either it goes in a compressed
folder or the user browses to it and changes an attribute.


| A cache manager daemon could sit and watch the free space on the disk
| every other second and start deleting the cached files (according to
| some LCU heuristics or whatever) whenever free space is getting low.

Agreed.  The daemon should go in userspace.  But the interface should be
in the kernel.  Just as no one suggested putting tar in the kernel, I
don't think anyone would really insist that the daemon needs to go in
the kernel.

That is, unless critical system files start actually being cached
streams of the actual package from the distro...  But this way leads to
madness.  Any serious issues here are better solved by an initrd.

[...]
| I belive the kernel could give some assistance to make it easier to
| see if a file has been modified, I remember that a few suggestions
| were thrown around the last time Samba and dcache aliases were
| discussed on l-k.  I definitely belive that kind of infrastructure
| belongs in the kernel.  But the cache manager itself, no.

Isn't there already dnotify?

Dnotify is wrong here, because I don't think it would be sane in a
sufficiently large setup.  But wouldn't it be nice if the kernel not
only told you whether a file has been modified, but told you immediately
after it was modified?

Yet another reason why there has to be a common cache and significant
kernel management -- if I've got a drive of less than, say, 5 gigs, I am
simply not willing to reserve any large amount of it for cache.  Take
the example of a source tarball being automatically extracted and the
contents cached.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTUpPHgHNmZLgCUhAQLhIg/9G87W4OCt8hOvTK+XniPgWGn+YC7t4fKy
mi4QowX1eLmnFEovprjSUzPgKRMeDSChZ8M1pvXXWJQ/iULE44WH8vNiH8H974zw
h5O8dNI/AczuzaCalQ+BYXEGM8pasaCGCI/sLrr+WBy97NOpM2VUUKY+qKxSFWFt
x7u7/XCGGWSHVG3t3KzpkqD2K8u3IGSrV/vHIR2PLatEXu3G8K8sUAhfXMgFsTFp
gQAuQN/YzQKGUphnMzFWLDMYyEYjAA4VACZFqFz9QJIYeWzP+YmGdLfZ5mzN91JF
g5ACGHUxbYdjZsjTh6RbalVr1HpAAy8mvGNydbwUvuOxaXBvH44vUfRLnvIUoZs9
BB0Tq4xPqAwAtP0Z7b5Qem1ef3gqGXo1hfsEJWJZPv1lssYzn1+Jpn99p6N6VkXI
fbAHnypbHeYbf30lC5lvID0yngb+s5EUaxzxOYqFA8QpEJD/bl3S9Qx6bpom/9AL
U8kdK8QjNbhHSMrOpl8mg77VRLXdINoV7R5iSXXUMdIcA1j+4R1AIPh62JAMwQDF
/Vzek8KNyxvJDgF/y78LiGETZcG/l2W4szEsJFFF4iIKLri5+OFGiLFz8jVNViKu
Lr7Q7u7TgWSSykdTrHFcR/WRupAHeL5RB5DA9HBZErqgAgJWz/Rjv743G8PYFKs8
oPhRyePnFkE=
=cQLE
-----END PGP SIGNATURE-----

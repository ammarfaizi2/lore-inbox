Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVF0GXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVF0GXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVF0GXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:23:41 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:25612 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261850AbVF0GSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:18:33 -0400
Message-ID: <42BF9A34.7010204@slaphack.com>
Date: Mon, 27 Jun 2005 01:18:28 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506270538.j5R5cww2005785@laptop11.inf.utfsm.cl>
In-Reply-To: <200506270538.j5R5cww2005785@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Kyle Moffett wrote:
>>
>>>On Jun 26, 2005, at 22:37:48, David Masover wrote:
> 
> 
> [...]
> 
> 
>>That just means the zip plugin has to be more carefully written than I
>>thought.  It would have to be sandboxed and limited to prevent buffer
>>overruns and zip bombs.
> 
> 
> [...]
> 
> 
>>Remember that zip, at least, would not be in the kernel.  I think what
>>is going in the kernel is gzip and lzo, and it's being done so
>>transparently that you never actually see the compressed version.
> 
> 
> Doesn't matter if it is zip of some other compression, the problem is
> exactly the same.

zlib is in the kernel.  Isn't lzo also in the kernel?

The problem is still the same, but not as bad.

And it's completely irrelevant to the current cryptocompress.  Saying
that someone could create a malicious transparently-compressed file that
blows up when decompressed (inflated?) is like saying that my /dev/hda5
is no longer trusted.  Because that's the only layer at which a userland
program can see the compressed version of a transparently-compressed file.

Now, if you're talking about going the other way, I think the problems
were less about buffer overflows and more about bombs where 1k
compressed data = 1 gig uncompressed data.  Going the other way is kind
of pointless if you're an attacker.

Unless there are buffer overflows in the kernel's zlib.  I hope not!
After all, I don't necessarily trust all the CDs that I try to mount!

>>>Can you illustrate for me with precise, clear, and unambiguous arguments
> 
> 
>>That will take some time.  And some thinking.
> 
> 
> See? Exactly what has been demanded by all the "unfair", "ReiserFS-racist",
> "shove-any-junk-but-do-not-accept-perfect-filesystems-into-the-kernel" etc
> people here on LKML from the very start.

Back at ya.

Many of the people I can't abide here are people who don't seem to
actually understand anywhere near as much of Reiser4 as I do.  And I've
never read much of its source code.

It would be nice if this was approached more along the lines of helping
get good stuff into the kernel than keeping anything bad out.  But
that's too much to ask, no sarcasm intended.  Didn't Linus say that his
job is more to keep stuff out anyway?


> [...]
> 
> 
>>Now, the cryptocompress as it currently stands does not involve ... and
>>does not introduce any new security holes in the way that you are
>>describing.  There might be some issues with key management (someone
>>hinted vaguely at that), but nothing insurmountable.
> 
> 
> OK, I see a week of flamefest going by until you admit it has the same
> problemas as compression

Did I admit that compression has problems?  I admitted that zip has
problems, not the planned cryptocompress plugin.

> and then a whole lot of its
> /own/ problems (that somebody can peek at a cached uncompressed copy of my
> files is not so bad, if they can peek at my decrypted files I'd be rather
> less pleased... and here you have to include a malicious root (Yes, I'm
> paranoid. Doesn't mean root is not out to get me.).). Perhaps this can't be
> all solved, but the exact boundaries of what /is/ provided, and what
> /isn't/ must be made clear.

Can't trust the kernel at all if root is malicious.  For that matter,
can't trust anything if root is malicious.

Or is there a system which blocks such things as keyloggers, kernel
modifications, eavesdropping on random ptys, or simply brute forcing
/dev/mem?  I don't see any existing solutions other than heavily patched
everything (text editors included) for even blocking simple temporary
file hijacking.

Now, if root is not malicious, we can just go back to UNIX permissions
to keep your files safe -- only now your stuff is safe if the FBI steals
your disk, and I assume your root can be trusted to power off the system
before they can touch it in that event?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+aM3gHNmZLgCUhAQLEGw//YgLNHfZNRBBD9wFd6Si0xnl+75eAwqOm
7WMDPdtXeZORhUnmNnS+EO71nMupUQmOaMI/AGbAJgTRHJKAiVKz1rt25TtMfkMg
tOeZ4PGOmI2eMe2Ltw8ocR6YDYLc/2VTLCE51pCvVswHPbcY2W+j1JHoIwo/y/3f
/WnO8QYNdGnvlYJB+smNEpO8ggwPItK5Ge2PoK1+3A+e+boX2xZyk3RzZ5Oth3Se
H8oW9wfNXoXp50BjVRXcCcOSbHiFFYWMRUD/i3izFwB3JNS523rMLjyJH/5zeciL
lW+b9dCjHqt0ULtkuw0gVbEQh4LTPBKM8WIKDRNkuFl9kz8FQk0BuQrpvmr8JZ3z
4S4etxhdnmuxMkXznJ0ioUTa+p7hXjRxpN1wZLXQi9xJfnOEkUHazI8GZui7qrlQ
UlRyxyZTezEfROk+Ova0DWfAJEV4qY2SktxXZeMr7Z2a8WdkdozfPOFHt1GG38c4
xc/L5z2maXAG0fQbZPZtrYi65ES5MQ472T6KNnwNb3nFJr1CRO0l4PpZa6kNLQ1G
XDKKpsPUR9A1/oOh81Ep1YN+RfJKWJCU3O59z1+ro3eKa1ckWEjX2TEwKIjeUaGd
B8n5FenOsSslHw1of1aVCRyNVUMFH2wTRf0CcIVBIMxZJ/RhJ6m2tqbOIsIK4V+H
rMEvogPEbtM=
=1+LH
-----END PGP SIGNATURE-----

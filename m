Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVAGAOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVAGAOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVAGALF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:11:05 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:51906 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261711AbVAGAGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:06:15 -0500
Message-ID: <41DDD26A.4090705@comcast.net>
Date: Thu, 06 Jan 2005 19:06:02 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
References: <1697129508.20050102210332@dns.toxicfilms.tv>	 <41DD9968.7070004@comcast.net> <1105045853.17176.273.camel@localhost.localdomain>
In-Reply-To: <1105045853.17176.273.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
| On Iau, 2005-01-06 at 20:02, John Richard Moser wrote:
|
|>experiments have no place in production; if your "stable" mainline
|>branch is going to continuously add and remove features and go through
|>wild API and functionality changes, nobody is going to want to use it.
|>Mozilla doesn't support IE's broken crap "because IE is a moving
|>target."  Unpredictable API changes and changes to the deep inner
|
|
| IE hasn't moved in years. The inventiveness of the bad web page authors
| might be unbounded 8)
|

8)

|
|>workings of the kernel will make the kernel "a moving target."  If
|>that's the route you take, it will become too difficult for people to
|>develope for linux.
|
|
| Its also impossible to do development if none of the changes you make
| get into the kernel for stability reasons ever. Its a double edged
| sword. For most end users it is about distribution kernels not the base.

Well, I was thinking more that the 2.6 development process is a very
clean edged process, and should be preserved specially.  More to the
point, I was considering the potential to move the 2.6 scheme to 2.7.

The even branches would thus again become "Stable," only getting
*bugfixes*.  I say bugfixes because they encompass security fixes.  I
don't think backporting drivers would be a bad thing; but somebody has
to maintain that.

The odd branches would become "Volatile," continuing as 2.6 does now.
This doesn't mean you break them horribly and then start cleaning up the
mess; it means you continue to place invasive changes that are
relatively stable, and try to clean up.  This has been proven already to
be an excellent development model in terms of reliablility and usability
of the product.

With a stable/stagnating "Stable" codebase, third party development can
focus on getting real work done and not chasing API changes or altering
the specs to match with core changes.  For example, the compressed
pagecache patch[1] and PaX[2] both have to adjust heavily to VM changes.
~ This is a lot of work, and can become detrimental to their development
([1] is pretty much dead) if it occurs unpredictably or, especially,
rapidly.

The "Stable" codebase is also useful for businesses which need a
reliable system without the need to do 3-5 months of extensive testing
every 6-8 weeks.  With bugfixes only, upgrading would be basically
testing in a lab for several hours, then giving the go-ahead to drop in
a new kernel with 5 security fixes and 2 FS corruption fixes.  The
individual patches could be audited by technicians between upgrades too,
since they'd be mostly just a handfull of code.

With a 6-9 month release cycle, new features would still come out in a
timely manner.  Home users with a bleeding-edge impulse would just run
the "Volatile" branch anyway; it's good enough for 2.6 stable, it's good
enough for them.  Businesses don't tend to have the desire to run the
latest awesome O(pi/4) scheduler and decaying object based quantum rmap
VM core, at least not until it's gone through lots and lots of testing.

As another plus, most external development would be on the same page.
Thus distributions would be able to keep their kernels mostly "up to
date" without picking and chosing between sets of patches based on who's
on what version.  You wouldn't have to chose between translucency on
2.6.8 or supermount-ng on 2.6.10, or realtime IRQ preemption and
on-access userspace triggering for antivirus scans on 2.6.12.  You
wouldn't have to do tons of work to hack these together either, and
probably release a buggy kernel as you cross more bounds than you'd
intended to.

If up to 3 releases were supported, a 6 month release cycle would give
18 months of continued bug/security fixes on any given kernel before it
was officially unsupported.  This figure approaches 27 months as the
release cycle grows towards 9 months.  A new release is always ready, too.

Please tell me where I'm wielding a double edged sword here.  I don't
honestly expect the kernel devs to change the scheme "Because I said
so," but I think the arguing should stop and we should focus more on
determining if there is a better way, and how to do it if so.

[1] http://linuxcompressed.sf.net/
[2] http://pax.grsecurity.net/

|
|
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3dJphDd4aOud5P8RAh/BAJ9PsXdmbcqs7d8I413FrhciEm3AmwCghkDg
8tzr8WTV6vYjy8+o2/Su0jg=
=Hj/7
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269982AbUIDA0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269982AbUIDA0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270000AbUIDA0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:26:17 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:3973 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269982AbUIDA0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:26:02 -0400
Message-ID: <41390B88.2040307@slaphack.com>
Date: Fri, 03 Sep 2004 19:25:44 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Jamie Lokier <jamie@shareable.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	 <200408282314.i7SNErYv003270@localhost.localdomain>	 <20040901200806.GC31934@mail.shareable.org>	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	 <1094118362.4847.23.camel@localhost.localdomain>	 <20040902161130.GA24932@mail.shareable.org>	 <1094146912.31495.13.camel@shaggy.austin.ibm.com>	 <4137B9FC.7040708@slaphack.com> <1094215839.2680.17.camel@shaggy.austin.ibm.com>
In-Reply-To: <1094215839.2680.17.camel@shaggy.austin.ibm.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Kleikamp wrote:
| On Thu, 2004-09-02 at 19:25, David Masover wrote:
|
|>Dave Kleikamp wrote:
|>[...]
|>| Please don't tell me that we have expectations to run make from within a
|>| tar file.  This is getting silly.  tar does a pretty good job of
|>| extracting files into real directories, and putting them back into an
|>| archive.  I don't see a need to teach the kernel how to deal with
|>| compound files when user space can do it very easily.
|>
|>Suppose I've got a tar file with an index attached.  Suppose it's
|>something like /usr/src/linux.  Am I expected to extract all code for
|>all architectures, with all drivers, all docs, etc?  Now, yes -- or I
|>have to figure out exactly which ones I need before I extract them
|>manually, one by one.
|
|
| I don't think it's unreasonable to expect someone to either extract the
| whole tar file, or identify what files they want from it.  If you think
| there is too much in the tar file, roll your own with only the files you
| need.

That is not a solution, that is exactly the opposite of a solution.
"Roll my own" implies that I must download the tar file, extract the
whole thing, grab what I need, and then tar it up again.  Then I extract
it again.  Doh!

More seriously, suppose it's a format like zip, where I don't have to
decompress the whole file to get a listing.  And suppose I want to
compile some little example from it, but the file itself is huge -- half
a gig, say, and I only need ten megabytes.

But the only way I'm going to find out _which_ ten megabytes I need is
to extract the Makefile, read it, then go find all the other little
Makefiles, not to mention the configure script, the header files, and so
on...

But suppose that make can _transparently_ extract _only_ the files I
need for this?

|>But with tar support for make (and so on), files can be extracted on
|>demand.  It's possible to do this in userspace, with named pipes, but
|>that's much slower and insanely clumsy.
|
|
| This doesn't justify bloating the kernel.  untar the darn thing and user
| space does fine.

Does it really bloat the kernel?  My kernel doesn't feel bloated, and
it's got reiser4 and much of what's needed for this.

Remember, saying "I can access foo.zip/contents" doesn't mean "zip is in
the kernel".

|>This has further implications -- imagine a desktop, binary distro
|>shipped with all files except the very most basic stuff as package
|>archives.  They can all be extracted, on demand -- the first time I run
|>OpenOffice.org, it's installed.  If there needs to be post-installation,
|>that's handled by the .deb plugin (or whatever).
|
|
| Are you saying install it on demand the first time it's run?  This
| doesn't take any new kernel function.

It does for it to appear installed.  And to only install the pieces that
are needed at that time.

| Or are you saying that the files are never installed on the filesystem,
| but always accessed from the package archives?  In this case, why not

No, only that if I only wanted OpenOffice writer, why should I install
all of OpenOffice?  Yes, it could be broken into smaller packages.  What
I'm talking about is exactly the pieces of an installation that you need
- -- insanely fine granularity -- done automatically, on demand.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTkLiHgHNmZLgCUhAQK7+A//TATQvQ3U61VA/mdVqylnrkWC7tNOewwq
MqF+KKU3Cc/n54mOlGTpph2qpPJTzv1y4KlVgcDM/d0bn1cDPx41n//xEe9QXlqu
vOywb8g11HSlAhKmbl4APwCHFHr1HibHgYqM7PmeVSD+Xfy5gJvIW5Oc44f16+q9
agEXWAk0EgM0WCAKEQFxN56i8e7qHq28PPGzcpGcn08xmBmD9Ik71jjpLY88csYy
kjH32ExEy+uABq+Tglfr0EBZR4RDuqkxsei7cL3Rn58O8twJtn8UP3VcukTLciZw
jb7If3ekuO7BXYJbwB/foFEESFql68jNKH7c7+Bzeb5pREloreVine/2rRM1iekD
FUeTv78kn+6G/INl9XwUB2ER0KZOy8n2wZut35T5w94GtZgmdHpm+3mCOscS6BdG
JNx/HRGJJXfm0P/7tKbgZ/3wjQlFzbC5HcByn9Ocfm8qrNsoLxwtF/8aId/9ctD9
lEmDMUHYuVC51/m5ka+i/XUQeuzgbtY5QKoNsxWXYZfeBNQfMqfMOsVWP1wFMlpB
mPmf6w+4idp1aIYwgvPyQee1BZiXmkbncglcnY+J4y46AZ+tDEO5eqjJrEU9kA7v
NNVfCehCZ2IIo1TMHcQizsHQ53NEmZ5gwCYXvymGS1+6fyE0SqcP9EolVuUfnRN9
yNdulMJ0gDg=
=TeOM
-----END PGP SIGNATURE-----

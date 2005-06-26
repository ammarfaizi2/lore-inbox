Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVFZHsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVFZHsU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVFZHsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 03:48:20 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:29200 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261489AbVFZHsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 03:48:07 -0400
Message-ID: <42BE5DB6.8040103@slaphack.com>
Date: Sun, 26 Jun 2005 02:48:06 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	 <42BCD93B.7030608@slaphack.com>	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	 <42BDA377.6070303@slaphack.com>	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com>
In-Reply-To: <42BE563D.4000402@cisco.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lincoln Dale wrote:

[...]

> this is the WHOLE point of standardization .. i don't think its that
> Reiser4's EAs offer any more or less capabilities than standard EAs -

They do.  Reiser4's EAs can look like any other object -- files,
folders, symlinks, whatever.  This is important, especially for
transparency.

For one thing, can I access a Beagle search as a folder?

> BUT they haven't used the standard mechanisms available for implementing
> them, such for Beagle to work on Reiser4, there now needs to be logic
> added to Beagle to do so.

Well, ideally, I'd like to see people stop bickering, come up with
something better than sys_reiser4, add an emulation layer for xattrs and
mark them obsolete.

But I don't speak for Namesys.

> lets take this a step further.  what about compression?  do we accept
> that each filesystem can implement its own proprietary compression via
> its own API - and now we need individual user-space tools to understand

No, that's the beauty of these "EAs" in Reiser4.  The API is standard
write(2) commands.  sys_reiser4 supposedly implements an interface to
make this scale better, but otherwise have the same semantics.  And who
said anything about proprietary compression?  I think we were planning
on the kernel's zlib, though we might have been planning to make it a
bit more seekable...

> each of these APIs?

So, the API becomes something like:

cat crypto/inflated/foo		# transparently decompressed
cat crypto/raw/foo.gz		# raw, gzip-compressed

Another possibility, if you like file-as-a-directory:

cat foo.gz			# raw
cat foo.gz/inflated		# decompressed

One could easily imagine things like these two potentially equivalent
commands:

cp foo bar.zip/
zip bar foo

The whole point is to have less userland tools, not more.  I'm not
saying we move zip into the kernel, just that the user now has one less
command to remember.

But, back to reality.  file-as-directory probably won't happen, at least
not for awhile, so imagine more along the lines of my first example.

> how about encryption?

About the same, only now you have a key file that you write to in order
to unlock the decrypted files.

> ... and so-on.
> suddenly every user app out there needs to have specialized knowledge of
> each type of filesystem.

Not really.

More like, every app that cares to has generalized knowledge, if that.

> none of this is rocket-science.  its just plain common sense.

I could say the same of my stuff, but lots of people seem to disagree
with me, or at least fail to see it.  I guess I can say the same of your
comments.

>> It's a filesysem for gods sake. Hans and his team have worked hard to
>> minimize its impact and they are still willing to accept more
>> guidance,
>>
> i don't see any acceptance at this point.  simply lots of hot air that
> smells like marketing & PR.

They do keep asking for specifically what they need to do to put this
stuff in VFS.  Or am I wrong?

Or maybe it should be obvious to them?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr5dtngHNmZLgCUhAQIBGxAAiLK6EyHnLRhEA+rUIDCwacM4K89wlE7X
+dcw3xv3Pc9tZZqVVAd7Y27whEzjmNOwfGkvPkzPk/ATQditnyt+7xHcuXpqORNU
j7zHc5zS8MGDRU8Re4MXTO6jCXDgtTwQHjcdg4i8KYWLMPT7LpO+DHY/mZyQEgpD
kZGE4WJePA+aNlHAzySW9u/atnwp5hSRvmfuF4zzN8ng5tf8SSMvbfoCyjYSue8l
N6jvcGnt+yItmbHVaij0IdHUw1/9/u6b3Q0Ut39NBk8fUKXJcASHmKtjwLTAoWW+
hiYVhLdZQGkWo2d6XdzdNY2OgE3kWVnLBqrOuTo7zCjMojvWIrEGE/x3Yh/E6Hs8
cAPVRebG5yUQBxJk1lcDeJOBozutIpCVyTzwBnKU1nz3KArqanU51oT++3cTjVha
1tBnaLS4RLcdy8UD1ewS+VHj61VSlcBjv2abCrYw4DC0anUFrYUSciNjx3tdYJRx
o7l/pEn7UYPpGaXgHyBdVDIRlRNdOoTRZp3aIY2Z2v6/jyi3TeufMUjGtpuQHl2k
BuYm7tV4l1Ec/QZLM+PbAyVU9qqlz9BuHlI1U7z1p3gYeAzz0guAeDHfi1l95sUn
l+bFCOfmXi3qRAxVZyidczqeOtGtCed3nIUH+1z+siuFzH3jecjzUpGWKcGxzVlc
jkUS+tlihfg=
=C4UP
-----END PGP SIGNATURE-----

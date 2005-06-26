Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVFZWkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVFZWkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFZWjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:39:04 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:12300 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261643AbVFZWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:35:53 -0400
Message-ID: <42BF2DC4.8030901@slaphack.com>
Date: Sun, 26 Jun 2005 17:35:48 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>            <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
In-Reply-To: <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 26 Jun 2005 14:58:07 CDT, David Masover said:
> 
> 
>>"Plugins" is a bad word.  This user's combination of plugins is most
>>likely identical to other users', it's just which ones are enabled, and
>>which aren't?  If they are all included, I assume they play nice.
> 
> 
> Which ones are enabled. Exactly.

I doubt there will be duplicate plugins, once things settle down.  So
you just have the program demand certain ones to be enabled.

>>And just because they are called "plugins" doesn't mean the EA looks
>>different every week.
> 
> 
> They do if the one enabled this week is "make EAs look like symlinks", and
> last week's was "make EAs look like folders".

We could just as easily do that with other extended attributes.  Sure,
the details would be different -- maybe we just randomly add a XA onto
the beginning of every string.

> (Don't blame me, *you're* the one that said "EAs can look like any other object"..)

Doesn't mean we can't guarentee a certain kind in a certain
configuration will always be available for a certain plugin, once it's
been accepted.
> 
> 
> 
>>>And 'cat crypto/raw/foo' or 'crypto/inflated/foo.gz' gets you what, exactly
> 
> ?
> 
>>>Now throw some .bz2 and .zip files into the mix... ;)
>>
>>Interface is the same.  Only, zip files aren't just compression, so
>>maybe the interface changes a little there.
> 
> 
> Right. So please explain what crypto/raw/foo and crypto/inflated/foo.gz give you.

In that example (shouldn't have used the name "crypto", but oh well), it
should be crypto/raw/foo.gz and crypto/inflated/foo -- where foo.gz is
the gzip'ed file and foo is the transparently compressed/decompressed
file.  Basically, these are equivalent:

$ zcat crypto/raw/foo.gz
$ cat crypto/inflated/foo

>>Point is, now you have a standard interface for any program to access
>>any simple lossless compression, transparently.
>>
>>
>>>>Another possibility, if you like file-as-a-directory:
>>>>
>>>>cat foo.gz			# raw
>>>>cat foo.gz/inflated		# decompressed
>>>>
>>>>One could easily imagine things like these two potentially equivalent
>>>>commands:
>>>>
>>>>cp foo bar.zip/
>>>>zip bar foo
> 
> 
>>>Unless of course the user had done 'mkdir sorted.by.city.zip' to make
>>>a directory of files containing data sorted by USPS Zip code.
>>
>>What's this got to do with anything?
> 
> 
> It's got a *LOT* to do with it if I created a *DIRECTORY*, to use *AS A DIRECTORY*,
> the way Unix-style systems have done for 3 decades, and suddenly my system is
> running like a pig because the kernel decided that it's a .zip file.

The kernel does not decide that.  You do.  And it doesn't automatically
decide that every time you create a file.  You have to use some
interface to trigger the plugins.

Originally, this was file-as-a-directory.  Now?  I'm not sure, I guess
we could use a separate delimiter.  Something like:

foo	# file
...foo	# directory containing xattrs of file, list of plugins used.

foo/	# directory
foo/...	# directory containing xattrs of file, list of plugins used.

I guess I need a new name for this approach.  That's three possible ways
of doing this?

>>>And what happens if the user has a file 'bar' that's not a ZIP file,
>>>and a directory 'bar.zip' isn't a view into 'bar'?
>>
>>In file-as-a-directory (which is probably NOT happening soon), bar.zip
>>is both the actual zipfile and the view inside, depending on whether you
>>try to open() it directly or peek inside it as a directory.
> 
> 
> Ahem.  "bar.zip' is a *DIRECTORY*. I said 'mkdir bar.zip' - why is it not
> acting like a directory?

If you said "mkdir", it would act like a directory.

More likely than foo.zip/bar would be foo.zip/.../contents/bar.  Which
would also work for tarballs.  But would not automatically compress
anything you didn't want it to.

>>However, let's not discuss this now.  I do NOT want to start another
>>"silent semantic changes with reiser4" thread.  File-as-directory is not
>>happening this time, so don't worry about it -- this time.
> 
> 
> Fish or cut bait.  You are the one who started handwaving the 'file-as-directory'.
> If you don't want it discussed, don't mention it.

I do want it discussed.  I'm not sure it's a good idea now.  But looks
like you got me...

>>>Most of the time, if I have a file 'linux-2.6.12.tar.bz2' and a
>>>directory 'linux-2.6.12', what is under the directory is *NOT* the same
>>>data as what's in the .bz2 - I've done 'make oldconfig' and a few builds
>>>and some variable amount of patching, usually with rejects, and I *don't*
>>>want that .bz2 being updated during all this (hint - what's my next command
>>>after 'rm -rf linux-2.6.12' likely to be, and why, and  what expectations
>>>do I have when I do it?)
>>
>>You're misunderstanding.  man zip.
>>$ zip bar foo
>>creates/modifies a file named "bar.zip", not "bar", which contains the
>>file "foo".
> 
> 
> No. *YOU* are misunderstanding.  I have a directory 'linux-2.6.12', and
> I have a file 'linux-2.6.12.tar.bz2', and I do *NOT* want directory operations
> to be silently converted into "let's scribble into the middle of this tar file
> and then compress it".  (Hint - work out how long a kernel 'make' would take
> if you were doing it inside a .tar.bz2).

I remember discussing that, actually.  It wouldn't automatically do this
if you didn't want it to, but it would be nice if, say, it was something
truly seekable like linux-2.6.12.zip, and linux-2.6.12 was a
user-created symlink to linux-2.6.12.zip/.../contents, and we had a nice
caching system...

This is nice because then you get exactly the same performance during
"make" as you would with "unzip && make", only better, because files you
don't ever use (lots of arch, for instance) are not unpacked.

This is all something that's been discussed before.  I think the
consensus was that it sounded cool, but not useful enough by itself to
justify file-as-a-directory.

You can always go re-read "Silent Semantic Changes..."

>>>You want to think this sort of thing through *really* thoroughly, because
>>>there's a *lot* of things, both users and programs, that have expectations
>>>about The Way Things Work.
>>
>>Or, I can avoid those issues altogether, and simply delegate this kind
>>of stuff to user-created-but-magic directories.  For instance, I could
>>have a directory called "/foo" which contains encrypted files, and
>>"/foo/decrypted" which has transparently decrypted representations of them.
> 
> 
> So rather than everything working in a funky manner, a program gets to guess
> how funky, and in what direction, a given magical directory is....

It doesn't have to guess, it can know if it needs to.  Although this
probably wreaks havok on traditional backup systems.  You'd have to
implement a somewhat new backup system, but it's not impossible, and
certainly doesn't require that your new backup system know about every
plugin -- just make sure plugins know about backup.

Of course, file-as-directory avoids all that -- you just have to patch
programs to know that if foo/ exists or foo responds to opendir, foo is
not necessarily a directory.  You probably just drop the trailing / and
use stat().

Both (all three?) appraches have cans-of-worms and workarounds.  But I
think both (all three?) are doable.  I know user-created-but-magic is
doable.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr8txHgHNmZLgCUhAQKOxA/+KP1lmUgmrbEH+kPKriSFF3qFfFBgbeJh
iebHVaOY4AMa99a3yHy8iA5ZyE5N2b3CEueoq44ygYs5gqeft1IF14SJweNk/6or
IgGt+OsAkqDMdbbpKZdDGo8lZK0bJq/Ni+PMzx44sMGg4vWIHGAQfDGZ9FYRmrRT
fLNprUrkUsIzVEDHcuYjrZfPHvqr4HK8KXa5IJIKj6WkCYj5gxkQlH3g9zEaWXlN
Mfsqr6uioK34vKEgQw9HvpDpMZaB5NpZ7RWr5vEP3G3AV120VNKIEqU09Pex/IJD
oiOaroR7y1OZUaLuTSyut+4MGjHJ7k6TNr8H/CFdRfpLs7mP5tsJG42rzAhqTdyP
2D2m7sgpEN8ALkGd+IU3ihLOVQCrSq2T0jpr6tFhDe5uTenP3fXBeGgu8ynRzPFD
kkpyZhT094UWKoq8n+IcHQrIcba4j6X/jDJt7SDx8IwfZaPoMpcBGQH1//Q+lTuC
q5qM7olI5OzcSr4AhDld7OOjqO0pLXRfH5y8hy8mgWEiGgomK+N5OFTqXrQsuB/g
BopfBpqHRRYVpI1VkAutmTpyNjm3dQjrHmRWXX2sFe9lxExpWo9VX4By9ytv9EXQ
UFfSBF9TVe+EkZ4XxO+JMCcahNUsBh45rRXY3wVpH1qPwsOVp8FxYcOmuzQSTha9
mgOxWbRfqkQ=
=jrll
-----END PGP SIGNATURE-----

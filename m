Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVF0Xaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVF0Xaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVF0Xak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:30:40 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:52753 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262085AbVF0X1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:27:37 -0400
Message-ID: <42C08B5E.2080000@slaphack.com>
Date: Mon, 27 Jun 2005 18:27:26 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
In-Reply-To: <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:
> On Jun 27, 2005, at 17:19:21, David Masover wrote:
> 
>>> Precisely.  Come back when you have a good sturdy set of  arguments. 
>>> See
>>> the FUSE project (Also discussed in this thread), for better ideas 
>>> on  how
>>> to add strange filesystem semantics.
>>
>>
>> If I didn't care about performance.  I will read up on how FUSE works,
>> though, to see if there's anything in the _kernel_ code that would be
>> useful.
> 
> 
> A number of projects do their performance critical things in userspace,
> including real-time audio and video editing.  The kernel is *NOT* for
> performance-critical things, unless they cannot be done efficiently in
> userspace.

I don't think transparent compress-on-flush can be done efficiently in
userspace.

> It is for _security_critical_ and _stability_critical_  things,
> and even then, some of those are pushed to userspace as well.

There's more to it than that.  It is also for certain interfaces that
makes more sense in kernel space, or are there for historical reasons.
For instance, a filesystem could be done in userspace, with a userspace
library, but even FUSE uses the kernel for its interface, rather than
(say) glibc.

>>> NOTE:  Even the FUSE project,  which
>>> is in _userspace_ (as opposed to the massive kernelspace mess of  
>>> reiser4),
>>> is taking a lot of flak for changing UNIX semantics, so I see no  reason
>>> why Reiser4 should be special.
>>
>>
>> Right.  Kernel people hate change.  Got it.
>>
>> No, seriously, I have to respect the history involved, which is why  I'm
>> not pretending to know more than I do.
> 
> There is a good reason to hate change (at least without thorough  evidence
> to back it up).  Even small changes can break things in subtle ways.   Big
> changes can tend to wreak kernel-global (and even userspace-global)  havoc.

Right on all points.  Just remember that some change is good.  Why do we
have ALSA now?  Everything a user can do with ALSA, they can do with
OSS, AFAIK.

>>> Ok, good.  That's one of the first issues.  A _lot_ of applications
>>> would get themselves thoroughly confused at that '...' interface, not
>>> to  mention a lot of sysadmins :-D.
>>>
>>
>> Not as much as you think.  Unless a lot of applications can't handle
>> opening or saving files that have '...' in the pathname?
> 
> 
> If those files are as special as you lead me to believe, even a simple
> "tar -cjvf foo.tar.bz2 foo" would break horribly, because it would  tar up
> all sorts of strange special files that shouldn't be included.  Worse,
> when I untar that archive on the filesystem, it will overwrite those 
> files,
> which probably should be overwritten even less than they should be  stored
> in an archive.

Point well taken, although sometimes that's exactly what you want.  You
no longer need the -p flag to Tar that way, although you would want its
opposite, so that you can ignore '...'
> 
>> The sysadmin problem doesn't worry me so much.
> 
> 
> Personally, I know several sysadmins who, never having heard of Reiser4
> but using it anyways, would get scared when all of the '...' directories
> started showing up, thinking that some cracker had gotten a module  loaded
> in their kernel.

I'm not sure if the '...' or '..metas' directory is currently available
in Reiser4, but at one point it was the default, then it got changed to
a mount option which is off by default.

> If you can, please avoid overloading existing  semantics
> in filesystems.  You can either claim that your filesystem is POSIXy,
> (similar to ext3, xfs, etc), or you can claim that it's not  compatible by
> design (AFS, Coda) or you can claim that it's a completely virtualized
> interface (procfs, sysfs, CKRM fs, etc) and doesn't care about POSIX in
> any case.  Reiser4 definitely isn't the third, but neither is it  either of
> the first two, because it would break standard operations.

Reiser4 is attempting to extend POSIX without breaking it too much.

>> Agreed.  I don't know enough about VFS to propose one, though.  I  think
>> others are working on that, finally.
> 
> When the VFS work gets done, this discussion can move on, otherwise, we
> are stuck at an impasse.

Not my department.  It seems that people are agreeing on what needs to
be done, though.

>> Not too much, I hope.
>>
>> Although being able to use different keys on a per-file basis would be
>> nice.  I'm not sure if that would work in the existing system.  Not to
>> mention that keys would also be handlable with '...', if/when it 
>> happens.
> 
> 
> I think the '...' is just a bad idea in general, because it breaks tar
> and such.  An interface like this might be simpler to design and use:
> 
> # mkdir /attr
> # mount -t attrfs attrfs /attr
> 
> /attr/fd/$FD_NUM              == '...' directory for a filedescriptor
> /attr/fs/$DEV_NUM/$INODE_NUM  == '...' directory for an inode
> 
> It would be usable from a shell with a simple "getattrpath" command
> which returns "fs/$DEV_NUM/$INODE_NUM" by stat-ing any given path.

Still pretty annoying, but maybe a good idea, especially if the shell
gets extended to support it.  Not sure I like using inode numbers,
though -- I like the idea of being able to symlink to stuff inside the
meta-file dir.

Actually, I like this.  Give me some time to let it percolate.

Hans, thoughts?  Seems to be namespace fragmentation, but seems usable,
less breakage, and so on.  And should it be /attr or /meta?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsCLXXgHNmZLgCUhAQIXjQ/+OQc+KqDl+ybutM6Ba2KmaiwAJTdpIi40
DAO6n/vRkdO87r0vLU+g+3kpWyTqkIMrvGmbvm2dle/d+Q5yZc3fc3Lmg9tuwXyO
GDMA/Lhx/1ckVX3EtcQ8PUomhcCvCFebR/y8IuNgEEthsHcBHPaZD32xkke9Q7u7
0zUbFCry5mgiN3EuSGMy5q4ZvvETUteK/xoEcTGAhh3K3JMTp0N8dHGR8XkGb+Z9
qFG3mYu8g2uRAsZ6hFScQ/rf4j3fu9012Q0SxvEZoTLTNJjFnZhSRqyNSY4i24iV
OVYfstJrnpEWEAeEn29sTk0Pp5cHc8dh/Ure0MCOVHZUnMVD9xy259+3ivavePPn
N27Z7dMmqvf4bKdjqa35tK7bao78Of8EkGeW3v61VJe3qsG45SwpiLmYG/uEvtIw
u/9e/RlWQYyNS9k8eIxY6rjcrPjL4HErFiHmcw36wUmjyDqNYDlKtfsq0+KDGfOe
7I1G7TQc7K3uJu41XEqsG3IVQpY3o6bW8m7WyicRoOg3Qco+g/cjBBERmfAZh65W
t+t7tzk4p+UZfvSiqSfkRnm2CITrqFC0VW2c1pk42BmY0rJPfzRmVU5oBGlH1Avd
j75UFJi8qwm4d2S1InX8bxPoLaZpSjQGPAbpcKpZaaiM5mB3pfj62UVQV5hks9lt
QNzi7/gMmto=
=I2R/
-----END PGP SIGNATURE-----

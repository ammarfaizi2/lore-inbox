Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUIDS10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUIDS10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUIDS10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:27:26 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:29321 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S265395AbUIDS1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:27:13 -0400
Message-ID: <413A08FC.20903@slaphack.com>
Date: Sat, 04 Sep 2004 13:27:08 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: shaggy@austin.ibm.com, spam@tnonline.net, paul@clubi.ie,
       alan@lxorguk.ukuu.org.uk, jamie@shareable.org, torvalds@osdl.org,
       vonbrand@inf.utfsm.cl, bunk@fs.tum.de, reiser@namesys.com,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	<200408282314.i7SNErYv003270@localhost.localdomain>	<20040901200806.GC31934@mail.shareable.org>	<Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	<1094118362.4847.23.camel@localhost.localdomain>	<20040902161130.GA24932@mail.shareable.org>	<Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org>	<1835526621.20040903014915@tnonline.net>	<1094165736.6170.19.camel@localhost.localdomain>	<32810200.20040903020308@tnonline.net>	<Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>	<142794710.20040903023906@tnonline.net>	<1094216718.2679.30.camel@shaggy.austin.ibm.com>	<413908AB.90103@slaphack.com> <20040904134231.4e1974e0.skraw@ithnet.com>
In-Reply-To: <20040904134231.4e1974e0.skraw@ithnet.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephan von Krawczynski wrote:
| On Fri, 03 Sep 2004 19:13:31 -0500
| David Masover <ninja@slaphack.com> wrote:
|
|
|>| Just choose the right program.  tar groks tar files, not ls.
|>
|>tar groks tar.  bzip2 groks bz2.  gzip groks gz.  "mount -o loop" groks
|>images.  zip groks zip.  rar groks rar.  openoffice groks .sxw, unless
|>staroffice does.  xmms can read id3 info from mp3s.  gcc compiles C.
|>
|>If the file is an object, it's easier.  You can ask the file what it is,
|>and what you can do with it.  And you can tell it to do certain standard
|>things.  You can do all of this while reading almost no documentation on
|>what the file is.  At the end of the day, it won't matter to you whether
|>a file is zip, rar, or tar -- it's an archive, and you can extract it by
|>copying files out of its /contents directory.
|>
|>Your way (the traditional way) means you have to learn to use which
|>program is the right program and how to use that program, and you'll
|>have to remember it constantly.
|
|
| Just a short input from someone listening quite a while to this thread:
| I think your approach to the problem leads actually nowhere. The
reason for
| this is implicit in your own explanation. _Currently_ you talk of
archives, but
| as soon as you got that, what's next?

Anything sane.  Currently I talk of archives, because I need examples,
and archives have been a good example for awhile of something that can
gain things from plugins which they cannot get anywhere else, which have
implications immediately after the archive plugin is wrote, without
requiring any application support.

| Your idea needs abstraction, then you see the problem more clearly:
| An archive is only some sort of file type, just as (you already named)
mp3 or
| .sxw is another type. If you really want to do something _generally_
useful you
| should think of a method to parse and use all kinds of filetypes and
create an
| interface for that.

Fine.  It'd certainly be nice to use vim to edit an id3 tag, or a text
portion of a .sxw document (openoffice is HUGE compared to vim).

| And one thing is clear: as there are numerous different types you
cannot pull
| all that code inside the kernel. Obviously there should be a way some

I never said it should all go in the kernel.  I repeatedly said that
most of it should not -- all that goes in the kernel is the most generic
interface that is sane.  Obviously an archive plugin is different than a
compression plugin, but once you've got the archive plugin, the rest
(individual format support) can go in userland.

| application can install a hook, a helper, a plugin or whatever to provide
| extended functionality on its special filetypes. If you don't want to
use tar,
| you don't need the plugin either.

So you disable it at compile time.  I don't want to use XFS, and I
certainly don't want to use ATI's video drivers.  The latter I choose
not to download, and the former I choose not to activate.

| If you want tar, you should (as a user) be able to install the "fs-plugin"

If by "as a user" you mean "not root", I have to disagree.  I think it'd
have security implications.  It'd be great if I'm wrong.

| (just a name, do not shoot me for it) together with tar as an
application. You
| get the idea? Obviously this must be possible during runtime,
everything else
| is senseless.

I would love for this same attitude of "runtime or bust" to be more
common.  I would love for there to be a generic way to write a userland
fs plugin, just as there's a generic way to write a userland filesystem
(lufs).  Just understand that some plugins will be in userland, and some
will be in the kernel.

And, in fact, the part of the archive plugin that knows about
tar/zip/rar/whatever goes in userspace.  But the part that does caching
probably goes in kernel space, even if it becomes a more generic
"caching plugin".

| So, please, if you go on investigating this whole stuff do it in a
more general
| way, because "tar inside kernel" is not really what your idea is all
about, no?

Absolutely not.

| And one last obvious thing: if one doesn't want this kind of
file-handling, he
| should not need it. It has to be an add-on functionality, not a
replacement.

For awhile, yes.  But I can imagine that sometime in the future, an app
would need this kind of functionality.  And why not?  Is it so much
worse for an app to insist on "mp3 metadata plugin" than to insist on
"libid3"?

In any case, look at the current implementation.  I can do
	echo 750 > file/metas/rwx
but I can also use chmod, which is currently much more efficient.  I
think Hans wants to eventually create an efficient interface to access
lots of small files at once (or maybe this is done?) -- and his dream is
to see things like chmod replaced with a call to this interface.  But at
best, chmod will become a library call sometime years from now.  It will
never go away entirely.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQToI+3gHNmZLgCUhAQKEWg/9F0FZGxB2yXoo9l5UKI7Fvh19RlnpJvZE
D3DajNqxXZ5smYIba7QxATEwMLWNMwOdiJTDIcQ7jylbD3hTkp0uFQLXcS5FeWt5
yxA0oDYEHsW14aQov4pHGplHVvCHSkm6vJn/zU91QdJAZVYnH4na5NFuWsAIoUWi
5vigYTefavabFv0/RnyPCN6zFfn3hrjOnKqSELUXXleG/fV+XJVw3Nyg4DSe1hK+
xmXHFWkGC832tH052EH/CFlE17/K05QdpfBKYNzCFA5dvTtCs11OQZSggtGVipmn
cSycyDHtJraMdF78Qa8LZzjGiZbT/3befM6wrnekcwhjxCqok8CSbOvbVh2ENtiu
klNtHeQEEtm+4MhbEEkdiiuWaU7EHIFJFGYC6LJE0B4DAKDdi4TM9QbqxLW8HghQ
WUJfMh8H2FtqotjMsdDW0OCmSuzh0B4ZZ9EXvSMIttXBJ7T2+q442hm4PAFQWXSO
FPCAiUgGZ+ZCbyZI1/pjM+CGblMTCfCBOm8UI3MSjTTI7cVzWFrQHJSAUhCPIsxA
9RZlEvmg+ElbnGrJkpDggpToDFN5uHXj41r4CZBnXgjfUdA0jmHnWpzO29Smfu7i
cJPtN+LzR1Se+fz4IvYamWd1p/Mi3vQACPt4r3IGVKa27tYXzDw+CNa+CliHnczt
lAhISMnhoVo=
=7rV6
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291193AbSBLVpp>; Tue, 12 Feb 2002 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291197AbSBLVpg>; Tue, 12 Feb 2002 16:45:36 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:26022 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S291193AbSBLVpa>; Tue, 12 Feb 2002 16:45:30 -0500
Date: Tue, 12 Feb 2002 23:43:17 +0200 (EET)
From: guy keren <choo@actcom.co.il>
To: Pavel Machek <pavel@suse.cz>
cc: mulix <mulix@actcom.co.il>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        SA products <super.aorta@ntlworld.com>
Subject: Re: faking time
In-Reply-To: <20020212123954.A108@toy.ucw.cz>
Message-ID: <Pine.GSU.4.30_heb2.09.0202122334560.11756-100000@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Feb 2002, Pavel Machek wrote:

> > it's in alpha stages right now, but it seems pretty stable so far (It
> > Works For Me - i run it regularly on all of my machines). note that we
> > currently support only logging system calls (a-la strace) and failing
> > them with a user given parameter- rewriting system call parameters will
> > require additional hackery, but not too much of it - on the order of one
> > day of work. volunteers are welcome.
>
> Why do you need kernel module at all?

since we want to trace unknown processes. if you check the home page,
you'll see a few examples of situations in which strace, or any user-land
solution that does not trace the _entire_ system, can't handle properly.

we also want to have a minimal performance penalty - anything using ptrace
has a large performance penalty.

> BTW syscall rewriting is pretty hard (subterfugue solves that, but it definitely
> took more than a day.
>
> Imagineopen('/foo/bar')
>
> you rewrite it to open('/funny/bar')
>
> then another thread comes and rewrites it back to '/foo/bar'.

this is because you think of "rewriting the user process's memory" in
user-space. when the code is in the kernel - this is not the case.
ofcourse, you cannot insert a full python (or perl or whatever)
interpreter in the kernel [or perhaps you can? is this complete
blasphemy? :) ]. we do think of adding some interface to externalize
syscall tracing into user-land to allow people to still have such
features, but most usage we envision for this tool won't require that.

> Or imagine open(address in read-only memory).

again - you're talking about user-space intervention that actually
re-writes the user's data. we just want to invoke the syscall with
modified parameters - or to modify the data the syscall returns to the
user (whic won't stem from these race-conditions or r/o problems, since
the user _wants_ to receive that data).

i suggest that you take a look at the project's page if you wish to see
what we have in mind. personally, i hear of "a tool that already does
this" at least once a month. then i think "oh... why do we bother?". then
i go checking and see that it's not doing what we want, or its not doing
it right (user-land that slows the system and cannot trace the whole
system. or too limited filtering mechanisms. or kernel code that only
exports to user-mode, and thus affects performance. or kernel code that
requires patching a kernel, and thus cannot just be compiled and loaded
into a running machine, etc).

hope it helps,

--
guy

"For world domination - press 1,
 or dial 0, and please hold, for the creator." -- nob o. dy


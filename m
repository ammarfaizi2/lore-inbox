Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTHDPpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTHDPpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:45:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271823AbTHDPpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:45:33 -0400
Date: Mon, 4 Aug 2003 11:57:05 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030804170506.11426617.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.53.0308041142520.802@chaos>
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl>
 <20030804155604.2cdb96e7.skraw@ithnet.com> <03080409334500.03650@tabby>
 <20030804170506.11426617.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003, Stephan von Krawczynski wrote:

> On Mon, 4 Aug 2003 09:33:44 -0500
> Jesse Pollard <jesse@cats-chateau.net> wrote:
>
> > Find for one. Any application that must scan the tree in a search. Any
> > application that must backup every file for another (I know, dump bypasses
> > the filesystem to make backups, tar doesn't).
>
> All that can handle symlinks already have the same problem nowadays. Where is
> the difference? And yet again: it is no _must_ for the feature to use it for
> creating complete loops inside your fs.
> You _can_ as well dd if=/dev/zero of=/dev/hda, but of course you shouldn't.
> Have you therefore deleted dd from your bin ?
>
> > It introduces too many unique problems to be easily handled. That is why
> > symbolic links actually work. Symbolic links are not hard links, therefore
> > they are not processed as part of the tree. and do not cause loops.
>
> tar --dereference loops on symlinks _today_, to name an example.
> All you have to do is to provide a way to find out if a directory is a
> hardlink, nothing more. And that should be easy.
>
[SNIPPED...]

Reading Denis Howe's  Free Online Dictionary of Computing;
http://burks.bton.ac.uk/burks/foldoc/55/51.html, we see that
the chief reason for no directory hard-links is that `rm`
and `rmdir` won't allow you to delete them. There is no
POSIX requirement for eliminating them, and it is possible
"Some systems provide link and unlink commands which give
direct access to the system calls of the same name, for
which no such restrictions apply."

Perhaps Linux does support hard-links to directories?

mkdir("foo", 0644)                      = 0
link("foo", "bar")                      = -1 EPERM (Operation not permitted)
_exit(0)                                = ?

Nah... No such luck. I'll bet it's artificial. I think you
could remove that S_IFDIR check and get away with it!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


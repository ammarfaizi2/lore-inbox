Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUK1StE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUK1StE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUK1StE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:49:04 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:37132 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261561AbUK1Sqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:46:39 -0500
Date: Sun, 28 Nov 2004 19:53:34 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: Helge Hafting <helge.hafting@hist.no>, Amit Gud <amitgud1@gmail.com>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20041128185334.GA5329@hh.idb.hist.no>
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no> <20041125230937.GA2909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125230937.GA2909@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 12:09:37AM +0100, Pavel Machek wrote:
> Hi!
> > >
> > You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
> > 1. .tar and .tar.gz are complicated formats, and are therefore better
> >   left to userland.  You can get some of the same effect by using a shared
> >   library that redefines fopen() and fread() though.  It'll work fine for
> >   the vast majority of apps that happens to use the C library.
> 
> It is not same effect -- with shared library you get no caching. And
> that hurts a lot.
> 
The compressed file is still cached, and the library can cache
file contents in a shared mapping.  It does not have to
be a per-process thing.

> >   It is hard to make a guaranteed bug-free decompressor that
> >   is efficient and works with a finite amount of memory.  The kernel
> >   needs all that - userland doesn't.
> 
> If you have bug in decompressor, you are screwed, anyway, because you
> get remote user exploit when mozilla gets the file from
> web. Oops. [Ok, you at least do not get remote root exploit, but...]
> 
I don't worry about mozilla exploits - you get those from
nasty webpages as well.  I worried about a decompressor
cras (or random memory overwrite).  A userland implementation
will crash that particular userland process, with no ill effects on 
the rest of the system. 

A kernelside crash is much worse - it can hang the kernel and/or
mess up any process.  As for exploits - an in-kernel exploit
is even worse than a root exploit.  There are plenty
of thing even root can't do - at least not in 
straightforward ways.  The kernel has no limitations
whatsoever for what may go wrong.

Helge Hafting

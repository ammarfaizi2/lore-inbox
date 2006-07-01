Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWGAV6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWGAV6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWGAV6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:58:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36747 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750787AbWGAV6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:58:35 -0400
Date: Sat, 1 Jul 2006 22:58:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Theodore Tso <tytso@mit.edu>, Jeff Bailey <jbailey@ubuntu.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060701215823.GC29920@ftp.linux.org.uk>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 01:08:17PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 1 Jul 2006, Theodore Tso wrote:
> > 
> > This is going to be a problem given that people are hell-bent at
> > chucking functionality out of the kernel into userspace.
> 
> Btw, I'm not necessarily one of those people.
> 
> There _are_ some things that can be better done in user space, but on the 
> other hand, other things really are better off in the kernel.
> 
> The argument that user space is more debuggable has been shown to be 
> largely a red herring. User space is only more debuggable if it does 
> something independent, and we've seen that user space is _harder_ to debug 
> than kernel space if we have events going back and forth.

True.  However, that depends on the interfaces being used.  Sure, when
a twit "moves things to userland" by marshalling stuff through sysfs,
the only thing it achieves is more sysfs crap *and* more internal kernel
APIs being cast in stone.

However, when the code really is a series of normal syscalls (on the level
of "all we call is sys_something()"), it makes a lot of sense to take the
damn thing to userland and leave it there...

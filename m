Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUK3OJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUK3OJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbUK3OJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:09:29 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:3022 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262079AbUK3OJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:09:27 -0500
Date: Tue, 30 Nov 2004 06:12:04 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] relinquish_fs() syscall
Message-ID: <20041130141204.GE63669@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com> <1101729087.20223.14.camel@localhost.localdomain> <20041129135559.GC33900@gaz.sfgoth.com> <1101741440.20225.22.camel@localhost.localdomain> <20041130132744.GB63669@gaz.sfgoth.com> <1101822273.2640.52.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101822273.2640.52.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 30 Nov 2004 06:12:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > Can you really do that on normal file descriptors?  Weird.  I'd have thought
> > you'd need to open /dev/hd* to do that.
> 
> inb/outb after iopl.

That was already discussed earlier in the thread.

> > Is AF_UNIX in a separate namespace?  My understanding (from reading
> > unix_find_other()) is that unless you can create a UNIX socket in your
> > filesystem you're going to have trouble creating new UNIX sockets.
> 
> iirc there are anonymous unix sockets...

Ah, I see now -- the sun_path[0]=='\0' code.  I'll have to take a look
at that; probably just need to add a check to prevent jailed processes
from using those sockets (since they're supposed to be in a "null"
namespace)  Will investigate later this week.

It looks like this is also a weakness in code that currently uses
chroot("/var/empty")  It's not the end of the world since it still
requires a cooperating unjailed process on the same host as the jailed
one to pass in a fd which is quite an obstacle in most scenarios.  Still,
it's something that should be protected against.

-Mitch

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSHAWhb>; Thu, 1 Aug 2002 18:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSHAWhb>; Thu, 1 Aug 2002 18:37:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317299AbSHAWha>; Thu, 1 Aug 2002 18:37:30 -0400
Date: Thu, 1 Aug 2002 15:40:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <11294.1028240971@redhat.com>
Message-ID: <Pine.LNX.4.33.0208011538220.1277-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 Aug 2002, David Woodhouse wrote:
> 
> torvalds@transmeta.com said:
> >  Any regular file IO is supposed to give you the full result. 
> 
> read(2) is permitted to return -EINTR.

It is _not_ allowed to do that for regular UNIX filesystems.

It is allowed to return it for things like pipes, sockets, etc, and for 
filesystems that do not have UNIX behaviour.

> Regular file I/O through the page cache is inherently restartable, anyway, 
> as long as you're careful about fpos.

It's not the kernel side that is not restartable. It's the _user_ side. 
There is 30 _years_ of history on this, and there are programs that have 
been programmed to follow the existing documentation.

And the existing documentation says that if you return a partial read from 
a normal file, that means EOF for that file.

You may not like it, but that doesn't make it less so. Linux has UNIX 
semantics for read(). Linux is not a research project where we change 
fundamental semantics just because we don't like it. That's final.

		Linus


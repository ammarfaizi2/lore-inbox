Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSHBTYK>; Fri, 2 Aug 2002 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSHBTYK>; Fri, 2 Aug 2002 15:24:10 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:34058 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316675AbSHBTYJ>; Fri, 2 Aug 2002 15:24:09 -0400
Date: Fri, 2 Aug 2002 21:27:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers 
In-Reply-To: <Pine.LNX.4.44.0208020833110.18265-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208022025510.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 2 Aug 2002, Linus Torvalds wrote:

> Binary compatibility is important. As is the larger issue of generic UNIX
> compatibility. You had better have some really strong arguments for why
> you would think I'd be willing to break compatibility. So far you have had
> _no_ arguments for the question "Why?".

I never asked for breaking binary compatibility.
On the other hand I can give you an example, why I'd like to have a
choice. I expect from a good application that it recovers gracefully from
failures, so if I'm saving a file and the server goes down, I would
really, really like it if something happened when I push that stop button
or I press Esc and the application should offer me the possibility to save
the file somewhere else.

To implement this I would suggest using file flags instead of new task
flags:

	O_ATOMIC
	O_NONBLOCK
	O_SIGNALINT
	O_KILLINT
	O_DONT_BOTHER_ME

The first one might be useful for aio, it wants something like that
already anyway.
This way applications had a choice, how read/write should behave on
signals.

bye, Roman



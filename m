Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290839AbSBLJP3>; Tue, 12 Feb 2002 04:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290878AbSBLJOZ>; Tue, 12 Feb 2002 04:14:25 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32018 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290839AbSBLJMa>; Tue, 12 Feb 2002 04:12:30 -0500
Date: Tue, 12 Feb 2002 10:12:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: "David S. Miller" <davem@redhat.com>
cc: <davidm@hpl.hp.com>, <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <20020211.185100.68039940.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0202120947270.11317-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Feb 2002, David S. Miller wrote:

> It keeps your platform the same, and it does help other platforms.
> It is the nature of any abstraction change we make in the kernel
> that platforms have to deal with.

Of what "abstraction change" are you talking about?
Any change should usually help most architectures and so far the
thread_info change has only be done a few.

> 2) pointer dereference causes performance problems
>
>    ummm no, not really, go test it for yourself if you don't
>    believe me
>
> This only leaves "I don't want to do the conversion because it has
> no benefit to ia64."  Well, it doesn't hurt your platform either,
> so just cope :-)

That's simply not true. An extra load might be cheap, maybe on sparc it's
even free, but on most architectures it has a cost. Additionally every
access to current requires an extra load, so every function which uses
current will be larger, all embedded targets will thank you for that.
Where is the problem to allow these two implementations:
1.
#define current_thread_info() asm(...)
#define current current_thread_info()->task
2.
#define current asm(...)
#define current_thread_info() &current->thread_info

If you're unable to properly compute your structure offsets, you're free
to use the first version, I prefer the second.

bye, Roman



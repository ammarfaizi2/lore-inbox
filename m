Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSLDUBX>; Wed, 4 Dec 2002 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSLDUBW>; Wed, 4 Dec 2002 15:01:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7438 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267048AbSLDUBW>; Wed, 4 Dec 2002 15:01:22 -0500
Date: Wed, 4 Dec 2002 12:07:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEE5DE1.762699E3@mvista.com>
Message-ID: <Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, george anzinger wrote:
> 
> As a suggestion for a solution for this, is it true that
> regs, on a system call, will ALWAYS be at the end of the
> stack?

No. Some architectures do not save enough state on the stack by default, 
and need to do more to use do_signal(). Look at alpha, for example - the 
default kernel stack doesn't contain all tbe registers needed, and 
the alpha do_signal() calling convention is different.

If you want to handle do_signal(), then you need to do _all_ of this in 
architecture-specific files. You simply cannot do what you want to do in a 
generic way.

		Linus


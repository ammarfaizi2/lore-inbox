Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSLDUse>; Wed, 4 Dec 2002 15:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbSLDUsd>; Wed, 4 Dec 2002 15:48:33 -0500
Received: from crack.them.org ([65.125.64.184]:23710 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267081AbSLDUsc>;
	Wed, 4 Dec 2002 15:48:32 -0500
Date: Wed, 4 Dec 2002 15:56:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021204205609.GA29953@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	george anzinger <george@mvista.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
	"David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
	schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
References: <3DEE5DE1.762699E3@mvista.com> <Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212041203230.1676-100000@penguin.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:07:11PM -0800, Linus Torvalds wrote:
> 
> On Wed, 4 Dec 2002, george anzinger wrote:
> > 
> > As a suggestion for a solution for this, is it true that
> > regs, on a system call, will ALWAYS be at the end of the
> > stack?
> 
> No. Some architectures do not save enough state on the stack by default, 
> and need to do more to use do_signal(). Look at alpha, for example - the 
> default kernel stack doesn't contain all tbe registers needed, and 
> the alpha do_signal() calling convention is different.
> 
> If you want to handle do_signal(), then you need to do _all_ of this in 
> architecture-specific files. You simply cannot do what you want to do in a 
> generic way.

I think you should be able to call do_signal or a wrapper in some
platform-independent way.  Is the necessary information recoverable in
Alpha et al.?  What do you think of adding a standard wrapper function
so that system calls can process a signal if necessary?

Not only did George need this for POSIX conformance, I've seen a lot of
complaints about GDB interrupting sys_nanosleep even on cancelled
signals.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

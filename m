Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbSLTAqQ>; Thu, 19 Dec 2002 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbSLTAqQ>; Thu, 19 Dec 2002 19:46:16 -0500
Received: from crack.them.org ([65.125.64.184]:1252 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267672AbSLTAqP>;
	Thu, 19 Dec 2002 19:46:15 -0500
Date: Thu, 19 Dec 2002 19:53:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "H. Peter Anvin" <hpa@transmeta.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021220005333.GA20227@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	"H. Peter Anvin" <hpa@transmeta.com>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Hugh Dickins <hugh@veritas.com>,
	Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212181432470.1516-100000@penguin.transmeta.com> <Pine.LNX.4.44.0212181448100.1516-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212181448100.1516-100000@penguin.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 02:57:11PM -0800, Linus Torvalds wrote:
> 
> Btw, I'm pushing what looks like the "final" version of sysenter/sysexit 
> for now. There may be bugs left, but all the known issues are resolved:
> 
>  - single-stepping over the system call now works. It doesn't actually see 
>    all of the user-mode instructions, since the fast system call interface 
>    does not lend itself well to restoring "TF" in eflags on return, but 
>    the trampoline code saves and restores the flags, so you will be able 
>    to step over the important bits.
> 
>    (ptrace also doesn't actually allow you to look at the instruction 
>    contents in high memory, so gdb won't see the instructions in the
>    user-mode fast system call trampoline even when it can single-step
>    them, and I don't think I'll bother to fix it up).

This worries me.  I'm no x86 guru, but I assume the trampoline's setting of
the TF bit will kick in right around the following 'ret'.  So the
application will stop and GDB won't be able to read the instruction at
PC.  I bet that makes it unhappy.

Shouldn't be that hard to fix this up in ptrace, though.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

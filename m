Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSAZEEs>; Fri, 25 Jan 2002 23:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSAZEEi>; Fri, 25 Jan 2002 23:04:38 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:48514 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289016AbSAZEEZ>; Fri, 25 Jan 2002 23:04:25 -0500
Date: Sat, 26 Jan 2002 04:00:05 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-ID: <20020126040005.H5730@kushida.apsleyroad.org>
In-Reply-To: <18993.1011984842@warthog.cambridge.redhat.com> <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> <3C51FF0C.D3B1E2F7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C51FF0C.D3B1E2F7@zip.com.au>; from akpm@zip.com.au on Fri, Jan 25, 2002 at 04:57:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > NOTE! There are potentially other ways to do all of this, _without_ losing
> > atomicity. For example, you can move the "flags" value into the slot saved
> > for the CS segment (which, modulo vm86, will always be at a constant
> > offset on the stack), and make CS=0 be the work flag. That will cause the
> > CPU to trap atomically at the "iret".
> 
> Ingo's low-latency patch put markers around the critical code section,
> and inspected the return EIP on the way back out of the interrupt.
> If it falls inside the racy region, do special stuff.

Latency tests showed that fixed the problem as well as the cli.  It's
just _much_ uglier to read, is all.

Although it saves the cli from syscalls and interrupts, it adds back a
small cost to interrupts.  Fortunately, syscall latency is far more
important than interrupt latency.

If we're going to micro-optimise the system calls, then markers are
definitely the way to fix the return path race IMHO.

-- Jamie

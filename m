Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291125AbSAaQHO>; Thu, 31 Jan 2002 11:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291128AbSAaQHE>; Thu, 31 Jan 2002 11:07:04 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:18590 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S291126AbSAaQGw>;
	Thu, 31 Jan 2002 11:06:52 -0500
Date: Thu, 31 Jan 2002 11:06:59 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nathan Field <nathan@cs.hmc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: PTRACE_POKETEXT modifies memory in related processes
Message-ID: <20020131110659.A6197@nevyn.them.org>
Mail-Followup-To: Nathan Field <nathan@cs.hmc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.32.0201310055030.23602-100000@turing.cs.hmc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.32.0201310055030.23602-100000@turing.cs.hmc.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:43:00AM -0800, Nathan Field wrote:
> I believe I have found a bug in recent 2.4 linux kernels (at least 2.4.17)
> running on x86 related to using ptrace to modify a processes memory. From
> a quick scan of the 2.4.17 code it looks like ptrace.c:access_process_vm
> is not checking to see if the page of memory it is writing to has write
> permission, so it is not properly copy-on-write'ing. This means that if I
> have a simple program like this:

I don't think you're correctly understanding the circumstances.  Are
you setting the breakpoint after they fork (seems unlikely, given this
test case - not much time to do so)?  Otherwise, the breakpoint is
simply being carried over by your forking.  Why you see it now and did
not before I don't know.

I see the same behavior with both software and hardware watchpoints.

Basically, GDB on Linux does not support fork very well.  It doesn't
show up terribly often, because exec() clears breakpoints.

COW doesn't come into it.  The page is being modified before it is
copied.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

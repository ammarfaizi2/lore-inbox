Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287324AbSACPp4>; Thu, 3 Jan 2002 10:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287328AbSACPpr>; Thu, 3 Jan 2002 10:45:47 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:31707 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S287324AbSACPpe>; Thu, 3 Jan 2002 10:45:34 -0500
From: Joe Buck <jbuck@synopsys.COM>
Message-Id: <200201031545.HAA14668@atrus.synopsys.com>
Subject: Re: [PATCH] C undefined behavior fix
To: paulus@samba.org
Date: Thu, 3 Jan 2002 07:45:24 -0800 (PST)
Cc: jbuck@synopsys.COM (Joe Buck), dewar@gnat.com, velco@fadata.bg,
        gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org
In-Reply-To: <15411.52243.87016.442521@argo.ozlabs.ibm.com> from "Paul Mackerras" at Jan 03, 2002 02:12:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is already such a project under development: see
> > 
> > http://gcc.gnu.org/projects/bp/main.html
> > 
> > This is a modification to gcc that implements pointers as triples.
> > While there is a performance penalty for doing this, it can completely
> > eliminate the problem of exploitable buffer overflows.  However, programs
> > that violate the rules of ISO C by generating out-of-range pointers will
> > fail.
> 
> What will it do if I cast a pointer to unsigned long?  Or if I cast an
> unsigned long to a pointer?  The kernel does both of these things, and
> in a lot of places.

Perhaps you need to reread a book like K&R, second edition, to find out
what the C language promises you and what it doesn't.

The bounded-pointer approach represents a C pointer as three machine
pointers.  When you cast to unsigned long, it converts the "value"
pointer.  When you cast an unsigned long to a pointer, you lose the range
information, so the pointer's extent is anywhere in memory.  However,
if the compiler can determine by dataflow analysis where this value
came from it is entitled to put the original range information back.

> Part of my beef with what gcc-3 is doing is that I take a pointer,
> cast it to unsigned long, do something to it, cast it back to a
> pointer, and gcc _still_ thinks it's knows what I am doing.  It
> doesn't.

The C language standard defines quite precisely what the compiler is
allowed to assume and what it is not allowed to assume.  If you don't
like these rules, you will dislike *all* modern C compilers, especially
the expensive proprietary C compilers hardware vendors often use to
get good SPEC results.



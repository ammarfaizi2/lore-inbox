Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSBSTdo>; Tue, 19 Feb 2002 14:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289240AbSBSTdg>; Tue, 19 Feb 2002 14:33:36 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:23286 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289339AbSBSTd0>;
	Tue, 19 Feb 2002 14:33:26 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15474.43138.423593.512492@napali.hpl.hp.com>
Date: Tue, 19 Feb 2002 11:33:22 -0800
To: Jesse Barnes <jbarnes@sgi.com>
Cc: David Mosberger <davidm@hpl.hp.com>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
In-Reply-To: <20020219103506.A1511175@sgi.com>
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase>
	<15474.34580.625864.963930@napali.hpl.hp.com>
	<20020219103506.A1511175@sgi.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 19 Feb 2002 10:35:06 -0800, Jesse Barnes <jbarnes@sgi.com> said:

  Jesse> Making a variable volatile doesn't guarantee that the
  Jesse> compiler won't reorder references to it, AFAIK.  And on some
  Jesse> platforms, even uncached I/O references aren't necessarily
  Jesse> ordered.

It certainly does for on ia64-compliant system.  Check section 9.3
"Multi-threaded Code" in the "Itanium Software Conventions and Runtime
Architecture manual".

  Jesse> To avoid the overhead of having I/O flushed on every memory
  Jesse> barrier and readX/writeX operation, we've introduced mmiob()
  Jesse> on ia64, which explicity orders I/O space accesses.  Some
  Jesse> ports have chosen to take the performance hit in every
  Jesse> readX/writeX, memory barrier, and spinlock however
  Jesse> (e.g. PPC64, MIPS).

I think this is a bit of a different problem.  On non-NUMA platforms,
the performance hit of enforcing order is not huge.  Basically, as
long as the CPU issues the accesses in order, you'll be fine.

Now, with NUMA platforms, where the chipsets/switch may re-order
accesses, the performance hit will be much bigger, so the old scheme
may not be sufficient.

  Jesse> Is this a reasonable approach?  Is it acceptable to have a
  Jesse> seperate barrier operation for I/O space?  If so, perhaps
  Jesse> other archs would be willing to add mmiob() ops?

I'm no NUMA expert, but my guess is that nobody will want to go
through all the existing drivers to change them to use mmiob().  For
new drivers, it might be OK.

	--david

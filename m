Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289094AbSAGDIB>; Sun, 6 Jan 2002 22:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSAGDHv>; Sun, 6 Jan 2002 22:07:51 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:23826 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289094AbSAGDHr>; Sun, 6 Jan 2002 22:07:47 -0500
Date: Mon, 7 Jan 2002 12:05:45 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: esr@thyrsus.com, schilling@fokus.gmd.de, anderson@metrolink.com,
        hch@caldera.de, lsb-discuss@lists.linuxbase.org,
        lsb-spec@lists.linuxbase.org, linux-kernel@vger.kernel.org
Subject: Re: LSB1.1: /proc/cpuinfo
Message-Id: <20020107120545.57570c8a.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
In-Reply-To: <20020103190219.B27938@thyrsus.com>
	<Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 19:56:51 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> It's more than just a name.
> 	a) granularity.  Current "all or nothing" policy in procfs has
> a lot of obvious problems.
> 	b) tree layout policy (lack thereof, to be precise).
> 	c) horribly bad layout of many, many files.  Any file exported by

As usual, Al has hit the highpoints (five lines vs. >> 1000 msgs of proc
flamewars over time).  At risk of boring regular readers, I shall expand:

There is /proc, and /proc/sys.  /proc is a pain to use in the kernel (seq_*
made this better recently, but far from perfect), but is flexible.
/proc/sys (aka sysctl) is easier to use, but a PITA for dynamic entries.

The "manual formatting" nature of /proc entries has lead to (c) mentioned by
Al.  This can be alleviated by making the simplest method of exporting data
the correct one (ie. more like /proc/sys).

The tree layout issues are more complicated.  In particular, the following
namespaces should be equivalent:
   Boot command line: 3c509.debug=1
   Module parameter: insmod 3c509 debug=1
   proc entry: echo 1 > .../3c509/debug

Finally, I consider the granularity issue a red-herring: if it's in the
kernel, it should be in a logical location.

Now, I have a sample patch for a simple "/proc/sys" replacement which follows
the "one value per file" (similar to the current proc/sys) and
"dynamic is easy" principle (required for widespread use).  I also have
module loader rewrite and boot param unification patches.

	http://www.kernel.org/pub/linux/kernel/people/rusty

Important to realize that we will be stuck with the current interfaces for
another stable kernel version (backwards compatibility is a WIP).

Once Linus accepts general patches again I shall start pushing things to
him.

Hope that helps,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

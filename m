Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314740AbSECMHb>; Fri, 3 May 2002 08:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSECMHa>; Fri, 3 May 2002 08:07:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16651 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314740AbSECMH3>;
	Fri, 3 May 2002 08:07:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Fri, 03 May 2002 01:33:34 MST."
             <Pine.GSO.4.44.0205030131470.11340-100000@epic7.Stanford.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 22:07:14 +1000
Message-ID: <11840.1020427634@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002 01:33:34 -0700 (PDT), 
Vikram <vvikram@stanford.edu> wrote:
><snip>
>ccache is a compiler cache. It acts as a caching pre-processor to C/C++
>compilers, using the -E compiler switch and a hash to detect when a
>compilation can be satisfied from cache. This often results in a 5 to 10
>times speedup in common compilations
></snip>
>
>http://ccache.samba.org/

Firstly kbuild 2.5 removes the need to make clean or make mrproper for
most compilations.  You need to make mrproper when changing to a new
architecture in the same directory (it is much better to use a separate
object directory for each architecture), but apart from that you should
not need to make clean or mrproper.  IMNSHO having to issue make clean
is a sign that your build system is broken, relying on human
intervention in an automated build is falt out wrong.  Automatic
detection of an arch switch is on the enhancement list for kbuild 2.5.

Secondly kbuild 2.5 keeps objects that were built but are not currently
selected, it just does not link or install them.  Build a kernel,
disable a set of drivers, build the kernel and it will just bump the
version number and relink vmlinux.  Enable the drivers again, kbuild
2.5 does not need to compile them, they are still there, it just bumps
the version number and relinks vmlinux.  Same with installing modules.
Various .tmp files list the objects and modules required for the
current .config.

So kbuild 2.5 removes the need to make clean after patches, changing
configs, etc.  It gets it right without human intervention.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLUS7p>; Sat, 21 Dec 2002 13:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSLUS7p>; Sat, 21 Dec 2002 13:59:45 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:62472
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S263362AbSLUS7n>; Sat, 21 Dec 2002 13:59:43 -0500
Subject: Re: Valgrind meets UML
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: John Reiser <jreiser@BitWagon.com>
Cc: Jeff Dike <jdike@karaya.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Julian Seward <jseward@acm.org>
In-Reply-To: <3E047D6C.1030702@BitWagon.com>
References: <200212200241.VAA04202@ccure.karaya.com>
	 <3E047D6C.1030702@BitWagon.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040497668.4785.33.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 21 Dec 2002 11:07:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-21 at 06:40, John Reiser wrote:
> In order to prevent races between valgrind for UML and kernel allocators which
> valgrind does not "know", then the VALGRIND_* declarations being added to kernel
> allocators should allow for expressing the concept "atomically change state in
> both allocator and valgrind". 

Valgrind doesn't sit on the side and observe the kernel.  A better way
of viewing it is as a synthetic CPU which does a lot more error checking
than a typical CPU.  Valgrind itself is running all code, so there is no
scope for Valgrind and the kernel to get out of sync.  You can view the
VALGRIND_* declarations as being extensions to the instruction set. 

If UML were "SMP" (ie, multithreaded), then Valgrind would emulate all
the CPUs and their concurrency; at most you'd need to use the normal
synchronisation mechanisms to control the sequencing of the VALGRIND_*
directives with respect to allocators running on other CPUs/in other
threads.

On the other hand, if you view the directives that Jeff is proposing as
a more general set of directives for any tool to use to instrument the
kernel, then you might need to thinking about things in more detail.  On
the other hand, that smacks of over-design unless there's something
which can make immediate use of such hooks now (and therefore guide the
design).  

Putting the VALGRIND_* hooks (or some thin sugar wrapping) in now in the
appropriate places will mark where any further work should be done, so
should be enough for now.

	J


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSDIM7s>; Tue, 9 Apr 2002 08:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313895AbSDIM7s>; Tue, 9 Apr 2002 08:59:48 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:25789 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S312296AbSDIM7q>; Tue, 9 Apr 2002 08:59:46 -0400
Date: Tue, 9 Apr 2002 19:48:02 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: linux-kernel@vger.kernel.org
Subject: Re: C++ and the kernel (fwd)
Message-ID: <Pine.SGI.4.10.10204091947390.7043893-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Apr 2002, T. A. wrote:

>     I am in the initial stages of writing some C++ wrapper classes for the

At first, look this:
http://www.inp.nsk.su/~fedorov/export/linux-cxx-test-1.20.tar.gz

Yes, it is possible to write kernel modules in C++ and I do,
but it does not have much sense to use wrappers. Use classes only
for complex data structures, lock and so forth.

> kernel.  So far its been an interesting process, mainly due to the use of
> some C++ keywords in the kernel header files.  Mostly gratuitous at that as

There are many issues with C++ and kernel and keywords problem is
least significant and easy solved without of any kernel patching.

>     So far my overloading of "new" works if I compile the module without
> exceptions (-fno-exceptions).  This is fine for myself as I prefer checking
[...]
> object file.  Does someone know how I can resolve this?

Don't use C++ exceptions at all until you resolve all of problems
concerned with them.

> limitation in how gcc's "alias" feature is used.  Apparently for C++ one
> must pass the mangled name of the function in question.  Is there a gcc
> macro or function of some kind to do something like this:

Don't use wrapper classes and the problem is not appeared at all.
Any of C++ kernel modules must have both C and C++ sources.

> int init_module() __attribute__((alias(mangle_name("load__9my_module"))));

There are many places with sources of demangling flying around,
but mangling sources is only in one place - g++ :(
And note, that default mangling algorithm of g++ is changed
periodically. So, forget about it.

>     Another issue that I currently have is that I haven't been able to
> figure out a way to get the module to properly initiate global objects.
[...]
> Anyone know how I can get gcc to insert the global initiation
> code from within init_module?

Look at my sources, linux/cxx/xtors* and the cxx-test module's 
Makefile

>     So far C++'s use of the kernel headers has found a couple of areas in
> which possible bugs exists.  In one header file the typedef ssize_t is used
> despite its definition not appearing in the source file or any of the
> included header files.  I've also encountered negative numbers being
> assigned to unsigned numbers without a cast.

Yes, kernel code is pretty inaccurate is such relation.
I have use most strict g++ warning options to reduce probability of
some bugs in my code. Use 'STRICT=y make config' command to swith
these options on.

To prevent flooding by warnings from kernel headers, I have local
patches:
http://www.inp.nsk.su/~fedorov/export/linux-warning-cleaned-headers-1.9.tar.gz
which are not supplied to customers.

--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSLSWHF>; Thu, 19 Dec 2002 17:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbSLSWHE>; Thu, 19 Dec 2002 17:07:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13316 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267225AbSLSWG4>;
	Thu, 19 Dec 2002 17:06:56 -0500
Date: Thu, 19 Dec 2002 00:59:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218235949.GE705@elf.ucw.cz>
References: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com> <3DFF023E.6030401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFF023E.6030401@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've created a modified glibc which uses the syscall code for almost
> everything.  There are a few int $0x80 left here and there but mostly it
> is a centralized change.
> 
> The result: all works as expected.  Nice.
> 
> On my test machine your little test program performs the syscalls on
> roughly twice as fast (HT P4, pretty new).  Your numbers are perhaps for
> the P4 Xeons.  Anyway, when measuring some more involved code (I ran my
> thread benchmark) I got only about 3% performance increase.  It's doing
> a fair amount of system calls.  But again, the good news is your code
> survived even this stress test.
> 
> 
> The problem with the current solution is the instruction set of the x86.
>  In your test code you simply use call 0xfffff000 and it magically work.
>  But this is only the case because your program is linked statically.
> 
> For the libc DSO I had to play some dirty tricks.  The x86 CPU has no
> absolute call.  The variant with an immediate parameter is a relative
> jump.  Only when jumping through a register or memory location is it
> possible to jump to an absolute address.  To be clear, if I have
> 
>     call 0xfffff000
> 
> in a DSO which is loaded at address 0x80000000 the jumps ends at
> 0x7fffffff.  The problem is that the static linker doesn't know the load
> address.  We could of course have the dynamic linker fix up the
> addresses but this is plain stupid.  It would mean fixing up a lot of
> places and making of those pages covered non-sharable.

Can't you do call far __SOME_CS, 0xfffff000?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

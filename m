Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTCFFTP>; Thu, 6 Mar 2003 00:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTCFFTP>; Thu, 6 Mar 2003 00:19:15 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:64756 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267775AbTCFFTO>; Thu, 6 Mar 2003 00:19:14 -0500
Date: Thu, 6 Mar 2003 00:29:45 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030306002945.A31972@redhat.com>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030305210856.B16093@redhat.com> <3E66C5F4.5000106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E66C5F4.5000106@redhat.com>; from drepper@redhat.com on Wed, Mar 05, 2003 at 07:52:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 07:52:20PM -0800, Ulrich Drepper wrote:
> Benjamin LaHaise wrote:
> 
> > Instead, 
> > making x86-64 TLS support based off of the stack pointer, or even using 
> > a fixed per-cpu segment register such that gs:0 holds the pointer to the 
> > thread "current" would be better.
> 
> Gee, here is somebody who knows about thread APIs and ABIs.  You're
> really embarrassing yourself.

If you're saying that drawing an analagy between the kernel's concept 
of the current task pointer and thread APIs is invalid, I'm rather 
surprised.  Ulrich, comments like this are unnecessarily inflammatory 
and don't lead to a productive discussion of the merits and failings 
of specific points.

> > Make the users of threads suffer, not 
> > every single application and syscall in the system.
> 
> Whether you like it or not, people are using threads.  TLS requires a
> thread register even in single-threaded applications.  The mechanism I
> proposed would use segments if <4GB addresses can be allocated,
> otherwise fall back to prctl(ARCH_SET_FS).  This is about as good as you
> can get it.

My position is that requiring a thread register for unthreaded applications 
is unnecessary bloat.  Since the thread register is yet another register 
that must be saved and reloaded on context switch, while it provides no 
improvements in performance or functionality for single threaded programs, 
it is pure bloat.  Every single change like this that slows down unthreads 
apps goes directly onto the boot and startup time of your system and 
various applications.  Think about it!

> Remove anything and hammer is the only architecture without good thread
> support which undoubtedly makes you happy but almost nobody else.

I'm trying to help reach a point of consensus where you are failing to 
see Andi's point: using the TLS segment everywhere slows everything down 
a tiny bit.  Don't do it for unthreaded programs.  We're trying to avoid 
pessimizations while we still can for a new architecture.  I fail to see 
why you are not listening to this.  Yes, threaded apps exist, but their 
existance does not preclude the slowing down of unthreaded apps.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>

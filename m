Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbSLSWiB>; Thu, 19 Dec 2002 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLSWHK>; Thu, 19 Dec 2002 17:07:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13060 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267218AbSLSWGs>;
	Thu, 19 Dec 2002 17:06:48 -0500
Date: Thu, 19 Dec 2002 01:14:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219001441.GG705@elf.ucw.cz>
References: <3DFF7399.40708@redhat.com> <Pine.LNX.4.44.0212171106210.1095-100000@home.transmeta.com> <20021218135722.A15645@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218135722.A15645@bitwizard.nl>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > But this is exactly what I expect to happen.  If you want to implement
> > > gettimeofday() at user-level you need to modify the page.
> > 
> > Note that I really don't think we ever want to do the user-level
> > gettimeofday(). The complexity just argues against it, it's better to try
> > to make system calls be cheap enough that you really don't care.
> 
> I'd say that this should not be "fixed" from userspace, but from the
> kernel. Thus if the kernel knows that the "gettimeofday" can be made
> faster by doing it completely in userspace, then that system call
> should be "patched" by the kernel to do it faster for everybody.
> 
> Next, someone might find a faster (full-userspace) way to do some
> "reads"(*). Then it might pay to check for that specific
> filedescriptor in userspace, and only call into the kernel for the
> other filedescriptors. The idea is that the kernel knows best when
> optimizations are possible.
> 
> Thus that ONE magic address is IMHO not the right way to do it. By
> demultiplexing the stuff in userspace, you can do "sane" things with
> specific syscalls. 
> 
> So for example, the code at 0xffff80000 would be: 
> 	mov 0x00,%eax
> 	int $80
> 	ret
> 
> (in the case where sysenter & friends is not available)

This could save that one register needed for 6-args syscalls. If code
at 0xffff8000 was mov %ebp, %eax; sysenter; ret for P4, you could do
6-args syscalls this way.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

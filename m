Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbSLQU0E>; Tue, 17 Dec 2002 15:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSLQU0E>; Tue, 17 Dec 2002 15:26:04 -0500
Received: from crack.them.org ([65.125.64.184]:57557 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267145AbSLQU0C>;
	Tue, 17 Dec 2002 15:26:02 -0500
Date: Tue, 17 Dec 2002 15:35:05 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217203505.GA9668@nevyn.them.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com> <3DFF83C5.6000007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFF83C5.6000007@redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:06:29PM -0800, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> 
> > The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> > vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
> 
> This is why I'd say mkae no distinction at all.  Have the first
> nr_syscalls * 8 bytes starting at 0xfffff000 as a jump table.  We can
> transfer to a different slot for each syscall.  Each slot then could be
> a PC-relative jump to the common sysenter code or to some special code
> sequence which is also in the global page.
> 
> If we don't do this now and it seems desirable in future we wither have
> to introduce a second ABI for the vsyscall stuff (ugly!) or you'll have
> to do the demultiplexing yourself in the code starting at 0xfffff000.

But what does this do to things like PTRACE_SYSCALL?  And do we care...
I suppose not if we keep the syscall trace checks on every kernel entry
path.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

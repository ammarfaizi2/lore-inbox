Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbRETWi7>; Sun, 20 May 2001 18:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262257AbRETWis>; Sun, 20 May 2001 18:38:48 -0400
Received: from admin.csn.ul.ie ([136.201.105.1]:59655 "HELO admin.csn.ul.ie")
	by vger.kernel.org with SMTP id <S262256AbRETWie>;
	Sun, 20 May 2001 18:38:34 -0400
Date: Sun, 20 May 2001 23:38:26 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-vax@mithra.physics.montana.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [LV] start_thread question...
In-Reply-To: <20010520230747.B19847@excalibur.research.wombat.ie>
Message-ID: <Pine.LNX.4.32.0105202336330.18342-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I think I've gotten it solved most of the way, we weren't calling
execve via the system call interface, so once I made it go via the system
call and I fill out pc, sp and psl registers in start_thread, it seems to
go further..

Thanks for all the help...

Dave.

On Sun, 20 May 2001, Kenn Humborg wrote:

> On Sun, May 20, 2001 at 05:24:48PM +0100, Dave Airlie wrote:
> >
> > I'm implementing start_thread for the VAX port and am wondering does
> > start_thread have to return to load_elf_binary? I'm working on the init
> > thread and what is happening is it is returning the whole way back to the
> > execve caller .. which I know shouldn't happen.....
> >
> > so I suppose what I'm looking for is the point where the user space code
> > gets control... is it when the registers are set in the start_thread? if
> > so how does start_thread return....
> >
> > On the VAX we have to call a return from interrupt to get to user space
> > and I'm trying to figure out where this should happen...
>
> I haven't got time to look at this in detail, but you could
> probably do it by frobbing the saved registers that will be
> restored by the ret_from_syscall in entry.S.  Do you have
> a pt_regs *regs function argument at the right point?  If
> so, it should point to these saved registers.
>
> Later,
> Kenn
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person



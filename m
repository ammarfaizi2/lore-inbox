Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278101AbRJRTkV>; Thu, 18 Oct 2001 15:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278102AbRJRTkR>; Thu, 18 Oct 2001 15:40:17 -0400
Received: from quark.didntduck.org ([216.43.55.190]:23053 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S278101AbRJRTjz>; Thu, 18 Oct 2001 15:39:55 -0400
Message-ID: <3BCF2FB1.89819E48@didntduck.org>
Date: Thu, 18 Oct 2001 15:38:25 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Zealey <mark@zealos.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.x process limits (NR_TASKS)?
In-Reply-To: <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org> <3BCF27D5.CE4C53DE@didntduck.org> <20011018201321.B3187@itsolve.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Zealey wrote:
> 
> On Thu, Oct 18, 2001 at 03:04:53PM -0400, Brian Gerst wrote:
> 
> > Gregory Ade wrote:
> > >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > We're running into what appears to be a 256-process-per-user limit on one
> > > of our webservers, due to the number of processes running as a specific
> > > user for our application.  I'd like to increase the process limit, and
> > > *THINK* that to do so i need to increase NR_TASKS in
> > > /usr/src/linux/include/linux/tasks.h.
> > >
> > > Is this correct?  What other things do I need to watch out for when making
> > > this modification?
> > >
> > > Also, where can this limit be changed in 2.4.x?
> > >
> > > Thanks ahead of time.
> > >
> >
> > 2.2.x has a hard limit of 512 tasks on the x86 because it uses hardware
> > task switching.  2.4.x allows an unlimited number of tasks, and is
> > configurable via /proc/sys/kernel/threads-max and ulimit.
> 
> eh? why? The GDT can hold up to 2 ** 16 bytes (limit is 16-bit). Each entry is 8
> bytes, that means that there are 8192 possible 'slots' in the GDT. Each process
> has 2 entries, an LDT and a task struct entry. Why is the limit 512? couldn't it
> be about 4000? (Some entries are needed for APM and other things...)

Ok, maybe not so hard.  It is kept at 512 to keep the GDT from eating up
too much memory.  Increasing it will work just fine, as long as you
don't hit the GDT limit.  2.4.x uses per-cpu GDT entries instead of
per-task, allowing threads-max to be dynamically configurable.

--

				Brian Gerst

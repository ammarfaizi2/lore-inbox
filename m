Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTA1Ra0>; Tue, 28 Jan 2003 12:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTA1Ra0>; Tue, 28 Jan 2003 12:30:26 -0500
Received: from crack.them.org ([65.125.64.184]:35500 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267469AbTA1RaZ>;
	Tue, 28 Jan 2003 12:30:25 -0500
Date: Tue, 28 Jan 2003 12:39:49 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
Message-ID: <20030128173949.GA23077@nevyn.them.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com> <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk> <20030128154541.GA7269@nevyn.them.org> <1043774823.9069.59.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043774823.9069.59.camel@phantasy>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:27:03PM -0500, Robert Love wrote:
> On Tue, 2003-01-28 at 10:45, Daniel Jacobowitz wrote:
> 
> > I think this isn't an issue; multi-threaded core dumps are done by
> > the core_waiter synchronization, so all other threads will have exited
> > before the first thread to crash actually writes out its core.
> 
> I think the problem is the filenames need to not overwrite each other -
> not actual synchronization in the kernel (which, as you point out, is
> correct).
> 
> If we name the coredumps based on ->tgid, then all threads will dump to
> the same file.  If we use ->pid, each thread will use its unique PID as
> its filename.

That wasn't my point.  All of the other threads have already terminated
without dumping core at tis point; I don't think it's possible for two
threads of a CLONE_THREAD application to both dump core.  See
fs/exec.c:coredump_wait.

Also, once one thread gets into do_coredump it clears mm->dumpable;
nothing else will dump core from that MM anyway.

I think using ->tgid is a good idea.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

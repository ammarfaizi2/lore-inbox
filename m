Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264085AbTCXD6I>; Sun, 23 Mar 2003 22:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264086AbTCXD6I>; Sun, 23 Mar 2003 22:58:08 -0500
Received: from crack.them.org ([65.125.64.184]:58858 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S264085AbTCXD6H>;
	Sun, 23 Mar 2003 22:58:07 -0500
Date: Sun, 23 Mar 2003 23:09:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Rajesh Rajamani <raj@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
Message-ID: <20030324040908.GA19754@nevyn.them.org>
Mail-Followup-To: Rajesh Rajamani <raj@cs.wisc.edu>,
	linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
References: <1047936295.3e763d273307c@www-auth.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047936295.3e763d273307c@www-auth.cs.wisc.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 03:24:55PM -0600, Rajesh Rajamani wrote:
> Hi All,
> I'm working on adding a function 
> 
> void debugbreak(void);
> 
> to glibc.  I got the inspiration for this from Windows.  Windows has a
> DebugBreak() function, which when invoked from  a process, spawns a
> debugger, which then attaches to the process.  I think this would be
> invaluable to linux developers in situations where they currently have to
> put an infinite loop and attach to a running process (say, to stop in a
> library that has been LD_PRELOADed).
> 
> To this end, I've been experimenting and found out that gdb can't attach
> to a process that has been stopped.  I'd like to send a SIGSTOP as soon as
> debugbreak() is invoked, so that all threads are stopped in a state close
> to the one they were in, when the debugbreak() was invoked. 
> 
> I spoke to Vic Zandy about this and he informed me that he had submitted a patch
>  that would allow ptrace to attach to stopped processes also (the thread of
> discussion is pasted below).  I believe the patch was not accepted at that time.
>    I was wondering what the official line on this is?  If there are no serious
> objections, will the community consider accepting the patch?  It would go a long
> way in helping me accomplish my goal.

The question is, what _should_ happen when yu attach to a stopped
process?  If the tracer receives the same one SIGSTOP that it normally
would, then it will just resume the program as if it weren't stopped. 
Does that make sense or not?

As for Vic's patch, the SIGSTOP leaving processes stopped bit is
already fixed in 2.5, I believe.  We need to decide what should happen
when attaching to a stopped process before that half can be considered.

(And the patch itself is wrong; send_sig is too broad a hammer for
this, it should probably be something more like force_sig_specific; but
I'm not sure that's the right approach.  I'll think about it.)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

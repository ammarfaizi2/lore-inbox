Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbTCYNhn>; Tue, 25 Mar 2003 08:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbTCYNhn>; Tue, 25 Mar 2003 08:37:43 -0500
Received: from almesberger.net ([63.105.73.239]:61446 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262637AbTCYNhm>; Tue, 25 Mar 2003 08:37:42 -0500
Date: Tue, 25 Mar 2003 10:48:42 -0300
From: Werner Almesberger <wa@almesberger.net>
To: raj <raj@cs.wisc.edu>, linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
Message-ID: <20030325104842.A7468@almesberger.net>
References: <1047936295.3e763d273307c@www-auth.cs.wisc.edu> <20030324040908.GA19754@nevyn.them.org> <3E7EA4B2.5010306@cs.wisc.edu> <20030324150552.GA26287@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324150552.GA26287@nevyn.them.org>; from dan@debian.org on Mon, Mar 24, 2003 at 10:05:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> No, that's not what I meant.  When you attach using GDB, there is no
> way for GDB to determine if the process was previously stopped or
> running.

Likewise, there's a race condition with any other concurrent use
of SIGSTOP.

Perhaps one could introduce a PTRACE_ATTACH2 that uses "addr" to
indicate the signal that should be used to sychronize attaching.
That way, programs that use STOP/CONT for their own purposes could
be attached to with ptrace(PTRACE_ATTACH2,pid,SIGTRAP,0), or such.

If the process is already stopped, the debugger would be notified
with WSTOPSIG set to that signal instead of SIGTRAP.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbSKDQpx>; Mon, 4 Nov 2002 11:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbSKDQpx>; Mon, 4 Nov 2002 11:45:53 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:61195 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S262689AbSKDQpw>; Mon, 4 Nov 2002 11:45:52 -0500
Date: Mon, 4 Nov 2002 11:53:56 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <wirges@purdue.edu>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <87u1ixfi4m.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0211041138060.16432-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Olaf Dietsche wrote:

> Patrick Finnegan <pat@purdueriots.com> writes:
>
> > I see no one has responded to this yet, so I'll ask again.
> >
> > Does anyone have any comments about my idea outlined below?
> [... capabilities in elf executables ...]
>
> Take a look at <http://atrey.karlin.mff.cuni.cz/~pavel/elfcap.html>.
> Maybe this is what you had in mind?

Similar, but not exactly the same:

1) Capabilities should be enabled explicitly not dropped explicitly -
   it's a 'more secure' way to do it.

2) Capabilities shouldn't be preserved across an execve except for once,
   as needed by wrapper scripts/binaries. This way even if someone figures
   out how to exploit the code to do an exec, they're left with no caps at
   all.  If desired, a new binfmt "cap_wrap" could be created that can be
   used as a capabilities wrapper for executables, which the kernel looks
   at to determine 1) what caps to use and 2) what binary to run.  The
   wrapper will need to be suid root in order to gain caps still.

3) Defining a new ELF header seems to me like it could (potentially) break
   backward/forward compatibility.  My method preserves compatibility,
   with the only difference being if the app really gets capabilities or
   if it gets SUID root instead.  If this really isn't a problem, you can
   take the works 'ELF Symbol' and change them to 'ELF Header' and make
   the idea still work the same in other aspects.

4) If the app has capabilities associated with it, no userspace code is
   run as uid 0, the kernel can avoid even changing uid during the execve
   syscall.  It's just treated as a caps flag unless the kernel determines
   that the file has no capabilities, and then can run it as suid root.


Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSBOMzw>; Fri, 15 Feb 2002 07:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSBOMzo>; Fri, 15 Feb 2002 07:55:44 -0500
Received: from [66.150.46.254] ([66.150.46.254]:47928 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S288987AbSBOMzi>;
	Fri, 15 Feb 2002 07:55:38 -0500
Message-ID: <3C6D0544.FE775840@wgate.com>
Date: Fri, 15 Feb 2002 07:55:32 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com> <20020215124036.C23673@unthought.net> <3C6CF4AA.8040808@evision-ventures.com> <20020215131320.E23673@unthought.net> <3C6CFD7A.30503@evision-ventures.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Jakob Østergaard wrote:
> 
> >On Fri, Feb 15, 2002 at 12:44:42PM +0100, Martin Dalecki wrote:
> >
> >>Jakob Østergaard wrote:
> >>
> >...
> >
> >>>What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
> >>>flexible scheme like your patch implements is very nice.   Actually having
> >>>the core files in CWD is fine for me - I mainly care about the file name.
> >>>
> >>Please execute the size command on the core fiel:
> >>
> >>size core
> >>
> >>to see why this isn't needed.
> >>
> >
> >Huh ?
> >
> >I suppose you mean, that I can get the name of the executable that caused the
> >core dump, when running size - right ?
> >
> >Well, you can do that easier with the file command.
> >
> >But that doesn't prevent my 7 other processes from overwriting the core file
> >of the 8'th process which was the first one to crash.   Multi-process systems
> >can, on occation, produce such "domino dumps".   Separate names is a *must have*.
> >
> This point I fully agree with. And in fact 2.4.17 already does it the
> core.{pid} way.

This is still not a very good way to control the names.

What I have is a cluster of nearly 100 machines - all but one of them have
no disk.  When something goes down on one of the machines, I would like to
know (a) what it was that went down and (b) which machine it was on.
I would also like to have the core files someplace that is writable (all
but the /coredumps directory is read-only - oh, and the local tmpfs mounts
for /var and /etc)

> >And having process names is nicer than having PIDs - I don't mind if my core
> >files are over-written on subsequent runs, actually it's nice (keeps the disks
> >from filling up).
>
> They can get long and annoying... They are not suitable for short name
> filesystems... They provide a good
> hint for deliberate overwrites.... and so on. Basically I think this
> would be too much of the good.

I was very carefull to keep that behavior consistant with 2.4.17.  That
is, if you do nothing different with the kernel.core_name_format then it
will work just as before.  And only root can change that sysctl.

As to "overwrites" and the like, I have much less overwrites with most
any pattern form than with just plain "core"  And I can support features
that many people have wanted (%N.core being a very popular construct).

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.

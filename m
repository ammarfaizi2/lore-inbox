Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRKRU6F>; Sun, 18 Nov 2001 15:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280095AbRKRU5z>; Sun, 18 Nov 2001 15:57:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45155 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280084AbRKRU5q>; Sun, 18 Nov 2001 15:57:46 -0500
To: "Marcelo Roberto Jimenez" <mroberto@cetuc.puc-rio.br>
Cc: linux-kernel@vger.kernel.org, myrjola@lut.fi
Subject: Re: /proc/<pidnumber>/stat hangs reading process
In-Reply-To: <1353.139.82.28.36.1005665947.squirrel@mamona.cetuc.puc-rio.br>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Nov 2001 13:38:41 -0700
In-Reply-To: <1353.139.82.28.36.1005665947.squirrel@mamona.cetuc.puc-rio.br>
Message-ID: <m1elmv95m6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcelo Roberto Jimenez" <mroberto@cetuc.puc-rio.br> writes:

> Mika,
> 
> > Hello,
> > basically this posting is about the same problem as one I posted in 
> > September:
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.0/0764.html
> > 
> > It's essentially the same situation: I was running mozilla and it stopped
> > responding to any input. I tried to kill it with control-c, kill and
> > finally with kill -9, but none helped. When I tried to look at the output
> > of top and ps, the exactly same symptons appeared; those processes didn't
> > finish and can't be killed either. When I do strace ps the output ends 
> > at:
> > 
> > stat64("/proc/16515", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> > open("/proc/16515/stat", O_RDONLY)      = 7
> > read(7,
> 
> I'm having this problem too, for a long time. It's usually associated with big
> loads ( for my machine, of course, a PII-233 ). It has happened while opening
> lot's of pages with opera, but has also happened while compiling 3 kernels at
> the same time and playing a video with xine or aviplay.
> 
> 
> The behavior is the same: ps blocks, gtop blocks, killall blocks, anything that
> tries to get the process information blocks too.
> 
> 
> The machine can be used as long as a program does not try to call the
> problematic function, whitch I wasn't able to trace down.
> 
> 
> I haven't had this problem for a while, basically because I try not to stress
> these ``hanging'' applications anymore, so that I can work, but I'll try to see
> if I can reproduce the bug with the new VM.
> 
> 
> The problem is: what can we do, to investigate the problem, once ps starts to
> block?

Try using Alt-Sysrq and find the address in the kernel where the processes
are blocking.  The you should be able to trace back and figure out which
lock things are blocking on.

I have only seen this once on buggy hardware.  (At least on a recent kernel).
Earlier kernels had a case where they contended with process that in
certain circumstances had locks normally held.  And the ps never managed
to grab the lock.

Additionally there are a few other pieces like spin lock debugging in 2.4.14
that you might want to compile in as well.

Eric

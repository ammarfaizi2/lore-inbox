Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbRG2NZY>; Sun, 29 Jul 2001 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267983AbRG2NZO>; Sun, 29 Jul 2001 09:25:14 -0400
Received: from fandango.cs.unitn.it ([193.205.199.228]:4356 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S267976AbRG2NZA>; Sun, 29 Jul 2001 09:25:00 -0400
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200107290748.f6T7mKj7009629@dizzy.dz.net>
Subject: Re: strange problem with reiserfs and /proc fs
In-Reply-To: <20010729171209.D13366@eye-net.com.au> "from Craig Small at Jul
 29, 2001 05:12:09 pm"
To: Craig Small <csmall@eye-net.com.au>
Date: Sun, 29 Jul 2001 09:48:20 +0200 (MEST)
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Sat, Jul 28, 2001 at 10:04:05PM +0200, Massimo Dal Zotto wrote:
> > I've found a strange problem with reiserfs. In some situations it interferes
> > with the /proc filesystem and makes all processes unreadable to top. After
> > a few seconds the situation returns normal. To verify the problem try the
> > following procedure:
> Have to be one of the strangest bugs I've seen.  Makes be a bit lucky
> that reiser will oops on my machine so I cannot use it...
> I have also passed this bug onto the procps author, who may be able to
> shed a bit more light on the problem.
> 
> > 3)	type a few characters and save the file with C-x C-s. After the
> > 	file is saved top will show 0 processes. Sometimes it will show
> > 	only a few processes for an istant and then nothing. Sometimes
> > 	it will work fine. After a few seconds the missing processes
> > 	will show again. Modifying and saving the file again will show
> > 	the same behavior.
> When you say top prints nothing do you mean it only prints the header
> and no processes in the list?  Does this problem happen with any other
> program, say vi, or only in emacs?  Does ps have this bevhavour?

It prints the header with 0 processes and 100% idle:

 09:40:24 up 24 min, 10 users,  load average: 0.16, 0.26, 0.34
0 processes: 0 sleeping, 0 running, 0 zombie, 0 stopped
CPU states:   0.0% user,   0.0% system,   0.0% nice,  100.0% idle
Mem:    126332K total,   121072K used,     5260K free,    38592K buffers
Swap:   257032K total,    73508K used,   183524K free,    24860K cached

I have been able to reproduce the bug only with emacs. Another thing I have
discovered is that if there is an intense disk activity (for example a find)
the problem disappears, so the fact that it disappears by itself after a
few seconds is probably caused by some other process accessing the disk.
Also ps shows the same behavior:

$ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
$

> 
> > In the attachments you will find two traces of the running top, one behaving
> > normally and one exhibiting the problem, and my kernel config.
> The interesting difference is that the good program does
> stat64,open,read,close...
> But the bad program does is just stat64.
> I get 96 stat64s for both programs in that loop.
> 
> So obviously top doesn't like whatever stat64 is telling it.
> Looking at the code (in readproc() in proc/readproc.c if anyone is
> interested) I cannot see much that should upset it.  We know stat is
> returning 0 so that is ok, about the only other thing is a alloc.
> 
> If you like, you can submit this as a bug report into the Debian Bug
> Tracking System, but I suspect there is a kernel problem here giving
> wierd stat returns for proc.

I haven't submitted a bug because I'am not sure it is a procps problem.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@cs.unitn.it               |
|  Via Marconi, 141                phone: ++39-0461534251              |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                             pgp: see my www home page         |
+----------------------------------------------------------------------+

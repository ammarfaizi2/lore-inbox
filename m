Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSEERsr>; Sun, 5 May 2002 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSEERsq>; Sun, 5 May 2002 13:48:46 -0400
Received: from gear.torque.net ([204.138.244.1]:31498 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S313238AbSEERsp>;
	Sun, 5 May 2002 13:48:45 -0400
Message-ID: <3CD56FA0.FBCBD69B@torque.net>
Date: Sun, 05 May 2002 13:45:04 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Botz <jurgen@botz.org>, linux-kernel@vger.kernel.org
Subject: Re: Reproducible SMP kernel deadlock in SCSI generic driver (sg)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Botz <jurgen@botz.org>
> The sg module reproducibly deadlocks the kernel for me after some time
> of heavy I/O on an SMP system.  This appears to be true in /all/ kernel
> versions... I can reproduce it very reliably now in 2.4.19-pre8 and
> 2.5.13, and I've had problems with CD ripping on my SMP workstation at
> least throughout the 2.4 series (I just never fully investigated before).
> The bug is almost certainly in sg.c; here is what I've narrowed down...

Jurgen,
Which version of cdparanoia (or whatever) are you using?
You mention deadlock, is the machine completely locked
up or is sg and the device inoperable? Since sg doesn't
take any "big" locks (e.g. io_request_lock) then it
shouldn't be able to lock up your machine without help
(from other drivers).

Assuming you can still execute commands on your box after the
"deadlock", I'm interested in WCHAN from ps. Here are some
ps variants:
  ps -eo cmd,wchan
  ps -eo fname,tty,pid,stat,pcpu,wchan
  ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args
The line for cdparanoia would be useful.

BTW ps needs to find the correct System.map for
the WCHAN output to be relevant.

Doug Gilbert

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129502AbRBXSMD>; Sat, 24 Feb 2001 13:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129513AbRBXSLy>; Sat, 24 Feb 2001 13:11:54 -0500
Received: from web1301.mail.yahoo.com ([128.11.23.151]:51984 "HELO
	web1301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129502AbRBXSLh>; Sat, 24 Feb 2001 13:11:37 -0500
Message-ID: <20010224181136.18532.qmail@web1301.mail.yahoo.com>
Date: Sat, 24 Feb 2001 10:11:36 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: Re: 242-ac3 loop bug
To: Doug McNaught <doug@wireboard.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m34rxk0xnz.fsf@belphigor.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Doug McNaught <doug@wireboard.com> wrote:
> Mark Swanson <swansma@yahoo.com> writes:
> 
> > > ps -aux | grep loop
> > 1674 tty1     DW<   0:00 [loop0]
> > 
> > The system is doing nothing to the loop filesystem.
> > Strange that the process isn't logging any cpu usage time. It's
> > definately responsible for the 1.00 load.
> 
> It's just an artifact of the fact that processes in state D
> (uninterruptible sleep) are included in the load average calculation.
> Since the loop thread apparently sits in state D waiting for events
> on its device, you get a load average of 1 for each mounted loop
> device. 

My thought was that the calculation seems to be misleading. The loop
process isn't taking up any CPU time. My applications are running
faster than ever. I'm guessing that ps (and /proc/loadavg) need to make
the distinction between:
1. uninterruptable sleep - where the process is blocking but taking
0CPU
2. uninterruptable sleep - I/O is happening using CPU

But I may not understand what uninterruptable sleep is supposed to
mean.

Take sendmail for example. Its default configuration for Linux won't
send attachments if the machine's load is too high. If I have 8 loop
devices in use and the load is at least 8, this may affect how sendmail
operates.



__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/

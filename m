Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131416AbQKJUfz>; Fri, 10 Nov 2000 15:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131660AbQKJUfr>; Fri, 10 Nov 2000 15:35:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:27406 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131416AbQKJUf3>; Fri, 10 Nov 2000 15:35:29 -0500
Message-ID: <3A0C5B1A.DABAAC00@timpanogas.org>
Date: Fri, 10 Nov 2000 13:31:22 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.3.95.1001110150021.5941A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andre,

SSH is running on this system, so send me your IP address to add to the
hosts.allow file and I'll send you an account so you can get into the
box and see just what's happening with ssh.  Andre Hedrick has root
privileges on this machine, so if I'm ever not around, he can get into
it.  I am running 2.2.18pre19 on i right now, and was going to upgrade
to 2.2.18-pre20 this evening, but let's look into this first since Alan
may have another patch to post ....
8)

Jeff



"Richard B. Johnson" wrote:
> 
> On Fri, 10 Nov 2000, Andrea Arcangeli wrote:
> 
> > On Fri, Nov 10, 2000 at 12:34:40PM -0700, Jeff V. Merkey wrote:
> > >
> > > Andrea,
> > >
> > > All done.  It's already setup this way.
> >
> > Ok. So please now show a tcpdump trace during the `sendmail -q` so we can see
> > what's going wrong in the TCP connection to the smtp server:
> >
> >       tcpdump port smtp
> >
> > Andrea
> 
> I tried to send Jeff a 45 Megabyte file. It is still in the queue.
> 
>  FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
> [SNIPPED...]
> 
>    140     0    82     1   9   0    840   100 do_select   S   ?
>    0:00 /usr/sbin/rpc.pcnfsd /var/spool/lpd
>    140     0    86     1   8   0   1744   364 do_select   S   ?
>    0:00 sendmail: accepting connections
>     40     0  5742     1  16   0   1812   136 wait_for_tc S   ?   0:01
> sendmail: ./eAAJm8V05731 vger.timpanogas.org.: client DATA 354
> 
> It isn't a TCP/IP stack problem. It may be a memory problem. Every time
> sendmail spawns a child to send the file data, it crashes.  That's
> why the file never gets sent!
> 
> This is how /proc/meminfo looks right after it crashes. There has
> been a lot of swapping going on.
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  328114176 38932480 289181696        0  2293760 27115520
> Swap: 139821056 10014720 129806336
> MemTotal:       320424 kB
> MemFree:        282404 kB
> MemShared:           0 kB
> Buffers:          2240 kB
> Cached:          26484 kB
> Active:           5576 kB
> Inact_dirty:     18348 kB
> Inact_clean:      4800 kB
> Inact_target:      332 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       320424 kB
> LowFree:        282400 kB
> SwapTotal:      136544 kB
> SwapFree:       126764 kB
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

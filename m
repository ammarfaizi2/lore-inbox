Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRJPNVP>; Tue, 16 Oct 2001 09:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276150AbRJPNVF>; Tue, 16 Oct 2001 09:21:05 -0400
Received: from ns.ithnet.com ([217.64.64.10]:31749 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276138AbRJPNUz>;
	Tue, 16 Oct 2001 09:20:55 -0400
Date: Tue, 16 Oct 2001 15:21:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre3aa1
Message-Id: <20011016152126.01d58180.skraw@ithnet.com>
In-Reply-To: <E15tTMq-0000E6-00@Princess>
In-Reply-To: <20011016110708.D2380@athlon.random>
	<E15tTMq-0000E6-00@Princess>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001 14:30:43 +0200 Allan Sandfeld <linux@sneulv.dk> wrote:

> I was expecting a more serious bug-fix. I recently upgraded my kernel from 
> 2.4.11pre1 to 2.4.13-pre2aa1. Now anacron "kill"s the machine every morning 
> by starting updatedb. Basicly everything swaps out. If I don't touch the 
> mouse for 3 seconds, it will take 15 seconds to respond next time I touch it.

> Switching between desktops in KDE, takes from 3 to 10 minutes, and updatedb 
> never seems to complete, I have had to kill it manually every time so far. I 
> had similar problems every morning with 2.4.9 although not as bad, but I 
> havent seen them before in 2.4.10 and later.
> The problem is easily replicable, I just need to run updatedb. Would you like

> some statistics and which?

That would be really interesting. If you want to have a look:

admin:/etc # cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  922664960 882900992 39763968        0 104587264 214876160
Swap: 271392768        0 271392768
MemTotal:       901040 kB
MemFree:         38832 kB
MemShared:           0 kB
Buffers:        102136 kB
Cached:         209840 kB
SwapCached:          0 kB
Active:          40252 kB
Inactive:       271724 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       901040 kB
LowFree:         38832 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3              6297280   5941616    355664  95% /
/dev/sda2                31111     25873      3632  88% /boot
/dev/hda1             20043416  19405616    637800  97% /p3
/dev/sda4             29245432  27529888   1715544  95% /p2
shmfs                   450520         0    450520   0% /dev/shm

admin:/ # time updatedb --localpaths="/ /p2 /p3"

real    0m19.197s
user    0m15.440s
sys     0m5.260s

admin:/etc # ls -l /var/lib/locatedb 
-rw-r--r--    1 root     root      5321293 Oct 16 15:13 /var/lib/locatedb

admin:/etc # uname -r
2.4.13-pre2

  3:14pm  up 2 days, 18:15, 24 users,  load average: 1.16, 1.10, 1.04
119 processes: 117 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states: 54.5% user,  2.4% system, 53.0% nice, 42.4% idle
CPU1 states: 45.0% user,  1.1% system, 45.1% nice, 53.1% idle
Mem:   901040K av,  847480K used,   53560K free,       0K shrd,   90544K buff
Swap:  265032K av,       0K used,  265032K free                  206296K cached

On my system I cannot see anything the like. Look at the execution time.
Ok, I must admit: I do not use brain-dead K stuff (warning: this is a very
personal opinion, don't flame me here :-).

What does your setup look like? Have you ever tested without K?

Regards,
Stephan


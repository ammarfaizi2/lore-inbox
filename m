Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTKFXCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTKFXCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:02:45 -0500
Received: from [203.97.82.178] ([203.97.82.178]:4315 "EHLO treshna.com")
	by vger.kernel.org with ESMTP id S263868AbTKFXCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:02:40 -0500
Message-ID: <3FAAD30D.6000001@treshna.com>
Date: Fri, 07 Nov 2003 12:02:37 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en-nz
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Preemptible kernel makes mpg123 skip a lot under 2.6.0-testing7
 and very high load average under low usage.
References: <200310152344.29920.kernel@kolivas.org>
In-Reply-To: <200310152344.29920.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>Hi.
>
>I quote from your output:
>
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>22953 andru     15   0 10100 5316 9464 S  3.7  0.6   2:02.39 mpg123
> 1067 root       5 -10  595m  58m 539m S  3.3  6.6 391:41.29 XFree86
> 1176 andru     15   0 47488  26m  13m S  1.0  3.0  11:52.32 gnome-terminal
>25063 root      17   0  2004 1096 1792 R  0.7  0.1   0:00.03 top
>
>The kernel is now tuned to give much more priority to reniced tasks and it is 
>not recommended to run your X server nice -10. This is the cause of your 
>problem as X is starving your audio application. Some distributions do this 
>by default to get around the limitations of the old cpu scheduler not being 
>able to make X smooth enough at nice 0. This hack/workaround is no longer 
>recommended for 2.6 kernels. You will find nice performance of X at nice 0 
>now and audio will not skip when the nice value of X is the same as your 
>audio application.
>
>Con
>  
>

Hello all. i've still been testing the schedular for test7. Sorry havn't 
tried out testing9 yet, me and
the computer have been having some emotional differences recently.  Plus 
rebooting is a long processes
breaks my ps/2 mouse support (USB mouse fine) and sometimes my modelM 
keyboard. 

If i run 10 low cpu intensive processess at once (that reguarlly require 
wakeup many times a second,
but chew less than 1% of the cpu) they will starve other processors a 
lot.  I get mouse jerkness
when the system is running many processes with 80% cpu usuage or 
higher.  Though the major
problem is with mplayer, and mpg123.  Renicing seems to have little 
effect on the schedular.
I could renice mpg123 to -19, start up 10 processors that run in the 
background that operate at nice
of 10 and I will still have sound skip (not as much as not nicing 
processes at all).
mpg123 doesn't do buffering ahead as xmms does.

I will say this, the stablity of 2.6.0-testing is very good in regard to 
uptime.  I'm finding it better than
2.4 in some respect. 





top - 11:50:58 up 4 days, 17:31, 44 users,  load average: 1.27, 1.43, 1.52
Tasks: 197 total,   1 running, 196 sleeping,   0 stopped,   0 zombie
Cpu(s): 23.8% us,  3.3% sy,  1.3% ni, 22.8% id, 45.0% wa,  0.0% hi,  3.6% si
Mem:    904792k total,   899952k used,     4840k free,     1080k buffers
Swap:  1914656k total,   253764k used,  1660892k free,   492360k cached
                                                                                

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
10327 root      15   0  651m  62m 538m S 18.6  7.1 408:38.62 XFree86
31958 andru      0 -19  9412 3732 9048 S  3.3  0.4   0:58.05 mpg123
10404 andru     15   0 46952  23m  15m S  2.3  2.7  19:40.27 gnome-terminal
  322 root      15   0     0    0    0 S  0.7  0.0   5:10.32 rpciod
16268 andru     25  10 18492 7084 4736 S  0.7  0.8   6:11.64 btdownloadcurse
16584 andru     25  10 33172 5928 4736 S  0.7  0.7   3:02.38 btdownloadcurse
32274 root      17   0  2212 1096 1868 R  0.7  0.1   0:00.03 top
10384 andru     15   0 11312 5668 9844 S  0.3  0.6   1:37.27 metacity
28693 andru     26  10 18320 7468 4736 S  0.3  0.8   8:16.47 btdownloadcurse
16145 andru     15   0 18628 7060 4736 D  0.3  0.8   3:11.18 btdownloadcurse
16334 andru     30  15 18452 6984 4736 S  0.3  0.8   4:29.09 btdownloadcurse
16420 andru     15   0 26056 7344 4736 S  0.3  0.8   3:41.03 btdownloadcurse
32093 root      15   0  3184 1604 2936 S  0.3  0.2   0:04.48 http




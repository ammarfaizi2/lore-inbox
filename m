Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbTCZDyY>; Tue, 25 Mar 2003 22:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263225AbTCZDyY>; Tue, 25 Mar 2003 22:54:24 -0500
Received: from [209.104.139.7] ([209.104.139.7]:51602 "EHLO
	mail.baldwinlib.org") by vger.kernel.org with ESMTP
	id <S261307AbTCZDyV>; Tue, 25 Mar 2003 22:54:21 -0500
Message-ID: <4835.68.40.176.184.1048651532.squirrel@mail.baldwinmail.org>
Date: Tue, 25 Mar 2003 23:05:32 -0500 (EST)
Subject: Re: 2.5.65: *huge* interactivity problems
From: "George Glover" <zed@baldwinmail.org>
To: <mingo@elte.hu>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: zed@baldwinmail.org
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tried 2.5.66, and have the same trouble with interactivity issues.

Pre-empt kernel, crusoe tm5800 processor, 256MB of ram.

"setiathome -verbose" running at it's default priority (1) in an xterm
still seems to trigger it.  Applications that were already running seem
to stay interactive.  New processes seem to hang, I had ls in an xterm
hang half way through a listing, after a bit of time and moving windows
around (my theory being to send expose events to wake up other apps
might help unhang) the system responds again.  Other applications
such as rox filer, xv, mplayer, gimp, have all hung during load or just
after.  Mplayer showed a few frames of video and stopped, once restarted
though it plays fine.  The same goes for the other applications, after
being loaded once they tend to work the second time.

Killing seti brings everything back to normal, instantly.

Here is a top listing during a hang:
Tasks:  50 total,   3 running,  46 sleeping,   0 stopped,   1 zombie top
- 22:16:18 up 16 min,  6 users,  load average: 2.13, 1.74, 1.08 Tasks:
47 total,   4 running,  42 sleeping,   0 stopped,   1 zombie Cpu(s):
1.0% user,   1.3% system,  97.7% nice,   0.0% idle,   0.0% IO-wait Mem:
  240208k total,   131052k used,   109156k free,     4624k buffers Swap:
  257032k total,        0k used,   257032k free,    75092k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
173 zed       17   1 15904  14m  352 R 98.3  6.0  11:06.11 setiathome
230 zed       15   0  1856  984 1740 R  0.7  0.4   0:00.38 top
116 root      15   0 21620  15m 7944 S  0.3  6.6   0:51.21 X
157 zed       15   0  4072 2292 2860 S  0.3  1.0   0:14.39 ssh
161 root      15   0  4756 2448 4468 S  0.3  1.0   0:00.80 xterm
  1 root      15   0   480  232  456 S  0.0  0.1   0:05.10 init
  2 root      34  19     0    0    0 R  0.0  0.0   0:00.01 ksoftirqd/0
  3 root       5 -10     0    0    0 S  0.0  0.0   0:00.08 events/0
  4 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kapmd
  5 root      25   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
  6 root      15   0     0    0    0 S  0.0  0.0   0:00.06 pdflush
  7 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0


Here is a vmstat 1 listing:

(mplayer was launched but not appearing)

3  0    0  99640   4712  83300    0    0     0     0 1060    76 96  4 0  0
3  0    0  99952   4712  83300    0    0     0     0 1001    17 99  1 0  0
3  0    0  99120   4712  83300    0    0     0     0 1063    70 97  3 0  0
3  0    0 100004   4712  83300    0    0     0     0 1001    10 100 0 0  0
5  0    0  99016   4712  83300    0    0     0     0 1082    107 97 3 0  0
3  0    0  99900   4712  83300    0    0     0     0 1253    411 96 4 0  0
3  0    0  99008   4712  83300    0    0     0     0 1139    195 96 4 0  0
3  0    0  99892   4712  83300    0    0     0     0 1008    63 100 0 0  0

(killed seti and mplayer shows itself)

0  0    0 111236   4716  83552    0    0   140     0 1043   523 48  7 9  36
1  0    0 111080   4716  83680    0    0   128     0 1273  1302 28  6 66  0
1  0    0 111088   4716  83680    0    0     0     0 1151  1044 27  5 68  0
0  0    0 110984   4716  83808    0    0   128     0 1127  1113 25  3 72  0

Hope this helps,

George


> Can you please test 2.5.66?   Some things were fixed.
>
> Thanks.
>
> "George Glover" <zed@baldwinmail.org> wrote:
>>
>> I also have a similar problem, when running setiathome with priority
>> 1.
>>
>> All _running_ applications remain interactive, anything requring disk
>> access, in particular starting a new program, causes things to block.
>>
>> I've so far only been in X when this happens, mouse still moves,
>> remote applications update their windows fine, no lost keystrokes,
>> it's when I run something locally requiring disk IO.
>>
>> Renicing setiathome to -19 causes the problem to vanish.
>>
>> Dragging an xterm around seems to help it recover from a hang too.
>>
>> > - How much memory does the machine have?
>>
>> 256
>>
>> > - UP/SMP/preempt?
>>
>> preempt
>>
>> > - Did it happen in 2.5.64?  2.5.63?  2.4.20?
>>
>> 2.5.64
>>
>> > - Does it get better if you renice stuff?
>>
>> Yes
>>
>> > - What steps should others take to reproduce it?
>>
>> Running setiathome with priority one seems to do it for me.
>>
>> George




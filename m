Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264911AbSJ3Uvs>; Wed, 30 Oct 2002 15:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbSJ3Uvr>; Wed, 30 Oct 2002 15:51:47 -0500
Received: from coxeter.math.toronto.edu ([128.100.68.3]:35264 "EHLO
	coxeter.math.toronto.edu") by vger.kernel.org with ESMTP
	id <S264911AbSJ3Uvp>; Wed, 30 Oct 2002 15:51:45 -0500
Date: Wed, 30 Oct 2002 15:58:03 -0500
From: marco <marco@math.toronto.edu>
To: linux-kernel@vger.kernel.org
Subject: Crazy idle values with 2.4.18-17.7.x
Message-ID: <20021030155803.F189806@math.utoronto.ca>
Reply-To: marco@reimeika.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Apologies in advance if Red Hat kernels should not be discussed
here (pointers are appreciated).

I've recently upgraded to kernel-2.4.18-17.7.x.athlon.rpm (from
kernel-2.4.18-10.athlon.rpm) and I've noticed a problem with the
CPU idle %. Here is an example of what happens when running
"top":



 10:37am  up 8 days, 22:02,  9 users,  load average: 1.00, 1.01, 1.00
89 processes: 81 sleeping, 7 running, 1 zombie, 0 stopped
CPU states:  0.1% user,  0.1% system, 99.8% nice, 857278.7% idle
Mem:   514156K av,  485724K used,   28432K free,  0K shrd,   57956K buff
Swap:  522072K av,   44048K used,  478024K free             288448K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
18840 mersenne  39  19 14996  14M   696 R N  99.9  2.9  7046m mprime
14091 marco     15   0  1084 1084   848 R     0.1  0.2   0:00 top
    1 root      15   0   472  444   420 S     0.0  0.0   0:04 init
    2 root      15   0     0    0     0 SW    0.0  0.0   0:01 keventd
    3 root      15   0     0    0     0 SW    0.0  0.0   0:00 kapmd



As you can see the idle value is absurd (it blows up about 1 in five
times, other updates are reasonable e.g. 0.2% idle). When running "top"
the value consistently jumps to about 800000% about 20% of the time.
If I run "top -d1" so that the updates take place every second the
value consistently jumps to about 4200000%, again about 20% of the time.
Running "top -d2" makes it jump to around 2000000%. The idle value
behaves approximately as follows:

        4200000
idle = --------% once every five updates.
       interval

If I stop "mprime" so that the system load becomes negligible the
idle value does not spike. If I run "mprime" or any other CPU-consuming
task (e.g. yes > dev/null) the spikes commence. The niceness of
the process does not seem to matter.

My hardware is an Athlon 2100+ running on an ASUS A7V333.

> uname -a
Linux reimeika.math.toronto.edu 2.4.18-17.7.x #1
Tue Oct 8 11:49:30 EDT 2002 i686 unknown

> top --version
top (procps version 2.0.7)

I should note that all previous Red Hat 7.3 kernels ran fine.
It's telling that according to the 2.4.18-17.7.x errata at:

http://rhn.redhat.com/errata/RHSA-2002-206.html

it's mentioned that the following bug:

/proc/uptime shows wrong uptime (slightly) and idle time (totally)
( http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=75113 )

has been fixed.

Kernel bug? "top" bug? Something else? Suggestions appreciated.

Please CC responses to my "Reply-To:" if possible.

Cheers,

--
marco@reimeika.ca
Gunnm: Broken Angel
http://reimeika.ca/

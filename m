Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRF2V4t>; Fri, 29 Jun 2001 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262436AbRF2V4j>; Fri, 29 Jun 2001 17:56:39 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:4094 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262058AbRF2V41>; Fri, 29 Jun 2001 17:56:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Jun 2001 13:35:27 -0700 (PDT)
Subject: creeping system useage in 2.4.5
Message-ID: <Pine.LNX.4.33.0106291317540.21698-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the machines:
I have a firewall running 2.4.5 (stock, no patches)
the boxes are:
1.2GHz athlon 512MB pc133 ram 20G 7200RPM ata100 drive D-link quad nic

2G swap space (swap is never used)
Slackware-current (as of June 1)
syslog set to log in async mode, logs rotated every hour

running FWTK plug-gw proxy
 This proxy is horribly inefficiant, it forks off a new process for each
incoming connection. this box is fast enough to handle this inefficiancy.
also runnning heartbeat (heartbeat running over eth0 and eth1)

the problem: when freshly booted the machine CPU load is ~5-15% system,
3-5% user loadave <1. as it continues to run the system time keeps
climbing, after a day or so it's not unusual for the system time to be up
~40% with the user time still at 3-5% and loadave ~2-3, after a couple
days the system time hits ~95% with the user time at 5% and the loadave
~12. at this point things start to seriously slow down. switching to the
backup box (which then carries the same load) resets teh numbers back to
the fresh system numbers even as it continues to handle the same traffic.

the box normally has ~600-700 processes listed in a ps, after a fresh boot
during a slow afternoon it gets up to ~350 processes within a couple min
and ramps up to ~600 over the next couple hours (at which time the CPU
times and the loadave are still nice and low) and remains fairly steady at
this point until the machine fails (climbing to ~700 processes at peak
load times and then dropping back to ~600 as the load drops off).

Bandwidth of network traffic is low, ifconfig shows essentially no errors
(<30 out of millions of packets)

I had to bump the max filehandles up from the default 8K (I went all the
way to 64K as it would run into a problem running out of them, after
raising the limit the box will fail with the high-water mark of ~13000 and
current of ~9000 (cat /proc/sys/fs/file-nr)

I have used the plug-gw before on a 2.2 system (and a 2.4.0pre system) and
with the process count ranging from ~1500 (idle) and ~5000 (loaded) this
problem did not appear so I seriously doubt that it's a bug in this proxy.

any ideas as to what could be accumulating to slowly tie up the cpu in
system mode?

David Lang

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131008AbRCFQ3H>; Tue, 6 Mar 2001 11:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbRCFQ24>; Tue, 6 Mar 2001 11:28:56 -0500
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:18921 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S130988AbRCFQ2v>; Tue, 6 Mar 2001 11:28:51 -0500
From: Jorge David Ortiz Fuentes <jorge_ortiz@hp.com>
Date: Tue, 6 Mar 2001 17:28:43 +0100
To: linux-kernel@vger.kernel.org
Subject: Process vs. Threads
Message-ID: <20010306172843.D1283@hpspss3g.spain.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody:

  I have been trying to differenciate threads and process in Linux. As
I am sure you already know, other OS, namely HPUX, implement threads
in a different way.  There is a thread id (TID) field in the structure
that is used by the scheduler and it is used to identify uniquely each
"task" that can be run.  Using this structure makes easier to identify
which threads belong to the same process and tools such as ps or top
show the TID as a field.

  I understand that changing this in the Linux kernel would mean that:
* some tools will have to be modified.
* the proc filesystem should create a directory using the TID instead
of the PID.
* some features as VM handling, signaling or exec()ing from a thread
would be more difficult to implement.
* compatibility will be broken.

  However, I miss some way to indicate that two processes are, in
fact, threads of the same process.  Maybe there is something I'm
missing.  Let me elaborate this.

  If you run 'top' (sorted by memory usage) and, lets say, you have 9
threads, you see the SIZE of these 4 threads 

 10:40am  up  1:23,  1 user,  load average: 0.26, 0.22, 0.10
52 processes: 51 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:  0.0% user,  3.1% system,  0.0% nice, 96.8% idle
Mem:   322464K av,  306284K used,   16180K free,   16876K shrd,   32432K
buff
Swap:  530136K av,    8064K used,  522072K free                   13660K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
  745 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  840 root      15   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  841 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:13
traffic_mana
  846 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  848 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  850 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  855 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  856 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana
  857 root       0   0  224M 217M  1596 S       0  0.0 68.9   0:00
traffic_mana

  This information is missleading since there is no way to know that
these 9 threads are sharing memory. If you run 'ps axl' you can see
the hierarchy as if it was a multiprocess program, i.e. no difference
to show you that they are threads.  Not even reading
/proc/<pid>/status you get info about these being threads.

  Of course, I am talking about kernel 2.2.x, but AFAIK this has not
changed in the new kernels.

  Would it make sense to include this as an entry of the /proc/<pid>?

  Thanks for reading,

    Jorge


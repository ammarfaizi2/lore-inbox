Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264463AbRFOVXh>; Fri, 15 Jun 2001 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264510AbRFOVX1>; Fri, 15 Jun 2001 17:23:27 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:48399 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id <S264252AbRFOVXW>; Fri, 15 Jun 2001 17:23:22 -0400
Date: Fri, 15 Jun 2001 17:23:16 -0400 (EDT)
From: Paul Faure <paul@engsoc.org>
X-X-Sender: <paul@stout.engsoc.carleton.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.0.35 limits
In-Reply-To: <20010615165204.C30332@sventech.com>
Message-ID: <Pine.LNX.4.33.0106151702300.22155-100000@stout.engsoc.carleton.ca>
X-Home-Page: http://www.engsoc.org/
X-URL: http://www.engsoc.org/
Organisation: Engsoc Project (www.engsoc.org)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just this morning, our firewall get a kernel panic after 500 days of
uptime.

As you can see from the log files, the date starts at June 15th, where we
get two div by zeros, then jumps May 11th, then a kernel panic. A reboot
brings it back to June 15th. Since cron could not open /dev/rtc. My first
thought was an internal kernel limit on the time, but 500 days seems a bit
short.

Any ideas ?

Last message via e-mail was:
  Date: Fri, 15 Jun 2001 08:01:05 -0400
  To: root@inside.engsoc.carleton.ca
  From: Cron Daemon <root@inside.engsoc.carleton.ca>
  Subject: Cron <root@tap> run-parts /etc/cron.hourly

  Unable to open /dev/rtc, open() errno = Device or resource busy (16)

The log file has:
...
Jun 15 08:01:13 tap PAM_pwdb[3491]: (su) session opened for user nobody by (uid=99)
Jun 15 08:01:16 tap kernel: divide error: 0000
Jun 15 08:01:16 tap kernel: CPU:    0
Jun 15 08:01:16 tap kernel: EIP:    0010:[do_fast_gettimeoffset+71/120]
Jun 15 08:01:16 tap kernel: EFLAGS: 00013002
Jun 15 08:01:16 tap kernel: eax: 0ccabc7c   ebx: 01ea65e1   ecx: 00000017   edx: 00146440
Jun 15 08:01:16 tap kernel: esi: eb72aa0f   edi: 00000000   ebp: bffffbd4   esp: 00718f88
Jun 15 08:01:16 tap kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Jun 15 08:01:16 tap kernel: Process hwclock (pid: 3495, process nr: 63, stackpage=00718000)
Jun 15 08:01:16 tap kernel: Stack: 00718fb0 00003246 00000001 001109d6 bffffb3c 00000000 00117e08 00718fb0
Jun 15 08:01:16 tap kernel:        00a84414 bffffea8 3b29f90c 00007530 0010a989 bffffb3c 00000000 00000000
Jun 15 08:01:16 tap kernel:        bffffea8 00000001 bffffbd4 ffffffda 0000002b 0000002b 0000002b 0000002b
Jun 15 08:01:16 tap kernel: Call Trace: [do_gettimeofday+34/68] [sys_gettimeofday+44/112] [system_call+85/124]
Jun 15 08:01:16 tap kernel: Code: f7 f1 ba 10 27 00 00 89 c1 31 c0 f7 f1 a3 e4 03 1d 00 89 c3
Jun 15 08:01:16 tap kernel: divide error: 0000
Jun 15 08:01:16 tap kernel: CPU:    0
Jun 15 08:01:16 tap kernel: EIP:    0010:[do_fast_gettimeoffset+71/120]
Jun 15 08:01:16 tap kernel: EFLAGS: 00010002
Jun 15 08:01:16 tap kernel: eax: 0cf383d2   ebx: 01ea65e1   ecx: 00000019   edx: 00146440
Jun 15 08:01:16 tap kernel: esi: eb9b7165   edi: 00000000   ebp: bffffbd4   esp: 00ba1f88
Jun 15 08:01:16 tap kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Jun 15 08:01:16 tap kernel: Process hwclock (pid: 3509, process nr: 26, stackpage=00ba1000)
Jun 15 08:01:16 tap kernel: Stack: 00ba1fb0 00000246 3b29f90b 001109d6 bffffb2c 00000000 00117e08 00ba1fb0
Jun 15 08:01:16 tap kernel:        00842c0c 3b29f90c 3b29f90c 0000c350 0010a989 bffffb2c 00000000 00000001
Jun 15 08:01:16 tap kernel:        3b29f90c 3b29f90b bffffbd4 ffffffda 0000002b 0000002b 0000002b 0000002b
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@ 7829 now 7829.
May 11 07:52:29 tap kernel: eth2: No link beat on the MII interface, status then 7829 now 7829.
May 11 07:53:29 tap kernel: eth2: No link beat on the MII interface, status then 7829 now 7829.
May 11 07:54:29 tap kernel: eth2: No link beat on the MII interface, status then 7829 now 7829.
Jun 15 10:33:39 tap kernel: klogd 1.3-3, log source = /proc/kmsg started.
Jun 15 10:33:40 tap kernel: Loaded 4215 symbols from /boot/System.map.
Jun 15 10:33:40 tap kernel: Symbols match kernel version 2.0.35.
...

Thank You.

-- 
Paul N. Faure					613.266.3286
Chief Technical Officer, CertainKey Inc.	paul@certainkey.com
Carleton University Systems Eng. 3rd Year	paul@faure.ca
Engineering Society Administrator		paul@engsoc.org



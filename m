Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275219AbRIZOL3>; Wed, 26 Sep 2001 10:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275220AbRIZOLU>; Wed, 26 Sep 2001 10:11:20 -0400
Received: from mail.spylog.com ([194.67.35.220]:14312 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275219AbRIZOLM>;
	Wed, 26 Sep 2001 10:11:12 -0400
Date: Wed, 26 Sep 2001 18:07:48 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <1601012257268.20010926180748@spylog.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.10aa1 - 0-order allocation failed.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, Andrea,

        We have next problem on our servers:

Sep 26 11:22:39 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Sep 26 11:22:39 sol kernel: f048dd94 e02ab000 00000000 00000020 00000000 00000020 00000020 e298f820 
Sep 26 11:22:39 sol kernel:        e298f844 00000001 e030a56c e030a6c4 00000020 00000000 e01382be 00000000 
Sep 26 11:22:39 sol kernel:        e013874a e013488c 00000000 e298f820 00000202 e298f898 00000202 00000246 
Sep 26 11:22:39 sol kernel: Call Trace: [put_dirty_page+122/132] [flush_old_exec+234/572] [sys_ustat+212/268] [kill_super+232/352] [unix_gc+394/748] 
Sep 26 11:22:39 sol kernel:    [Unused_offset+27374/99203] [Unused_offset+12842/99203] [call_spurious_interrupt+14521/27705] [Unused_offset+43342/99203] [call_spurious_interrupt+14615/27705] [call_spurious_interrupt+16483/27705] 
Sep 26 11:22:39 sol kernel:    [Unused_offset+90704/99203] [ipgre_rcv+233/636] [ipgre_rcv+503/636] [fcntl_getlk+327/624] [do_invalid_TSS+43/96] 
Sep 26 11:22:39 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
Sep 26 11:22:39 sol kernel: f048ddd4 e02ab000 00000000 00000020 00000000 00000020 00000020 e298f820 
Sep 26 11:22:39 sol kernel:        e298f844 00000001 e030a56c e030a6c4 00000020 00000000 e01382be 00000000 
Sep 26 11:22:39 sol kernel:        e013874a e013488c 00000000 e298f820 00000202 e298f898 00000202 00000246 
Sep 26 11:22:39 sol kernel: Call Trace: [put_dirty_page+122/132] [flush_old_exec+234/572] [sys_ustat+212/268] [kill_super+232/352] [unix_gc+394/748] 
Sep 26 11:22:39 sol kernel:    [Unused_offset+27374/99203] [call_spurious_interrupt+13905/27705] [call_spurious_interrupt+17048/27705] [Unused_offset+90704/99203] [ipgre_rcv+233/636] [ipgre_rcv+503/636] 
Sep 26 11:22:39 sol kernel:    [fcntl_getlk+327/624] [do_invalid_TSS+43/96] 

        Also, we see next in process status:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
vz         927  0.0 625.1 43900 4267034752 ? S    08:10   0:00 hits
vz        1030  0.0 625.1 43900 4267034752 ? S    08:11   0:00 hits
vz        4561  1.3 625.1 45948 4267034724 ? S    10:48   0:00 hits
root      4564  0.0  0.0  1460  548 pts/2    S    10:48   0:00 grep hits
vz        4566  0.0 625.1 45948 4267034724 ? S    10:48   0:00 hits

        After these errors we see some uninterruptable processes (with flag D in
process  status),  gdb  say  that function "fdatasync" called and no returned...
Soft reboot not work.

        Server   has   2  CPUs (Pentium III Katmai), 2Gb RAM, 2Gb swap, Hardware
RAID (Mylex DAC960PTL1 PCI RAID Controller).

        Any ideas ?

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88


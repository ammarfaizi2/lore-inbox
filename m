Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWAXRtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWAXRtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWAXRtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:49:35 -0500
Received: from wumpus.mythic-beasts.com ([212.69.37.9]:63151 "EHLO
	wumpus.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S932465AbWAXRte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:49:34 -0500
Date: Tue, 24 Jan 2006 17:49:28 +0000
From: Chris Lightfoot <chris@ex-parrot.com>
To: linux-kernel@vger.kernel.org
Subject: kernel freeze on 2.4.32, apparently in cached_lookup
Message-ID: <tQjo3cDibk0S.MeaWngl+j1QiYR1U5+Ih3w@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Mail-Author: me
X-Face: "kUA_=&I|(by86eXgYc|U}5`O%<xlo,~+JN9uk"Z`A.UCf2\1KKZ{FY-IIOqH/IS"=5=cb` U,mDyyf8a6BzVgYT~pRtqze]%s#\(J{/um"(r,Ol^4J*Y%aWe-9`ZKGEYjG}d?#u2jzP,x37.%A~Qa ;Yy6Fz`i/vu{}?y8%cI)RJpLnW=$yTs=TDM'MGjX`/LDw%p;EK;[ww;9_;UnRa+JZYO}[-j]O08X\N m/K>M(P#,)y`g7N}Boz4b^JTFYHPz:s%idl@t$\Vv$3OL6:>GEGwFHrV$/bfnL=6uO/ggqZfet:&D3 Q=9c
X-Face-Plug: http://www.mythic-beasts.com/tools-toys/xface/
X-Sigs-Plug: vote on my signature quotes at http://ex-parrot.com/~chris/scripts/amisigornot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Pentium 4 machine running stock kernel 2.4.32
with ext3 on LVM on software RAID-1. HIMEM is enabled and
the machine has 3GB of RAM. Various details of the machine
and kernel as here:

http://ex-parrot.com/~chris/tmp/20060124/caesious-.config
http://ex-parrot.com/~chris/tmp/20060124/caesious-cpuinfo
http://ex-parrot.com/~chris/tmp/20060124/caesious-lsmod
http://ex-parrot.com/~chris/tmp/20060124/caesious-lspci

Occasionally -- often when running updatedb or another
disk-heavy cron job, but sometimes during normal use of
the machine -- the machine freezes up almost entirely
(mouse pointer stops working, ditto VC switching, no
console output if on the text console, SSH sessions
freeze, but network packet forwarding and NAT still work).
There's no output on the VGA console and the machine
doesn't respond to Ctrl-Alt-Sysrq, but does respond to
break+... on the serial console. That gives sysrq-p output
like this, from the most recent freeze:

SysRq : Show Regs
Pid: 30641, comm:             updatedb
EIP: 0010:d_lookup+63/110 CPU: 0 EFLAGS: 00000287    Tainted: P
EAX: c8632710 EBX: c8632700 ECX: 00000012 EDX: 13fe1842
ESI: d373b000 EDI: 0003ffff EBP: ea93bedc DS: 0018 ES: 0018
CR0: 8005003b CR2: 080a4094 CR3: 2965b000 CR4: 000006d0
Call Trace: cached_lookup+11/50 link_path_walk+63b/900 vfs_permission+79/120 path_lookup+1e/30 __user_walk+2b/50 sys_lstat64+17/70 system_call+33/38

-- repeating sysrq+p suggests that the kernel is stuck in 
d_lookup:

http://ex-parrot.com/~chris/tmp/20060124/caesious-regs-symbols

There's no oops or other message logged.

(I'm running a uniprocessor kernel -- the SMP kernel also
freezes under similar circumstances, and I wanted to
eliminate the SMP code as a source of problems.)

Does this look like a known problem? If not, what should I
do next to track down the problem? In particular, what
other information should I try to collect next time it
freezes?

(Please cc replies to me if possible....)

-- 
Q. Can I make copies of the copyright form?
(US Copyright Office FAQ)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUDZI5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUDZI5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUDZI5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:57:53 -0400
Received: from appel.xs4all.nl ([80.126.34.178]:26526 "EHLO peder.flower")
	by vger.kernel.org with ESMTP id S262380AbUDZI5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:57:43 -0400
To: linux-kernel@vger.kernel.org
Subject: possible ext3 journal corruption with 2.6.5
From: Jan Nieuwenhuizen <janneke@gnu.org>
Organization: Jan at Appel
Date: Mon, 26 Apr 2004 10:57:37 +0200
Message-ID: <874qr786bi.fsf@peder.flower>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've had ext3 filesystem troubles on software raid0 that started when
running 2.6.5 on a dual Athlon.  It did not go away until I removed
and recreated the journal.

/var/log was on the troubled raid0 when it happened, so this report is
probably mostly useless.  I've now moved that to raid1, just in case I
might catch interesting messages there.  If you think it may be
useful, I'm prepared to try 2.6.5 again; I'm sending this before I do
so, maybe you have a better suggestion?

I'm running raid0 and raid1 on two identical 60Mb Maxtor disks, and
have done so for about two years, with 2.4.x kernels.  My pc did
suffer from overheating problems, and installed better coolers three
months ago.  That's why I'm trying 2.6.x, in search of getting linux
to do some sane power management for my athlons.

I've ran twice e2fsck -fy several times (ie, second time without any
modifications), also with reboots in between, but after at most ~10
~10 minutes there would be problems again.

That's when running both 2.4.25-k7, and 2.6.5, on the e2fsck- clean
filesystem.

Then I decided to be more thorough, did badblocks test (took all night,
no bad block were reported) and make a new journal

   e2fsck -fycc /dev/md2
   tun2fs -O ^has_journal /dev/md2
   tun2fs -O has_journal /dev/md2

I gave it 7 hours rest, and booted 2.4.25 on friday.  It's been up now
for more than three days (which doesn't count for much, but it's a tad
better than 10 minutes, so the filesystem should be sane).

Jan.


Linux
Stock Debian kernel-image-2.6.5-1-k7-smp,  2.6.5-1

Uptime (about 6 days)

syslog
syslog.5.gz:3693:Apr 15 21:06:45 peder kernel: Inspecting /boot/System.map-2.6.5-1-k7-smp
[...]
Apr 21 22:20:33 peder spamd[30260]: processing message <20040421192406.GA19665@love.sense.znet> for janneke:1000. 
Apr 22 09:52:22 peder syslogd 1.4.1#14: restart.

messages
Apr 21 21:06:58 peder -- MARK --
Apr 21 21:26:58 peder -- MARK --
Apr 21 21:46:58 peder -- MARK --
Apr 21 22:06:58 peder -- MARK --
Apr 22 09:52:22 peder syslogd 1.4.1#14: restart.

kern.log
Apr 21 19:54:34 peder kernel: eth0: tx err, status 0x7fffb002
Apr 21 19:54:38 peder last message repeated 2 times
Apr 22 09:52:22 peder kernel: klogd 1.4.1#14, log source = /proc/kmsg started.

/dev/md2               76G   44G   28G  61% /var
/proc/mdstat 
Personalities : [raid0] [raid1] 
read_ahead 1024 sectors
md2 : active raid0 ide/host2/bus0/target0/lun0/part5[1] ide/host0/bus0/target0/lun0/part5[0]
      80000640 blocks 8k chunks
      
md1 : active raid1 ide/host2/bus0/target0/lun0/part3[1] ide/host0/bus0/target0/lun0/part3[0]
      10000256 blocks [2/2] [UU]
      
md0 : active raid1 ide/host2/bus0/target0/lun0/part1[1] ide/host0/bus0/target0/lun0/part1[0]
      5000064 blocks [2/2] [UU]
      
unused devices: <none>


Motherboard
Asus A7M266-D

/proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1800+
stepping	: 2
cpu MHz		: 1533.394
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3060.53

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1800+
stepping	: 2
cpu MHz		: 1533.394
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3060.53

/proc/ide/hda/model
MAXTOR 6L060J3

lspci -v -s02:06.0 
0000:02:06.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra133TX2
	Flags: bus master, 66MHz, slow devsel, latency 32, IRQ 17
	I/O ports at c400 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at b800 [size=8]
	I/O ports at b400 [size=4]
	I/O ports at b000 [size=16]
	Memory at f4800000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


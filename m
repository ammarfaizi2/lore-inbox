Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUD2EOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUD2EOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUD2EOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:14:35 -0400
Received: from mail1.thewrittenword.com ([67.95.107.114]:23812 "EHLO
	mail1.thewrittenword.com") by vger.kernel.org with ESMTP
	id S263325AbUD2EOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:14:20 -0400
Date: Wed, 28 Apr 2004 23:14:20 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at inode.c:1204! in 2.2.26
Message-ID: <20040429041420.GA85751@mail1.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: china@thewrittenword.com (Albert Chin-A-Young)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgraded to 2.2.26 on April 26 and received the following on April 27:

kernel: kernel BUG at inode.c:1204!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[iput+608/624] Tainted: PF
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: de603980   ecx: de603990   edx: de603990
kernel: esi: f7e6bc00   edi: 00000000   ebp: 00007a61   esp: f7e71efc
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kswapd (pid: 4, stackpage=f7e71000)
kernel: Stack: 00000292 de605880 00000292 de605918 de605900 de603980 c0148a4d de603980 
kernel:        de605880 00000017 c1886114 c0260e38 000063ad c0148da4 00009446 c012d336 
kernel:        00000006 000001d0 ffffffff 000001d0 00000017 00000020 000001d0 c0260e38 
kernel: Call Trace:    [prune_dcache+221/336] [shrink_dcache_memory+36/64] [shrink_cache+358/896] [shrink_caches+61/96] [try_to_free_pages_zone+98/240]
kernel:   [kswapd_balance_pgdat+102/176] [kswapd_balance+40/64] [kswapd+152/192] [kswapd+0/192] [rest_init+0/64] [arch_kernel_thread+46/64]
kernel:   [kswapd+0/192]
kernel: 
kernel: Code: 0f 0b b4 04 86 4b 23 c0 e9 c3 fd ff ff 8d 76 00 8b 54 24 04 

I did not encounter an OOPS. I saw this and then rebooted.

$ cat /proc/version
Linux version 2.4.26 (root@songoku) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 Mon Apr 26 19:26:00 CDT 2004

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 2009.990
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4010.80

$ cat /proc/modules
vmnet                  21152   3
vmmon                  20148   0 (unused)
snd-intel8x0           19556   0
snd-ac97-codec         49212   0 [snd-intel8x0]
snd-mpu401-uart         3568   0 [snd-intel8x0]
snd-rawmidi            14144   0 [snd-mpu401-uart]
snd-seq-device          4448   0 [snd-rawmidi]
snd-pcm                61604   0 [snd-intel8x0]
snd-timer              15012   0 [snd-pcm]
snd                    32836   0 [snd-intel8x0 snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device snd-pcm snd-timer]
snd-page-alloc          6772   0 [snd-intel8x0 snd-pcm]
parport_pc             13700   1 (autoclean)
lp                      6464   0 (autoclean)
parport                14912   1 (autoclean) [parport_pc lp]
msdos                   6156   0 (unused)
fat                    32792   0 [msdos]
mga_vid                 9952   0 (unused)
usbmouse                2296   0 (unused)
hid                    22148   0 (unused)
usb-uhci               23504   0 (unused)
mousedev                4404   1
input                   3520   0 [usbmouse hid mousedev]
3c59x                  26576   1
unix                   15532 134 (autoclean)

The hard disk in question is a Western Digital 100GB with the
following in /etc/fstab:
  /dev/hdb1 / ext3 defaults,errors=remount-ro 0 1
  /dev/hdb2 none swap sw 0 0
  /dev/hdb3 /var ext3 defaults 0 2
  /dev/hdb5 /var/tmp ext3 defaults 0 2
  /dev/hdb6 /tmp ext3 defaults 0 2
  /dev/hdb7 /home ext3 defaults 0 2
  /dev/hdb8 /opt ext3 defaults 0 2
  /dev/hdb9 /ext ext3 defaults 0 2

$ swapon -s
Filename                        Type            Size    Used    Priority
/dev/hdb2                       partition       1052248 0       -1

-- 
albert chin (china@thewrittenword.com)

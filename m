Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSA2Tp7>; Tue, 29 Jan 2002 14:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSA2Tpv>; Tue, 29 Jan 2002 14:45:51 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:49678 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S289844AbSA2Tpj>;
	Tue, 29 Jan 2002 14:45:39 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15446.64466.942172.240439@abasin.nj.nec.com>
Date: Tue, 29 Jan 2002 14:45:22 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Oops on raidstart
In-Reply-To: <15446.56358.694775.675717@abasin.nj.nec.com>
In-Reply-To: <15446.56358.694775.675717@abasin.nj.nec.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Heinicke writes:
 > 
 > My vanilla 2.4.17 kernel was oopsing during boot, even into single
 > user mode.  As I have been having raid issues recently I suspected the
 > RAID first.  So, I booted from a rescue disk, removed mounted raid
 > partitions from /etc/fstab (all of which are reiserfs), and moved my
 > raidtab file out of the way.
 > 
 > During normal reboot, no oops.  I copied my raidtab file back and
 > issued the raidstart command on md0.  A rebuild starts on my md0 and a
 > few minutes later I got the included oops.  This is a RAID5 partition
 > that has given me no problems until now.
 > 
 > Oops: 0002
 > CPU:    1
 > EIP:    0010:[<c0111f34>]    Not tainted
 > EFLAGS: 00010086
 > eax: ffffd000   ebx: c024ba78   ecx: 00000024   edx: 00001000
 > esi: ffffe010   edi: ffffe000   ebp: c028dcb0   esp: c181deb8
 > ds: 0018   es: 0018   ss: 0018
 > Process swapper (pid: 0, stackpage=c18d000)
 > Stack: 00000002 00000002 c017e26c c01120d3 0000000a 00000140 c0108681 0000000a
 >        c028de14 c1848e80 c017f6d2 0000000a c1848e80 c017f5f0 00000000 c0263f00
 >        00000282 c011e5d6 c1848e80 00000000 00000020 00000000 c026ef00 00000086
 > Call Trace: [<c017e26c>] [<c01120d3>] [<c0108681>] [<c017f6d2>] [<c017f5f0>]
 >    [<c011e5f6>] [<c011ad9e>] [<c011ac7d>] [<c011aa1f>] [<c010883d>] [<c01053c0>]
 >    [<c01053c0>] [<c010a818>] [<c01053c0>] [<c01053c0>] [<c01053ec>] [<c0105452>]
 >    [<c0116e2e>] [<c0116d3f>]
 > 
 > Code: 89 08 89 f0 29 d0 8b 13 8b 08 42 c1 e2 0c 89 f0 29 d0 81 c9
 >  <0>Kernel panic: Aiee, killing interrupted handler!
 > In interrupt handler - no syncing


Here is what ksymoops outputs.  Hopefully it's reliable as the oops
typed by hand.

>>EIP; c0111f34 <__mask_IO_APIC_irq+34/68>   <=====
Trace; c017e26c <reset_pollfunc+0/140>
Trace; c01120d2 <mask_IO_APIC_irq+1a/2c>
Trace; c0108680 <disable_irq+40/7c>
Trace; c017f6d2 <ide_timer_expiry+e2/208>
Trace; c017f5f0 <ide_timer_expiry+0/208>
Trace; c011e5f6 <timer_bh+266/2c0>
Trace; c011ad9e <bh_action+4a/84>
Trace; c011ac7c <tasklet_hi_action+60/90>
Trace; c011aa1e <do_softirq+6e/cc>
Trace; c010883c <do_IRQ+dc/ec>
Trace; c01053c0 <default_idle+0/34>
Trace; c01053c0 <default_idle+0/34>
Trace; c010a818 <call_do_IRQ+6/e>
Trace; c01053c0 <default_idle+0/34>
Trace; c01053c0 <default_idle+0/34>
Trace; c01053ec <default_idle+2c/34>
Trace; c0105452 <cpu_idle+3e/54>
Trace; c0116e2e <release_console_sem+9a/a0>
Trace; c0116d3e <printk+11e/138>
Code;  c0111f34 <__mask_IO_APIC_irq+34/68>
00000000 <_EIP>:
Code;  c0111f34 <__mask_IO_APIC_irq+34/68>   <=====
   0:   89 08                     mov    %ecx,(%eax)   <=====
Code;  c0111f36 <__mask_IO_APIC_irq+36/68>
   2:   89 f0                     mov    %esi,%eax
Code;  c0111f38 <__mask_IO_APIC_irq+38/68>
   4:   29 d0                     sub    %edx,%eax
Code;  c0111f3a <__mask_IO_APIC_irq+3a/68>
   6:   8b 13                     mov    (%ebx),%edx
Code;  c0111f3c <__mask_IO_APIC_irq+3c/68>
   8:   8b 08                     mov    (%eax),%ecx
Code;  c0111f3e <__mask_IO_APIC_irq+3e/68>
   a:   42                        inc    %edx
Code;  c0111f3e <__mask_IO_APIC_irq+3e/68>
   b:   c1 e2 0c                  shl    $0xc,%edx
Code;  c0111f42 <__mask_IO_APIC_irq+42/68>
   e:   89 f0                     mov    %esi,%eax
Code;  c0111f44 <__mask_IO_APIC_irq+44/68>
  10:   29 d0                     sub    %edx,%eax
Code;  c0111f46 <__mask_IO_APIC_irq+46/68>
  12:   81 c9 00 00 00 00         or     $0x0,%ecx

 <0>Kernel panic: Aiee, killing interrupted handler!

1 warning issued.  Results may not be reliable.

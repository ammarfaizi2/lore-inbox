Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTKPVTP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 16:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTKPVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 16:19:15 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:37013 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262791AbTKPVTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 16:19:11 -0500
Subject: [IDE-SCSI] Mounting a badly burned DVD generates OOPS
From: kuwanger <neutrino99@hotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069017546.5020.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Nov 2003 16:19:06 -0500
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [67.241.18.249] at Sun, 16 Nov 2003 15:19:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting a dvd with mount will generate an oops.  The ksymoops trace is
at bottom.  Off list, I was told that I should include relevant sections
of my kernel .config and lspci, so they're at the bottom too:

My kernel is a patched 2.4.21.  The patches include 2GB/2GB memory
split; the bttv 2.4.21-rc4, v4l2, lm-sensors 2.7.0, and i2c 2.7.0;
supermount 1.2.7_0306201731_2.4.21-ck2; bootsplash 3.0.7; and loop-aes
1.7e.  I'm willing to try another of the 2.4.x line vanilla, if anyone
thinks it's necessary.

If there's any other information I could provide or anything I could do,
let me know.

.config:

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y

lspci:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)

lsmod:

Module                  Size  Used by    Not tainted
ide-scsi               10448   0
smbfs                  39088   1  (autoclean)
ipt_REJECT              3256   2  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_tables              11768   2  [ipt_REJECT iptable_filter]
sis900                 14316   1  (autoclean)
loop_blowfish           8476   0  (unused)
loop_twofish           10652   3 
tuner                  10848   1  (autoclean)
tvaudio                13340   0  (autoclean) (unused)
bttv                   77056   0 
i2c-algo-bit            8328   1  [bttv]
videodev                6144   2  [bttv]
i2c-isa                 1128   0  (unused)
it87                    7364   0 
i2c-proc                7376   0  [it87]
i2c-core               15208   0  [tuner tvaudio bttv i2c-algo-bit
i2c-isa it87 i2c-proc]
emu10k1                61576   2 
sound                  57908   0  [emu10k1]
ac97_codec             11816   0  [emu10k1]

trace: (you can ignore the warning, as the same kernel and same modules
were loaded during both the oops and the ksymoops trace)

ksymoops 2.4.9 on i686 2.4.21kuw3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21kuw3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at ide-iops.c: 1262!
invalid operand: 0000
CPU: 0
EIP: 0010:[<801eb356>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
esi: bc197000 edi: 81b4b580 ebp: 80307eb8 esp: 80307e90
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:0, stackpage=80307000)
Stack: 803259ce 00000086 bc197000 80307eb8 8056bb4 81b4b580 00000086
00000000
bc197000 00000000 80307ec8 801e6569 8035c64 00000000 80307ef4 c0cc18c9
80356c64 801fc8e6 bc197000 00000002 00000000 bdec07c0 b5cd6800 00000296
Call Trace: [<801e6569>] [<c0cc18c9>] [<801fc8e6>] [<801fbd65>]
[<801fbcf0>]
[<801214b3>] [<80120bdd>] [<8011d4c2>] [<8011d3d6>] [<8011d207>]
[<8010abe0>]
[<801070d0>] [<8010cda8>] [<801070d0>] [<801070f6>] {,80107172>]
[<80105000>]
Code: 0f 0b ee 04 a8 32 2a 80 80 bf f9 00 00 00 20 74 0b 8b 75 0c


>>EIP; 801eb356 <ide_write_setting+96/f0>   <=====

>>esi; bc197000 <_end+3be31428/4094b488>
>>edi; 81b4b580 <_end+17e59a8/4094b488>
>>ebp; 80307eb8 <init_task_union+1eb8/2000>
>>esp; 80307e90 <init_task_union+1e90/2000>

Trace; 801e6569 <ide_do_reset+19/20>
Trace; c0cc18c9 <[ip_tables].data.end+8ad2/49269>
Trace; 801fc8e6 <scsi_reset+f6/360>
Trace; 801fbd65 <scsi_old_times_out+75/140>
Trace; 801fbcf0 <scsi_old_times_out+0/140>
Trace; 801214b3 <run_timer_list+f3/160>
Trace; 80120bdd <update_wall_time+d/40>
Trace; 8011d4c2 <bh_action+22/50>
Trace; 8011d3d6 <tasklet_hi_action+46/70>
Trace; 8011d207 <do_softirq+97/a0>
Trace; 8010abe0 <prof_cpu_mask_write_proc+0/40>
Trace; 801070d0 <default_idle+0/30>
Trace; 8010cda8 <mask_and_ack_8259A+38/e0>
Trace; 801070d0 <default_idle+0/30>
Trace; 801070f6 <default_idle+26/30>

Code;  801eb356 <ide_write_setting+96/f0>
00000000 <_EIP>:
Code;  801eb356 <ide_write_setting+96/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  801eb358 <ide_write_setting+98/f0>
   2:   ee                        out    %al,(%dx)
Code;  801eb359 <ide_write_setting+99/f0>
   3:   04 a8                     add    $0xa8,%al
Code;  801eb35b <ide_write_setting+9b/f0>
   5:   32 2a                     xor    (%edx),%ch
Code;  801eb35d <ide_write_setting+9d/f0>
   7:   80 80 bf f9 00 00 00      addb   $0x0,0xf9bf(%eax)
Code;  801eb364 <ide_write_setting+a4/f0>
   e:   20 74 0b 8b               and    %dh,0xffffff8b(%ebx,%ecx,1)
Code;  801eb368 <ide_write_setting+a8/f0>
  12:   75 0c                     jne    20 <_EIP+0x20>

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



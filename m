Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbVJREFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbVJREFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJREFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:05:01 -0400
Received: from mail.daxal.com ([66.221.37.219]:56807 "EHLO mail.daxal.com")
	by vger.kernel.org with ESMTP id S1751357AbVJREFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:05:00 -0400
From: Scott Edwards <supaplex@xmission.com>
Reply-To: scotte@surfthe.us
To: linux-kernel@vger.kernel.org
Subject: kernel oops with modprobe on 2.4.27 (with ksymoops resolution)
Date: Mon, 17 Oct 2005 22:03:11 -0600
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172203.12648.supaplex@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This box seems like it was up forever before it had this kernel oops.  If this 
doesn't belong in your group, please forward it to someone that can take care 
of it.  Thanks in advance!  I was cleaning up from a lot of modules loaded, 
and I recall using modprobe -r on multiple modules.

This appears to be a lsmod output captured minutes before the crash.  I recall 
unloading ftdi_sio, belkin_sa, keyspan, agpgart, usb-storage, and shortly 
after I reloaded ftdi_sio.  I was attempting to isolate some serial port 
issues (I have multiple usb/serial adaptors on hand, this box has a 8port 
gtek serial card in the isa slot, and the bios apparently had the two serial 
ports on 'os configure' which the kernel didn't touch on boot. /var/log/dmesg 
from the boot prior to this crash suggests that the gtek card was using 
ttyS03 if I recall correctly...)

pyroclastic:/var/log/ksymoops# cat 20051018021258.modules
ftdi_sio               18488   0 (unused)
ipt_LOG                 3032   2 (autoclean)
ipt_limit                824   2 (autoclean)
sd_mod                 10764   0 (autoclean)
usb-storage            54496   0
scsi_mod               86052   3 [sd_mod usb-storage]
ipt_mac                  632   2 (autoclean)
belkin_sa               4888   0
ppp_generic            17956   0 (autoclean)
slhc                    4144   0 (autoclean) [ppp_generic]
ipt_REJECT              3160   0 (autoclean)
iptable_filter          1644   1 (autoclean)
iptable_nat            14766   1 (autoclean)
ip_conntrack           17000   0 (autoclean) [iptable_nat]
ip_tables              10400   8 [ipt_LOG ipt_limit ipt_mac ipt_REJECT 
iptable_filter iptable_nat]
af_packet              11048   3 (autoclean)
keyspan                18356   0 (unused)
usbserial              18204   0 [ftdi_sio belkin_sa keyspan]
usb-uhci               19504   0 (unused)
usbcore                52268   1 [ftdi_sio usb-storage belkin_sa keyspan 
usbserial usb-uhci]
8139too                12328   1
mii                     1952   0 [8139too]
crc32                   2848   0 [8139too]
e100                   42868   2
agpgart                39108   0 (unused)
ide-cd                 27072   0
cdrom                  26212   0 [ide-cd]
rtc                     5768   0 (autoclean)
ext3                   65388   1 (autoclean)
jbd                    34628   1 (autoclean) [ext3]
ide-detect               288   0 (autoclean) (unused)
piix                    7784   1 (autoclean)
ide-disk               12448   1 (autoclean)
ide-core               91832   1 (autoclean) [usb-storage ide-cd ide-detect 
piix ide-disk]
unix                   12752  10 (autoclean)

I think this kernel was supplied by Debian.

ksymoops 2.4.9 on i686 2.4.27-2-386.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27-2-386/ (default)
     -m /boot/System.map-2.4.27-2-386 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/fs/ext3/ext3.o for module ext3 has 
changed sinceload
Warning (expand_objects): object /lib/modules/2.4.27-2-386/kernel/fs/jbd/jbd.o 
for module jbd has changed since load
Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/drivers/ide/ide-detect.o for module 
ide-detect has changed since load
Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/drivers/ide/pci/piix.o for module 
piix has changed since load
Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/drivers/ide/ide-disk.o for module 
ide-disk has changed since load
Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/drivers/ide/ide-core.o for module 
ide-core has changed since load
Warning (expand_objects): 
object /lib/modules/2.4.27-2-386/kernel/net/unix/unix.o for module unix has 
changed since load
Unable to handle kernel paging request at virtual address c88a76b8
c0182851
*pde = 011f4067
Oops: 0002
CPU:    0
EIP:    0010:[<c0182851>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c88a7600   ebx: c8850600   ecx: 00000000   edx: c0244720
esi: c02b30c4   edi: 00000000   ebp: ffffffea   esp: c5c59f08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 12163, stackpage=c5c59000)
Stack: c884d000 c02b30c4 c8850640 c884f28a c8850600 00000001 00000001 c0117367
       c8850520 080d2cae 00003436 00000060 00000060 00000009 c6e2c2e0 c1c86000
       c6833000 c8853000 00000060 c8912000 c884d060 0000471c 00000000 00000000
Call Trace:    [<c8850640>] [<c884f28a>] [<c8850600>] [<c0117367>] 
[<c8850520>]
  [<c884d060>] [<c01081fb>]
Code: 89 98 b8 00 00 00 89 1d 60 35 2b c0 f6 43 40 08 75 24 31 f6


>>EIP; c0182851 <tty_register_driver+65/a8>   <=====

>>eax; c88a7600 <[usbserial]serial_tty_driver+0/bb>
>>ebx; c8850600 <[cdrom]cdrom_get_last_written+44/132>
>>edx; c0244720 <tty_fops+0/60>
>>esi; c02b30c4 <tty_std_termios+24/40>
>>esp; c5c59f08 <_end+5981fe8/8535140>

Trace; c8850640 <[cdrom]cdrom_get_last_written+84/132>
Trace; c884f28a <[cdrom]cdrom_ioctl+92c/d2e>
Trace; c8850600 <[cdrom]cdrom_get_last_written+44/132>
Trace; c0117367 <sys_init_module+514/5ae>
Trace; c8850520 <[cdrom]cdrom_get_track_info+8c/a5>
Trace; c884d060 <[cdrom]register_cdrom+0/0>
Trace; c01081fb <system_call+33/38>

Code;  c0182851 <tty_register_driver+65/a8>
00000000 <_EIP>:
Code;  c0182851 <tty_register_driver+65/a8>   <=====
   0:   89 98 b8 00 00 00         mov    %ebx,0xb8(%eax)   <=====
Code;  c0182857 <tty_register_driver+6b/a8>
   6:   89 1d 60 35 2b c0         mov    %ebx,0xc02b3560
Code;  c018285d <tty_register_driver+71/a8>
   c:   f6 43 40 08               testb  $0x8,0x40(%ebx)
Code;  c0182861 <tty_register_driver+75/a8>
  10:   75 24                     jne    36 <_EIP+0x36>
Code;  c0182863 <tty_register_driver+77/a8>
  12:   31 f6                     xor    %esi,%esi


8 warnings issued.  Results may not be reliable.



On the bright side, this gave me an opportunity to scrutinize the bios 
settings and change the serial ports to manual configuration.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRIEAXz>; Tue, 4 Sep 2001 20:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269926AbRIEAXp>; Tue, 4 Sep 2001 20:23:45 -0400
Received: from extern.mbi-berlin.de ([194.95.11.135]:40140 "EHLO
	extern.mbi-berlin.de") by vger.kernel.org with ESMTP
	id <S269829AbRIEAXj>; Tue, 4 Sep 2001 20:23:39 -0400
Message-ID: <3B9570F0.5E6DF01B@informatik.hu-berlin.de>
Date: Wed, 05 Sep 2001 02:25:20 +0200
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS and hard locks when trying to access an CD-RW drive via ide-scsi
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have an RICOH CD-R/RW MP7063A ATAPI burner which I tried to get
working via ide-scsi emulation.  I got several hard locks with the error
message

	scsi : aborting command due to timeout pid 0, scsi 1, channel 0, id 0,
lun 0 Read (10) 00 00 00 00 00 00 00 01 00
	hda: timeout waiting for DMA
	ide_dmaproc : chipset supported ide_dma_timeout func only: 14

After an
	
	# cdrecord -speed=4 dev=1,0,0 -data cd_image

I got an oops, which I have decoded below:

ksymoops 2.4.2 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /boot/System.map-2.4.9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address
00000000
d0846ac0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d0846ac0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000003   edx: cdd28720
esi: 00008000   edi: 00000000   ebp: cc178000   esp: cd037b6c
ds: 0018   es: 0018   ss: 0018
Process cdrecord (pid: 498, stackpage=cd037000)
Stack: 00000000 00000001 d084e8c0 d084e880 00000000 00000000 00000001
00000000
       d0846b30 d084e880 cdd281a0 00000000 00000001 d084e8c0 d084e880
d084e8c0
       d0847060 d084e8c0 00000001 d084e8c0 ce8c0ee0 d084e8c0 0000f800
d085a458
Call Trace: [<d084e8c0>] [<d084e880>] [<d0846b30>] [<d084e880>]
[<d084e8c0>]
   [<d084e880>] [<d084e8c0>] [<d0847060>] [<d084e8c0>] [<d084e8c0>]
[<d084e8c0>]
   [<d085a458>] [<d0848e67>] [<d084e8c0>] [<d085a7af>] [<d084e8c0>]
[<d084e8c0>]
   [<d084e8c0>] [<d084e8c0>] [<d084e8c0>] [<d085a8ef>] [<d084e8c0>]
[<d08428f2>]
   [<d084e8c0>] [<d084e880>] [<d084e8c0>] [<d084e8c0>] [<d084e880>]
[<d0842c46>]
   [<d084e8c0>] [<d084e8e8>] [<d084327a>] [<d085b272>] [<d084e8c0>]
[<d084e8c0>]
   [<c016fe01>] [<c0175580>] [<c0176c1f>] [<c0176196>] [<c01761de>]
[<c017004f>]
   [<d085df9b>] [<d085ebcc>] [<d085dd3a>] [<d085e235>] [<c0129a5e>]
[<c0164230>]
   [<c0165632>] [<c01666f8>] [<c018b5a7>] [<c01637de>] [<c0166dea>]
[<c015c570>]
   [<c015831c>] [<c013be37>] [<c0106b0b>]
Code: f3 ab 8b 44 24 14 89 28 8b 4c 24 10 8b 7c 24 1c 89 74 0f 08

>>EIP; d0846ac0 <[ide-mod]ide_build_sglist+c8/114>   <=====
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e880 <[ide-mod]ide_hwifs+0/1fe0>
Trace; d0846b30 <[ide-mod]ide_build_dmatable+24/168>
Trace; d084e880 <[ide-mod]ide_hwifs+0/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e880 <[ide-mod]ide_hwifs+0/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d0847060 <[ide-mod]ide_dmaproc+e8/210>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d085a458 <[ide-scsi]idescsi_pc_intr+0/230>
Trace; d0848e66 <[ide-mod]piix_dmaproc+22/28>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d085a7ae <[ide-scsi]idescsi_issue_pc+6a/190>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d085a8ee <[ide-scsi]idescsi_do_request+1a/4c>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d08428f2 <[ide-mod]start_request+192/200>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e880 <[ide-mod]ide_hwifs+0/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e880 <[ide-mod]ide_hwifs+0/1fe0>
Trace; d0842c46 <[ide-mod]ide_do_request+28a/2d0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8e8 <[ide-mod]ide_hwifs+68/1fe0>
Trace; d084327a <[ide-mod]ide_do_drive_cmd+ee/120>
Trace; d085b272 <[ide-scsi]idescsi_queue+4f2/540>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; d084e8c0 <[ide-mod]ide_hwifs+40/1fe0>
Trace; c016fe00 <scsi_dispatch_cmd+1a4/22c>
Trace; c0175580 <scsi_old_done+0/578>
Trace; c0176c1e <scsi_request_fn+2b2/2e8>
Trace; c0176196 <__scsi_insert_special+66/70>
Trace; c01761de <scsi_insert_special_req+1a/20>
Trace; c017004e <scsi_do_req+11e/144>
Trace; d085df9a <[sg]sg_common_write+23a/254>
Trace; d085ebcc <[sg]sg_cmd_done_bh+0/320>
Trace; d085dd3a <[sg]sg_new_write+1ca/1f0>
Trace; d085e234 <[sg]sg_ioctl+280/ad4>
Trace; c0129a5e <_alloc_pages+16/18>
Trace; c0164230 <lf+34/60>
Trace; c0165632 <do_con_trol+17e/cbc>
Trace; c01666f8 <do_con_write+588/640>
^Trace; c018b5a6 <vgacon_cursor+17e/188>
Trace; c01637de <set_cursor+6e/80>
Trace; c0166dea <con_flush_chars+16/20>
Trace; c015c570 <write_chan+1fc/214>
Trace; c015831c <tty_write+154/1c0>
Trace; c013be36 <sys_ioctl+16a/184>
Trace; c0106b0a <system_call+32/38>
Code;  d0846ac0 <[ide-mod]ide_build_sglist+c8/114>
00000000 <_EIP>:
Code;  d0846ac0 <[ide-mod]ide_build_sglist+c8/114>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  d0846ac2 <[ide-mod]ide_build_sglist+ca/114>
   2:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  d0846ac6 <[ide-mod]ide_build_sglist+ce/114>
   6:   89 28                     mov    %ebp,(%eax)
Code;  d0846ac8 <[ide-mod]ide_build_sglist+d0/114>
   8:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  d0846acc <[ide-mod]ide_build_sglist+d4/114>
   c:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
Code;  d0846ad0 <[ide-mod]ide_build_sglist+d8/114>
  10:   89 74 0f 08               mov    %esi,0x8(%edi,%ecx,1)


1 warning issued.  Results may not be reliable.

After the oops I get the following messages in the syslog, continously:

	scsi : aborting command due to timeout : pid 0, scsi1, channel 0, id 0,
lun 0 Write (10) 00 00 00 00 00 00 00 1f 00
	SCSI host 1 abort (pid 0) timed out - resetting
	SCSI bus is being reset for host 1 channel 0.

modules loaded at that time:

# lsmod
Module                  Size  Used by
ide-scsi                7712   1
ide-cd                 26432   0
sg                     26704   1  (autoclean)
ide-mod                63632   0  [ide-scsi ide-cd]
rtc                     5408   0  (autoclean)
nfs                    73200   4  (autoclean)
lockd                  48272   1  (autoclean) [nfs]
sunrpc                 60976   1  (autoclean) [nfs lockd]

After the oops the scsi system is in a bad shape, ie the continous error
message and also cdrecord -scanbus hangs when trying to access the
second scsi bus which is handled by ide-scsi.  It cannot be killed, even
with SysRQ+K, and shows up in ps ax in a D state.  (I also have a first
scsi bus handled by a sym53c875 with a CD-ROM drive and a hard disk
attached, which appears to be working fine after the oops.)  I do not
use any IDE devices other then the RICOH burner.

Something that might be related is that I can't get ide-scsi trivially
to recognize the atapi burner.  Ie, after an

	# modprobe ide-mod
	# modprobe ide-scsi
	# modprobe sg

the RICOH is not recognized.  Instead I have to do

	# modprobe ide-mod
	# modprobe ide-probe-mod	<-- 1
	# modprobe ide-scsi		<-- 2
	# modprobe sg

1 -- this will report the RICOH as hda: ATAPI CD-ROM drive
2 -- this will install a new scsi bus scsi1, and report the RICOH as sr1

I tried various strategies of module loading, ie unloading ide-probe-mod
after ide-scsi has found the RICOH, or loading ide-cd ignore=hda, but I
either get a hard lock when trying to access the RICOH, or (if I'm
lucky) an oops.  When the machine locks, it's totally unresponsible, ie
won't answer pings or react to the magic SysRQ key.  I'm running a stock
2.4.9 kernel w/o any additional patches.

Viktor

PS: The RICOH works successfully under Windows.  :(
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTAMFEs>; Mon, 13 Jan 2003 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTAMFEs>; Mon, 13 Jan 2003 00:04:48 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:53489 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S267853AbTAMFEn>; Mon, 13 Jan 2003 00:04:43 -0500
Date: Mon, 13 Jan 2003 16:13:23 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi bug hard locks machine
Message-ID: <20030113051323.GF3234@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so after some coaching, below should be some useful information.

I have a liteon 48x cd burner connected to a promise controller using
ide-scsi, this currently works fine on 2.5.52. I think this also
happened with 2.5.54 and I gave up on that one. The output below is from
2.5.56.

Thanks


ksymoops 2.4.8 on i686 2.5.52.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.52/ (default)
     -m /boot/System.map-2.5.56 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<c0116941>]  [<c0109b76>]  [<c01169b0>]  [<c011a5db>]  [<c0109d8c>]  [<c0263100>]  [<c0262730>]  [<c026848c>]  [<c0268390>]  [<c0261e63>]  [<c0261cc0>]  [<c0261c80>]  [<c026225d>]  [<c02622d7>]  [<c0262b65>]  [<c0109d97>]  [<c0262c89>]  [<c0262bb0>]  [<c0108be9>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0116941 <schedule+2f1/300>
Trace; c0109b76 <__down+96/100>
Trace; c01169b0 <default_wake_function+0/40>
Trace; c011a5db <call_console_drivers+5b/120>
Trace; c0109d8c <__down_failed+8/c>
Trace; c0263100 <.text.lock.scsi_error+2d/6d>
Trace; c0262730 <scsi_sleep_done+0/20>
Trace; c026848c <idescsi_abort+fc/110>
Trace; c0268390 <idescsi_abort+0/110>
Trace; c0261e63 <scsi_send_eh_cmnd+153/1a0>
Trace; c0261cc0 <scsi_eh_done+0/50>
Trace; c0261c80 <scsi_eh_times_out+0/40>
Trace; c026225d <scsi_eh_tur+9d/d0>
Trace; c02622d7 <scsi_eh_abort_cmd+47/70>
Trace; c0262b65 <scsi_unjam_host+a5/f0>
Trace; c0109d97 <__down_failed_interruptible+7/c>
Trace; c0262c89 <scsi_error_handler+d9/110>
Trace; c0262bb0 <scsi_error_handler+0/110>
Trace; c0108be9 <kernel_thread_helper+5/c>

kernel BUG at drivers/scsi/ide-scsi.c:483!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0267845>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c024ab50   ebx: c0448d84   ecx: edae15ed   edx: 0000d002
esi: d7c96800   edi: d7c93bc0   ebp: 00000000   esp: d7c4be5c
ds: 007b   es: 007b   ss: 0068
Stack: 0000d002 c0448d84 00000008 00000080 0000001e c0448d84 c0448d84 00000000 
       d7d023c0 c0246bd9 c0448d84 d7c93bc0 00000000 00000088 0000001e d7c4a000 
       d7d023c0 c0448d84 d7d7eb80 c0246dd9 c0448d84 d7d023c0 c0448e2c d7c4a000 
Call Trace: [<c0246bd9>]  [<c0246dd9>]  [<c02474ff>]  [<c0247443>]  [<c026825b>]  [<c0261dbc>]  [<c0261cc0>]  [<c0261c80>]  [<c026225d>]  [<c0262417>]  [<c02622d7>]  [<c0262b79>]  [<c0109d97>]  [<c0262c89>]  [<c0262bb0>]  [<c0108be9>] 
Code: 0f 0b e3 01 2b 07 38 c0 8b 57 38 a1 c8 d0 42 c0 89 d1 29 c1 


>>EIP; c0267845 <idescsi_transfer_pc+a5/110>   <=====

>>eax; c024ab50 <atapi_reset_pollfunc+0/120>
>>ebx; c0448d84 <ide_hwifs+f64/4998>

Trace; c0246bd9 <start_request+f9/1b0>
Trace; c0246dd9 <ide_do_request+f9/210>
Trace; c02474ff <ide_do_drive_cmd+9f/100>
Trace; c0247443 <ide_init_drive_cmd+23/40>
Trace; c026825b <idescsi_queue+1eb/320>
Trace; c0261dbc <scsi_send_eh_cmnd+ac/1a0>
Trace; c0261cc0 <scsi_eh_done+0/50>
Trace; c0261c80 <scsi_eh_times_out+0/40>
Trace; c026225d <scsi_eh_tur+9d/d0>
Trace; c0262417 <scsi_eh_bus_device_reset+77/c0>
Trace; c02622d7 <scsi_eh_abort_cmd+47/70>
Trace; c0262b79 <scsi_unjam_host+b9/f0>
Trace; c0109d97 <__down_failed_interruptible+7/c>
Trace; c0262c89 <scsi_error_handler+d9/110>
Trace; c0262bb0 <scsi_error_handler+0/110>
Trace; c0108be9 <kernel_thread_helper+5/c>

Code;  c0267845 <idescsi_transfer_pc+a5/110>
00000000 <_EIP>:
Code;  c0267845 <idescsi_transfer_pc+a5/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0267847 <idescsi_transfer_pc+a7/110>
   2:   e3 01                     jecxz  5 <_EIP+0x5>
Code;  c0267849 <idescsi_transfer_pc+a9/110>
   4:   2b 07                     sub    (%edi),%eax
Code;  c026784b <idescsi_transfer_pc+ab/110>
   6:   38 c0                     cmp    %al,%al
Code;  c026784d <idescsi_transfer_pc+ad/110>
   8:   8b 57 38                  mov    0x38(%edi),%edx
Code;  c0267850 <idescsi_transfer_pc+b0/110>
   b:   a1 c8 d0 42 c0            mov    0xc042d0c8,%eax
Code;  c0267855 <idescsi_transfer_pc+b5/110>
  10:   89 d1                     mov    %edx,%ecx
Code;  c0267857 <idescsi_transfer_pc+b7/110>
  12:   29 c1                     sub    %eax,%ecx


1 warning and 1 error issued.  Results may not be reliable.



output from lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15)


-- 
Jason Thomas                           Phone:  +61 2 6257 7111
Unix System Administrator              Fax:    +61 2 6257 7311
tSA Consulting Group Pty. Ltd.         Mobile: 0418 29 66 81
1 Hall Street Lyneham ACT 2602         http://www.topic.com.au/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281519AbRKZIos>; Mon, 26 Nov 2001 03:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281530AbRKZIoj>; Mon, 26 Nov 2001 03:44:39 -0500
Received: from a205017.upc-a.chello.nl ([62.163.205.17]:43648 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id <S281519AbRKZIoU>;
	Mon, 26 Nov 2001 03:44:20 -0500
Date: Mon, 26 Nov 2001 09:44:10 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: linux-kernel@vger.kernel.org
Subject: Constant OOPSes with recent kernels
Message-ID: <20011126094410.A1452@casa.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-operating-system: Linux casa 2.4.13-ac7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I am running an oldish Athlon (slot-type) 500MHz machine. I use
Debian (sid). I have been using AC kernels up to 2.4.13-ac7 without
problems. When moving to 2.4.15pre-something, and then now with
2.5.1pre1 I have oopses of various flavours very close to startup. 

Because of lack of time I could not jot down the details. Yesterday
evening I was able to bring up a functioning user shell; then when
asking for a man page I got two OOPSes that were captured by klogd. I
was able to run ksymoops on them (right after the oops); here is what
I got:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

ksymoops 2.3.7 on i686 2.5.1-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says d6893f64, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/sr_mod.o says d6893e80.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d688effc, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o says d688d7d4.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d688f028, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o says d688d800.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d688f024, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o says d688d7fc.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d688f02c, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o says d688d804.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d688eff8, /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o says d688d7d0.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol output_offset  , ov511 says d6878760, /lib/modules/2.5.1-pre1/kernel/drivers/usb/ov511.o says d68780c0.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/usb/ov511.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d685b114, /lib/modules/2.5.1-pre1/kernel/drivers/usb/usbcore.o says d685ac34.  Ignoring /lib/modules/2.5.1-pre1/kernel/drivers/usb/usbcore.o entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129421>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c119dcc0   ebx: c119dcc0   ecx: c119dcc0   edx: 00000000
esi: 00060000   edi: 00000000   ebp: 0849c000   esp: c6899ef8
ds: 0018   es: 0018   ss: 0018
Process troff (pid: 275, stackpage=c6899000)
Stack: c119dcc0 00060000 c6c143f0 0849c000 c0336888 c1040000 00000212 fffffffc
       c0128735 c0129b2c c119dcc0 c0129f11 c119dcc0 c012006a c119dcc0 00079000
       c0120470 06773067 c6a30640 d3e3e8c0 0809c000 00079000 c6c38084 c6c38084
Call Trace: [<c0128735>] [<c0129b2c>] [<c0129f11>] [<c012006a>] [<c0120470>]
   [<c0122775>] [<c01129b9>] [<c0116986>] [<c0116b0e>] [<c0106c4b>]
Code: 0f 0b 8b 53 08 85 d2 74 02 0f 0b 89 d8 2b 05 6c fc 39 c0 c1

>>EIP; c0129421 <__free_pages_ok+11/1f0>   <=====
Trace; c0128735 <lru_cache_del+5/10>
Trace; c0129b2c <page_cache_release+2c/30>
Trace; c0129f11 <free_page_and_swap_cache+31/40>
Trace; c012006a <__free_pte+3a/40>
Trace; c0120470 <zap_page_range+180/230>
Trace; c0122775 <exit_mmap+b5/110>
Trace; c01129b9 <mmput+39/60>
Trace; c0116986 <do_exit+86/1e0>
Trace; c0116b0e <sys_exit+e/10>
Trace; c0106c4b <system_call+33/38>
Code;  c0129421 <__free_pages_ok+11/1f0>
00000000 <_EIP>:
Code;  c0129421 <__free_pages_ok+11/1f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129423 <__free_pages_ok+13/1f0>
   2:   8b 53 08                  mov    0x8(%ebx),%edx
Code;  c0129426 <__free_pages_ok+16/1f0>
   5:   85 d2                     test   %edx,%edx
Code;  c0129428 <__free_pages_ok+18/1f0>
   7:   74 02                     je     b <_EIP+0xb> c012942c <__free_pages_ok+1c/1f0>
Code;  c012942a <__free_pages_ok+1a/1f0>
   9:   0f 0b                     ud2a   
Code;  c012942c <__free_pages_ok+1c/1f0>
   b:   89 d8                     mov    %ebx,%eax
Code;  c012942e <__free_pages_ok+1e/1f0>
   d:   2b 05 6c fc 39 c0         sub    0xc039fc6c,%eax
Code;  c0129434 <__free_pages_ok+24/1f0>
  13:   c1 00 00                  roll   $0x0,(%eax)

 invalid operand: 0000
CPU:    0
EIP:    0010:[<c0129421>]    Tainted: P
EFLAGS: 00010206
eax: c119d180   ebx: c119d180   ecx: c119d180   edx: 00000000
esi: 00011000   edi: 00000000   ebp: 08457000   esp: c6895e60
ds: 0018   es: 0018   ss: 0018
Process grotty (pid: 276, stackpage=c6895000)
Stack: c119d180 00011000 c68921a0 08457000 c0336888 c1040000 00000217 ffffffff
       c0128735 c0129b2c c119d180 c0129f11 c119d180 c012006a c119d180 00027000
       c0120470 06746067 c6a300c0 d3e3e980 08057000 00027000 c6893084 c6893084
Call Trace: [<c0128735>] [<c0129b2c>] [<c0129f11>] [<c012006a>] [<c0120470>]
   [<c0122775>] [<c01129b9>] [<c0116986>] [<c0106af8>] [<c0135b9c>] [<c012e2d3>]
   [<c0106c84>]
Code: 0f 0b 8b 53 08 85 d2 74 02 0f 0b 89 d8 2b 05 6c fc 39 c0 c1

>>EIP; c0129421 <__free_pages_ok+11/1f0>   <=====
Trace; c0128735 <lru_cache_del+5/10>
Trace; c0129b2c <page_cache_release+2c/30>
Trace; c0129f11 <free_page_and_swap_cache+31/40>
Trace; c012006a <__free_pte+3a/40>
Trace; c0120470 <zap_page_range+180/230>
Trace; c0122775 <exit_mmap+b5/110>
Trace; c01129b9 <mmput+39/60>
Trace; c0116986 <do_exit+86/1e0>
Trace; c0106af8 <do_signal+228/290>
Trace; c0135b9c <pipe_write+25c/270>
Trace; c012e2d3 <sys_write+c3/d0>
Trace; c0106c84 <signal_return+14/18>
Code;  c0129421 <__free_pages_ok+11/1f0>
00000000 <_EIP>:
Code;  c0129421 <__free_pages_ok+11/1f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129423 <__free_pages_ok+13/1f0>
   2:   8b 53 08                  mov    0x8(%ebx),%edx
Code;  c0129426 <__free_pages_ok+16/1f0>
   5:   85 d2                     test   %edx,%edx
Code;  c0129428 <__free_pages_ok+18/1f0>
   7:   74 02                     je     b <_EIP+0xb> c012942c <__free_pages_ok+1c/1f0>
Code;  c012942a <__free_pages_ok+1a/1f0>
   9:   0f 0b                     ud2a   
Code;  c012942c <__free_pages_ok+1c/1f0>
   b:   89 d8                     mov    %ebx,%eax
Code;  c012942e <__free_pages_ok+1e/1f0>
   d:   2b 05 6c fc 39 c0         sub    0xc039fc6c,%eax
Code;  c0129434 <__free_pages_ok+24/1f0>
  13:   c1 00 00                  roll   $0x0,(%eax)


9 warnings issued.  Results may not be reliable.

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

I cannot understand the reason for the warnings: System.map was the
right file, and ksymoops was run on the same kernel that produced the
OOPS itself. 

I saw other reports of OOPSes caused in this __free_pages_ok function,
but it seems each was cured individually. 

The strange thing is that after the above OOPS messages, I could then
ask for other manpages without problems.

Let me know if I can provide more info. I am now safely back to
2.4.13ac7 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)

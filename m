Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRJ3Buu>; Mon, 29 Oct 2001 20:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279740AbRJ3Bul>; Mon, 29 Oct 2001 20:50:41 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:56515 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279739AbRJ3Bue>; Mon, 29 Oct 2001 20:50:34 -0500
Date: Mon, 29 Oct 2001 20:52:59 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.14-pre4
Message-ID: <20011029205259.A196@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:	2 oops, mmap001 times good with high sound quality.

Same old tests, same old box.

mp3 played 250 of 313 seconds.

Averages for 10 mtest01 runs
bytes allocated:                    1244554854
User time (seconds):                2.107
System time (seconds):              3.063
Elapsed (wall clock) time:          31.306
Percent of CPU this job got:        16.00
Major (requiring I/O) page faults:  106.8
Minor (reclaiming a frame) faults:  304641.7

mp3 played 860 of 865 seconds.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.354
System time (seconds):              18.508
Elapsed (wall clock seconds) time:  172.63
Percent of CPU this job got:        21.60
Major (requiring I/O) page faults:  500165.0
Minor (reclaiming a frame) faults:  43.0



Neither oops caused the machine to reboot.  The /boot/System.map 
file was for 2.4.14-pre4, and these ksymoops were taken before 
I rebooted.  I pasted the oops from /var/log/kern.log and passed 
them to ksymoops without any arguments.

vmstat, iostat, and ps all would not return a prompt.  I could
exit shells, and IRC clients.  init 6 hung sending kill to processes
started by init.  <sysrq Sync Umount> worked.  Hit the reset button.
Thanks to the kernel hackers and reiserfs folks it came up clean.

This oops came during the mtest01 run.

invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+93/484]    Tainted: P
EFLAGS: 00010202
eax: 0000008c   ebx: c121c2c0   ecx: c121c2c0   edx: 00000000
esi: c121c2c0   edi: 00000000   ebp: 00000000   esp: c183dec4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c183d000)
Stack: 00000001 c121c2c0 c121c2e8 00000000 003728e8 c182d8a0 00000000 c1528140
c0122c1e c0128f15 c0127be5 00000000 c155dd00 0000000d 00000000 c121c2e4
08453000 08056000 0870b005 df42d154 00000020 08059000 08055000 df430080
Call Trace: [mark_page_accessed+30/60] [__free_pages+29/32] [swap_out+869/1356] [shrink_cache+723/976] [shrink_caches+80/100]
Code: 0f 0b ba 00 e0 ff ff 21 e2 80 63 18 eb f6 42 05 20 0f 85 3e
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   ba 00 e0 ff ff            mov    $0xffffe000,%edx
Code;  00000006 Before first symbol
   7:   21 e2                     and    %esp,%edx
Code;  00000008 Before first symbol
   9:   80 63 18 eb               andb   $0xeb,0x18(%ebx)
Code;  0000000c Before first symbol
   d:   f6 42 05 20               testb  $0x20,0x5(%edx)
Code;  00000010 Before first symbol
  11:   0f 85 3e 00 00 00         jne    55 <_EIP+0x55> 00000054 Before first symbol


This oops came after the tests completed and I hit 'q' to quit mp3blaster:

invalid operand: 0000
CPU:    0
EIP:    0010:[do_swap_page+135/228]    Tainted: P
EFLAGS: 00010246
eax: 00000000   ebx: c15a24c0   ecx: c15a24e8   edx: c15a24e8
esi: 031afc00   edi: de3513f8   ebp: 00000001   esp: d30efecc
ds: 0018   es: 0018   ss: 0018
Process mp3blaster (pid: 223, stackpage=d30ef000)
Stack: 400fe824 ded0d460 00000000 de634180 c01207ce ded0d460 de634180 400fe824
de3513f8 031afc00 00000000 ded0d460 00000000 de634180 400fe824 c0111714
ded0d460 de634180 400fe824 00000000 d30ee000 00000004 c01115b8 414e9a04
Call Trace: [handle_mm_fault+98/176] [do_page_fault+348/1176] [do_page_fault+0/1176] [<e0c3c987>] [<e0c3c9de>]
[<e0c3e966>] [schedule+548/852] [do_page_fault+0/1176] [error_code+52/64]
Code: 0f 0b 8d 73 24 8d 43 28 39 43 28 74 11 b9 01 00 00 00 ba 03
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; e0c3e966 <[cmpci]cm_write+59a/5b0>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   8d 73 24                  lea    0x24(%ebx),%esi
Code;  00000004 Before first symbol
   5:   8d 43 28                  lea    0x28(%ebx),%eax
Code;  00000008 Before first symbol
   8:   39 43 28                  cmp    %eax,0x28(%ebx)
Code;  0000000a Before first symbol
   b:   74 11                     je     1e <_EIP+0x1e> 0000001e Before first symbol
Code;  0000000c Before first symbol
   d:   b9 01 00 00 00            mov    $0x1,%ecx
Code;  00000012 Before first symbol
  12:   ba 03 00 00 00            mov    $0x3,%edx


I see pre5 is out there, and it's still early.  :)
-- 
Randy Hron


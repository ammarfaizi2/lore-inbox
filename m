Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTBQRoD>; Mon, 17 Feb 2003 12:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTBQRoD>; Mon, 17 Feb 2003 12:44:03 -0500
Received: from [209.184.141.189] ([209.184.141.189]:58008 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S267212AbTBQRoB>;
	Mon, 17 Feb 2003 12:44:01 -0500
Subject: Kernel bug at ll_rw_blk.c:1194
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045504300.4834.5.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 11:51:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened when a file system got full, and oracle was still trying
to archive.

ksymoops 2.4.1 on i686 2.4.20-ag3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-ag3/ (default)
     -m /boot/System.map-2.4.20-ag3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal

kernel BUG at ll_rw_blk.c:1194!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01eb31e>]    Not tainted
EFLAGS: 00010206
eax: 00000410   ebx: 00000008   ecx: cc17c680   edx: cc17c680
esi: 00000001   edi: 00000002   ebp: 00000007   esp: c8869f0c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 11, stackpage=c8869000)
Stack: cc17c680 00000001 c014404d 00000001 cc17c680 00000100 ffffffff
c1017c90
       000001d0 c02f2760 cc17c680 cc17c680 c1017c90 c014418b cc17c680
00000001
       00000000 c1017c90 c014221f c02f2760 c1017c90 000001d0 c02f2760
c0134b85
Call Trace:    [<c014404d>] [<c014418b>] [<c014221f>] [<c0134b85>]
[<c0136cda>]
  [<c013723c>] [<c0137681>] [<c0105000>] [<c0107296>] [<c0137570>]

Code: 0f 0b aa 04 fa 60 2c c0 b8 03 00 00 00 f0 0f ab 42 18 b8 08kernel
BUG at ll_rw_blk.c:1194!
invalid operand: 0000
EFLAGS: 00010206
eax: 00000410   ebx: 00000008   ecx: cc17c680   edx: cc17c680
esi: 00000001   edi: 00000002   ebp: 00000007   esp: c8869f0c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 11, stackpage=c8869000)
Stack: cc17c680 00000001 c014404d 00000001 cc17c680 00000100 ffffffff
c1017c90

Code: 0f 0b aa 04 fa 60 2c c0 b8 03 00 00 00 f0 0f ab 42 18 b8 08
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   aa                        stos   %al,%es:(%edi)
Code;  00000003 Before first symbol
   3:   04 fa                     add    $0xfa,%al
Code;  00000005 Before first symbol
   5:   60                        pusha
Code;  00000006 Before first symbol
   6:   2c c0                     sub    $0xc0,%al
Code;  00000008 Before first symbol
   8:   b8 03 00 00 00            mov    $0x3,%eax
Code;  0000000d Before first symbol
   d:   f0 0f ab 42 18            lock bts %eax,0x18(%edx)
Code;  00000012 Before first symbol
  12:   b8 08 00 00 00            mov    $0x8,%eax


-- 
GrandMasterLee <masterlee@digitalroadkill.net>

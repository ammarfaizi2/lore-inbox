Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267251AbSKVA7p>; Thu, 21 Nov 2002 19:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267250AbSKVA7p>; Thu, 21 Nov 2002 19:59:45 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:24967
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267249AbSKVA7o>; Thu, 21 Nov 2002 19:59:44 -0500
Message-ID: <3DDD8339.2040409@tupshin.com>
Date: Thu, 21 Nov 2002 17:07:05 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: paging oops with 2.4.20-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing frequent oops when doing much of anything 
cpu/memory/disk intensive. I've yet to get through a kernel compilation 
on this machine.

The hardware is a new kt400 based motherboard (Gigabyte GA-7VAX with VIA 
chipset)with an athlon XP.  I upgraded to 2.4.20-rc2 in order to get DMA 
support for the VIA 8235 chipset, and that appears to work. However, 
this version did introduce frequent oops(as shown below), all involving 
kernel paging requests.  I've included a ksymoops processed log below. 
Please let me know if you need more information, as this is the first 
kernel bug report I've made.

Some notable things about the machine:
1)Every partition is reiserfs 3.6
2) Every partition except /boot is on a software raid-0 + LVM setup.

Thanks
-Tupshin


Unable to handle kernel paging request at virtual address db7c7cd8
c01a76f9
*pde = 1b40e9e3
Oops: 0009
CPU:    0
EIP:    0010:[do_journal_end+1513/2720]    Not tainted
EFLAGS: 00010206
eax: db7c7cc0   ebx: 00000024   ecx: d572b000   edx: 8005003b
esi: d6f1e000   edi: d572b000   ebp: e0bb41a8   esp: c15b5f3c
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 6, stackpage=c15b5000)
Stack: c15b5fa0 df5dec00 0000001f 3ddd5019 00002c98 00000004 00000002 
00000000
       000000c5 000000e8 00000bd4 d5969140 d5712440 d554b000 d5968000 
e0b9db10
       c01a6b0f c15b5fa0 df5dec00 00000001 00000006 df5dec00 df5dec44 
c15b424b
Call Trace:    [flush_old_commits+287/320] [reiserfs_write_super+21/32] 
[sync_supers+191/240] [sync_old_buffers+12/64] [kupdate+213/256]
Code: 8b 40 18 a9 00 00 01 00 0f 84 89 00 00 00 8b 44 24 48 8b 54
Using defaults from ksymoops -t elf32-i386 -a i386


 >>eax; db7c7cc0 <_end+1b4105bc/2070095c>
 >>ecx; d572b000 <_end+153738fc/2070095c>
 >>esi; d6f1e000 <_end+16b668fc/2070095c>
 >>edi; d572b000 <_end+153738fc/2070095c>
 >>ebp; e0bb41a8 <[8139too].data.end+f3221/4270d9>
 >>esp; c15b5f3c <_end+11fe838/2070095c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 18                  mov    0x18(%eax),%eax
Code;  00000003 Before first symbol
   3:   a9 00 00 01 00            test   $0x10000,%eax
Code;  00000008 Before first symbol
   8:   0f 84 89 00 00 00         je     97 <_EIP+0x97>
Code;  0000000e Before first symbol
   e:   8b 44 24 48               mov    0x48(%esp,1),%eax
Code;  00000012 Before first symbol
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx



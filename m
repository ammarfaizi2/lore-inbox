Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSIEDvY>; Wed, 4 Sep 2002 23:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSIEDvY>; Wed, 4 Sep 2002 23:51:24 -0400
Received: from mail.aspec.ru ([217.14.198.4]:32004 "EHLO mail.aspec.ru")
	by vger.kernel.org with ESMTP id <S316499AbSIEDvX>;
	Wed, 4 Sep 2002 23:51:23 -0400
Message-ID: <3D76D598.6050401@belkam.com>
Date: Thu, 05 Sep 2002 08:55:04 +0500
From: Dmitry Melekhov <dm@belkam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-xfs oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We had our fileserver died this night.
Sorry, I wrote down oops info by hands (so it is possible
that there are mistypings) and I can't run ksymoops on 2.4.19,
because we switched back to 2.4.18 for now, so most of warinings
are skipped here. Hope, anyway, that this info can help.

kernel BUG at filemap.c:843
invalid operand: 0000
CPU: 0
EIP: 0010:[<e012420a>] Not tainted
EFLAGS: 00010246
eax: 00000000 ebx: c11b388   ecx: 00000017 edx: c02f60f4
esi: c1580948  edi: cc5b6dc0  ebp: df0e9d40  esp: c4841e4c
ds: 0018 es:0018 ss: 0018
Stack: ca0bce00 c11b9388 c01f41cd d4f6d6e0 00000246 00000001 ca0bce00
00000000
             c11b9388 c01f4209 ca0bce00 00000001 00000001 c024ebae
ca0bce00 00000001
             d4f6d6e0 db7077a0 00000001 dfe6ae00 c034ecd0 d4f6d6e0
00000001 dfe6aeb8
Call Trace:  [<c01f41cd>] [<c01f4209>] [<c024ebae>] [<c024ecd0>]
[<c023b738>]
[<c023ba96>] [<c0240c58>] [<c024529b>] [<c023ad86>] [<c0243d91>]
[<c010996d>]
[<c0109ad7>] [<c010bd08>]
code: 0f 0b 4b 03 00cb 2a c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



ksymoops 0.7c on i686 2.4.18-xfs.  Options used
       -v /usr/src/linux-2.4.19-xfs/vmlinux (specified)
       -k /proc/ksyms (default)
       -l /proc/modules (default)
       -o /lib/modules/2.4.19-xfs/ (specified)
       -m /usr/src/linux/System.map (default)

Warning (compare_Version): Version mismatch.  System.map says 2.4.19,
e100 says 2.4.18.  Expect lots of address mismatches.
[skip]
invalid operand: 0000
CPU: 0
EIP: 0010:[<e012420a>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000 ebx: c11b388   ecx: 00000017 edx: c02f60f4
esi: c1580948  edi: cc5b6dc0  ebp: df0e9d40  esp: c4841e4c
ds: 0018 es:0018 ss: 0018
Stack: ca0bce00 c11b9388 c01f41cd d4f6d6e0 00000246 00000001 ca0bce00
00000000
             c11b9388 c01f4209 ca0bce00 00000001 00000001 c024ebae
ca0bce00 00000001
             d4f6d6e0 db7077a0 00000001 dfe6ae00 c034ecd0 d4f6d6e0
00000001 dfe6aeb8
Call Trace:  [<c01f41cd>] [<c01f4209>] [<c024ebae>] [<c024ecd0>]
[<c023b738>]
[<c023ba96>] [<c0240c58>] [<c024529b>] [<c023ad86>] [<c0243d91>]
[<c010996d>]
[<c0109ad7>] [<c010bd08>]
code: 0f 0b 4b 03 00cb 2a c0 8d 46 04 39 46 04 74 0e 31 c9 ba 03


  >>EIP; e012420a <_end+1fda3506/205d735c>   <=====

Trace; c01f41cd <_end_pagebuf_page_io_multi+e5/110>
Trace; c01f4209 <_end_io_multi_full+11/18>
Trace; c024ebae <raid1_end_bh_io+82/118>
Trace; c024ecd0 <raid1_end_request+8c/94>
Trace; c023b738 <__scsi_end_request+74/130>
Trace; c023ba96 <scsi_io_completion+196/3ac>
Trace; c0240c58 <ncr_complete+5a0/5b8>
Trace; c024529b <rw_intr+19b/1a4>
Trace; c023ad86 <scsi_old_done+5da/5ec>
Trace; c0243d91 <ncr53c8xx_intr+69/7c>
Trace; c010996d <handle_IRQ_event+31/5c>
Trace; c0109ad7 <do_IRQ+6b/a8>
Trace; c010bd08 <call_do_IRQ+5/d>
Code;  e012420a <_end+1fda3506/205d735c>
00000000 <_EIP>:
Code;  e012420a <_end+1fda3506/205d735c>   <=====
     0:   0f 0b                     ud2a      <=====
Code;  e012420c <_end+1fda3508/205d735c>
     2:   4b                        dec    %ebx
Code;  e012420d <_end+1fda3509/205d735c>
     3:   03 cb                     add    %ebx,%ecx
Code;  e012420f <_end+1fda350b/205d735c>
     5:   00 2a                     add    %ch,(%edx)
Code;  e0124211 <_end+1fda350d/205d735c>
     7:   c0 8d 46 04 39 46 04      rorb   $0x4,0x46390446(%ebp)
Code;  e0124218 <_end+1fda3514/205d735c>
     e:   74 0e                     je     1e <_EIP+0x1e> e0124228
<_end+1fda3524/205d735c>
Code;  e012421a <_end+1fda3516/205d735c>
    10:   31 c9                     xor    %ecx,%ecx
Code;  e012421c <_end+1fda3518/205d735c>
    12:   ba 03 00 00 00            mov    $0x3,%edx

<0>Kernel panic: Aiee, killing interrupt handler!

1167 warnings issued.  Results may not be reliable.




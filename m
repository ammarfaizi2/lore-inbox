Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTIZStq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTIZStq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:49:46 -0400
Received: from ariel.onewest.net ([199.104.81.67]:34511 "EHLO
	ariel.onewest.net") by vger.kernel.org with ESMTP id S261588AbTIZStn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:49:43 -0400
From: "Eric Balsa" <eric@onewest.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5-mm4 Oops
Date: Fri, 26 Sep 2003 12:49:43 -0600
Message-ID: <001701c3845e$f3e4b470$fad11341@corporate.onewest.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I am seeing a kernel oops when booting 2.6.0-test5-mm4. Below is the oops.
Looks like it is from the ACARD driver, since when I disable it in the
kernel, the oops no longer happens. This is a dual Xeon 866 (Dell Poweredge
4400) with an SMP kernel. I hope the ksymoops is useful.

Regards,
--Eric

Preempt SMP
CPU: 0
EIP: 0060:[<02293d33>] Not tainted VLI
EFLAGS: 00010202
EIP is at atp870u_detect+0x18b/0x9c8
eax: 00000000 ebx: 023e8cd4 ecx: 41fa5f7c edx: 000006f2
esi: 00000000 edi: 00000000 ebp: 0000000e esp: 41fa5c08
ds: 007b es: 007b ss:0068
Process Swapper (pid: 1,threadinfo=41fa4000 task=03a57900)
Stack: 023e8cd4 023e8c60 00000000 00000000 00000001 00000100 00000005
41fa5f7c
55789004 00000002 00000001 00000100 00000006 00060020 21789004 00000003
00804001 00000101 00000007 00060020 08389004 00000000 00804001 41fa5cb2

Call Trace:
[<0243a1bb>] init_this_scsi_driver+0x4b/0xe0
[<0242280d>] do_initcalls+0x3d/0x8c
[<02422875>] do_basic_setup+0x19/0x24
[<021070ef>] init+0x5b/0x15c
[<02107094>] init+0x0/0x15c
[<0210a991>] kernel_thread_helper+0x5/0xc

Code: 60 8d 8c 24 aa 00 00 00 89 4c 24 5c 8b 4c 24 1c 0f b6 44 24 72 8d 3c
85 0000 00 00 8b 14 0f 89 44 24 54 85 d2 0f 84 4d 08 00 00 <8b> aa fc 00 00
00 8b 74 24 54 8a 9a f4 00 00 00 01 f6 66 81 bc
<0> Kernel Panic: Attempted to kill init!

Output from ksymoops:
ksymoops 2.4.5 on i686 2.6.0-test5-mm4.  Options used
     -v /root/linux-2.6.0-mm4 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5-mm4/ (default)
     -m ./System.map (specified)

Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is
/root/linux-2.6.0-mm4 a valid vmlinux file?
Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU: 0
EIP: 0060:[<02293d33>] Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000 ebx: 023e8cd4 ecx: 41fa5f7c edx: 000006f2
esi: 00000000 edi: 00000000 ebp: 0000000e esp: 41fa5c08
ds: 007b es: 007b ss:0068
Stack: 023e8cd4 023e8c60 00000000 00000000 00000001 00000100 00000005
41fa5f7c
55789004 00000002 00000001 00000100 00000006 00060020 21789004 00000003
00804001 00000101 00000007 00060020 08389004 00000000 00804001 41fa5cb2
[<0243a1bb>] init_this_scsi_driver+0x4b/0xe0
[<0242280d>] do_initcalls+0x3d/0x8c
[<02422875>] do_basic_setup+0x19/0x24
[<021070ef>] init+0x5b/0x15c
[<02107094>] init+0x0/0x15c
[<0210a991>] kernel_thread_helper+0x5/0xc
Code: 60 8d 8c 24 aa 00 00 00 89 4c 24 5c 8b 4c 24 1c 0f b6 44 24 72 8d 3c
85 0000 00 00 8b 14 0f 89 44 24 54 85 d2 0f 84 4d 08 00 00 <8b> aa fc 00 00
00 8b 74 24 54 8a 9a f4 00 00 00 01 f6 66 81 bc


>>EIP; 02293d33 <atp870u_detect+18b/9e8>   <=====

>>ebx; 023e8cd4 <driver_template+74/80>
>>ecx; 41fa5f7c <_end+3fb1f514/fdb64598>
>>edx; 000006f2 Before first symbol
>>esp; 41fa5c08 <_end+3fb1f1a0/fdb64598>

Code;  02293d08 <atp870u_detect+160/9e8>
00000000 <_EIP>:
Code;  02293d08 <atp870u_detect+160/9e8>
   0:   60                        pusha
Code;  02293d09 <atp870u_detect+161/9e8>
   1:   8d 8c 24 aa 00 00 00      lea    0xaa(%esp,1),%ecx
Code;  02293d10 <atp870u_detect+168/9e8>
   8:   89 4c 24 5c               mov    %ecx,0x5c(%esp,1)
Code;  02293d14 <atp870u_detect+16c/9e8>
   c:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  02293d18 <atp870u_detect+170/9e8>
  10:   0f b6 44 24 72            movzbl 0x72(%esp,1),%eax
Code;  02293d1d <atp870u_detect+175/9e8>
  15:   8d 3c 85 00 00 00 00      lea    0x0(,%eax,4),%edi
Code;  02293d24 <atp870u_detect+17c/9e8>
  1c:   8b 14 0f                  mov    (%edi,%ecx,1),%edx
Code;  02293d27 <atp870u_detect+17f/9e8>
  1f:   89 44 24 54               mov    %eax,0x54(%esp,1)
Code;  02293d2b <atp870u_detect+183/9e8>
  23:   85 d2                     test   %edx,%edx
Code;  02293d2d <atp870u_detect+185/9e8>
  25:   0f 84 4d 08 00 00         je     878 <_EIP+0x878> 02294580
<atp870u_detect+9d8/9e8>
Code;  02293d33 <atp870u_detect+18b/9e8>   <=====
  2b:   8b aa fc 00 00 00         mov    0xfc(%edx),%ebp   <=====
Code;  02293d39 <atp870u_detect+191/9e8>
  31:   8b 74 24 54               mov    0x54(%esp,1),%esi
Code;  02293d3d <atp870u_detect+195/9e8>
  35:   8a 9a f4 00 00 00         mov    0xf4(%edx),%bl
Code;  02293d43 <atp870u_detect+19b/9e8>
  3b:   01 f6                     add    %esi,%esi
Code;  02293d45 <atp870u_detect+19d/9e8>
  3d:   66                        data16
Code;  02293d46 <atp870u_detect+19e/9e8>
  3e:   81                        .byte 0x81
Code;  02293d47 <atp870u_detect+19f/9e8>
  3f:   bc                        .byte 0xbc

<0> Kernel Panic: Attempted to kill init!

1 warning and 2 errors issued.  Results may not be reliable.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbTKXRXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTKXRXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:23:17 -0500
Received: from mailhub2.ittralee.ie ([193.1.176.5]:13976 "EHLO
	mailhub2.ittralee.ie") by vger.kernel.org with ESMTP
	id S263794AbTKXRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:23:10 -0500
Message-ID: <36429.10.9.12.1.1069694580.squirrel@10.9.12.1>
Date: Mon, 24 Nov 2003 17:23:00 -0000 (GMT)
Subject: reboot 2.4.22 : kernel BUG at sched.c:564
From: "Ronan Salmon" <Ronan.Salmon@staff.ittralee.ie>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3 [CVS]
X-Mailer: SquirrelMail/1.4.3 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

- redhat 9.0 i386
- mpeg4ip-1.0rc3
- kernel 2.4.22 from kernel.org

I don't have any problem with the kernel 2.4.20 from redhat 9, but with
kernel 2.4.22 from kernel.org, I get a kernel panic when I run the command
'reboot'. It seems to crash when it is running the KILLALL script.

When the PC boots up, it runs just X and then mp4player which plays a live
stream from our local network (broadcast).

here is the output of ksymoops :
[~]# ksymoops -v /usr/src/linux/vmlinux -m /usr/src/linux/System.map
error.log
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol
sk_chk_filter_R__ver_sk_chk_filter not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
sk_run_filter_R__ver_sk_run_filter not found in vmlinux.  Ignoring
ksyms_base entry
kernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01164d1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000018   ebx: cfe3d4a0   ecx: 00000001   edx: c029ef3c
esi: cbf84000   edi: cbf84000   ebp: cbf85ed4   esp: cbf85eac
ds: 0018   es: 0018   ss: 0018
Process mp4player (pid: 1260, stackpage=cbf85000)
Stack: c0264aea cbf84000 c12cc000 c011c1ab cbf84000 00000000 cbf84000
cfe3d4a0
       cff72200 cbf84000 00000009 c011c5ea cbf84000 cfe3d4a0 cbf84000
00000000
       cbf85f30 00000009 c0121f3c 00000009 c0122125 00000009 cc9fc644
00000009
Call Trace:    [<c011c1ab>] [<c011c5ea>] [<c0121f3c>] [<c0122125>]
[<c010714e>]
  [<c0148143>] [<c0147466>] [<c0148506>] [<c0107448>]
Code: 0f 0b 34 02 e2 4a 26 c0 e9 09 fd ff ff 0f 0b 2d 02 e2 4a 26


>>EIP; c01164d1 <schedule+331/350>   <=====

>>ebx; cfe3d4a0 <_end+fb10adc/104f569c>
>>edx; c029ef3c <log_wait+0/8>
>>esi; cbf84000 <_end+bc5763c/104f569c>
>>edi; cbf84000 <_end+bc5763c/104f569c>
>>ebp; cbf85ed4 <_end+bc59510/104f569c>
>>esp; cbf85eac <_end+bc594e8/104f569c>

Trace; c011c1ab <exit_notify+cb/300>
Trace; c011c5ea <do_exit+20a/230>
Trace; c0121f3c <sig_exit+ac/b0>
Trace; c0122125 <dequeue_signal+65/d0>
Trace; c010714e <do_signal+1ae/2a0>
Trace; c0148143 <do_select+133/230>
Trace; c0147466 <vfs_readdir+a6/b0>
Trace; c0148506 <sys_select+296/4e0>
Trace; c0107448 <signal_return+14/18>

Code;  c01164d1 <schedule+331/350>
00000000 <_EIP>:
Code;  c01164d1 <schedule+331/350>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01164d3 <schedule+333/350>
   2:   34 02                     xor    $0x2,%al
Code;  c01164d5 <schedule+335/350>
   4:   e2 4a                     loop   50 <_EIP+0x50>
Code;  c01164d7 <schedule+337/350>
   6:   26                        es
Code;  c01164d8 <schedule+338/350>
   7:   c0 e9 09                  shr    $0x9,%cl
Code;  c01164db <schedule+33b/350>
   a:   fd                        std
Code;  c01164dc <schedule+33c/350>
   b:   ff                        (bad)
Code;  c01164dd <schedule+33d/350>
   c:   ff 0f                     decl   (%edi)
Code;  c01164df <schedule+33f/350>
   e:   0b 2d 02 e2 4a 26         or     0x264ae202,%ebp

 <0>Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.



-----------------------------------------
This email is subject to the following disclaimer(s) available at http://www.ittralee.ie/EmailDisclaimer.html

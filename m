Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTEPLRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 07:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTEPLRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 07:17:52 -0400
Received: from mars.mj.nl ([81.91.1.49]:64175 "HELO mars.mj.nl")
	by vger.kernel.org with SMTP id S264412AbTEPLRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 07:17:50 -0400
Subject: Aironet driver still causing oopsen
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053079397.3337.119.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 May 2003 12:03:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.21-pre5 but my airo.c is from 
airo-linux.sourceforge.net CVS on on 5 May 2003.
Today my kernel oopsed in the familiar way:

jdthood@thanatos:/tmp$ ksymoops oopsfile
ksymoops 2.4.8 on i686 2.4.21-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre5/ (default)
     -m /boot/System.map-2.4.21-pre5 (default)
 
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
 
May 16 10:04:58 thanatos kernel: Warning: kfree_skb passed an skb still
on a list (from d89493ba).
May 16 10:04:58 thanatos kernel: kernel BUG at skbuff.c:315!
May 16 10:04:58 thanatos kernel: invalid operand: 0000
May 16 10:04:58 thanatos kernel: CPU:    0
May 16 10:04:59 thanatos kernel: EIP:    0010:[__kfree_skb+27/300]   
Tainted: PF
May 16 10:04:59 thanatos kernel: EFLAGS: 00013282
May 16 10:04:59 thanatos kernel: eax: 00000045   ebx: 00003246   ecx:
d715e000   edx: 00000001
May 16 10:04:59 thanatos kernel: esi: d08582b8   edi: d08581c4   ebp:
d0858000   esp: c143ff64
May 16 10:04:59 thanatos kernel: ds: 0018   es: 0018   ss: 0018
May 16 10:04:59 thanatos kernel: Process keventd (pid: 2,
stackpage=c143f000)
May 16 10:04:59 thanatos kernel: Stack: c01f6aa0 d89493ba 00003246
d08581c4 d89493ba ce5e7400 c143ffa4
c143ffa4
May 16 10:04:59 thanatos kernel:        c143ffe0 c143e000 00000002
ce5e7400 c011b0ac d0858000 c143e564
ffffffff
May 16 10:04:59 thanatos kernel:        d0858300 d0858300 c0122757
c020d594 00000700 d7fcdfc4 c024e47c
0008e000
May 16 10:04:59 thanatos kernel: Call Trace:    [<d89493ba>]
[<d89493ba>] [__run_task_queue+80/92] [context_thread+283/416]
[kernel_thread+40/56]
May 16 10:04:59 thanatos kernel: Code: 0f 0b 3b 01 00 6a 1f c0 83 c4 08
8b 44 24 0c 8b 40 28 85 c0
Using defaults from ksymoops -t elf32-i386 -a i386
 
 
>>ecx; d715e000 <_end+16ee5c88/185c9ce8>
>>esi; d08582b8 <_end+105dff40/185c9ce8>
>>edi; d08581c4 <_end+105dfe4c/185c9ce8>
>>ebp; d0858000 <_end+105dfc88/185c9ce8>
>>esp; c143ff64 <_end+11c7bec/185c9ce8>
 
Trace; d89493ba <[airo]airo_do_xmit+13a/144>
Trace; d89493ba <[airo]airo_do_xmit+13a/144>
 
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   3b 01                     cmp    (%ecx),%eax
Code;  00000004 Before first symbol
   4:   00 6a 1f                  add    %ch,0x1f(%edx)
Code;  00000007 Before first symbol
   7:   c0 83 c4 08 8b 44 24      rolb   $0x24,0x448b08c4(%ebx)
Code;  0000000e Before first symbol
   e:   0c 8b                     or     $0x8b,%al
Code;  00000010 Before first symbol
  10:   40                        inc    %eax
Code;  00000011 Before first symbol
  11:   28 85 c0 00 00 00         sub    %al,0xc0(%ebp)
 
 
1 warning issued.  Results may not be reliable.

-- 
Thomas Hood <jdthood@yahoo.co.uk>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSGUNOi>; Sun, 21 Jul 2002 09:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGUNOi>; Sun, 21 Jul 2002 09:14:38 -0400
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:59618
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S315414AbSGUNOf>; Sun, 21 Jul 2002 09:14:35 -0400
Subject: Oops with 2.5.27 (swapper)
From: Christian Thalinger <twisti@complang.tuwien.ac.at>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jul 2002 15:12:55 +0200
Message-Id: <1027257175.612.3.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday i've tried 2.5.27 and got this oops during boot (oops written
down by hand):

[root@sector17:/root]# ksymoops -V -K -L -o /lib/modules/2.5.27/ -m
/boot/System.map-2.5.27 < oops-2.5.27.txt
ksymoops 2.4.3 on i686 2.4.19-rc3.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.27/ (specified)
     -m /boot/System.map-2.5.27 (specified)

No modules in ksyms, skipping objects
Oops: 0002
CPU:    0
EIP:    0010:[<c01b6246>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 00000000   ebx: c1565000   ecx: 00000400   edx: 00000000
esi: c156500c   edi: 00000001   ebp: c1565000   esp: dffc3ec4
ds: 0018   es: 0018   ss: 0018
Stack: dfdf3bc0 c156500c c1565000 c1565000 c0223d60 00000000 00000000
00000000
       00000000 00000000 00000000 00000000 dfdf680c 00000001 c01b64fc
c1565000
       dfdf3bc0 c156500c c156500c c1565000 00000064 c1565000 c01b7194
c1565000
Call Trace: [<c01b64fc>] [<c01b7194>] [<c011549c>] [<c01199e6>]
[<c0119893>]
   [<c01b74bc>] [<c01b772c>] [<c01ba1c3>] [<c010508b>] [<c0105728>]
Code: f3 ab 8b 44 24 34 c7 00 fc 4e 2b a9 8b 43 1c 8b 54 24 34 89

>>EIP; c01b6246 <sync_sbs+76/2d0>   <=====
Trace; c01b64fc <md_update_sb+5c/190>
Trace; c01b7194 <do_md_run+284/2e0>
Trace; c011549c <__wake_up+2c/50>
Trace; c01199e6 <release_console_sem+d6/e0>
Trace; c0119892 <printk+142/170>
Trace; c01b74bc <autorun_array+9c/d0>
Trace; c01b772c <autorun_devices+23c/2b0>
Trace; c01ba1c2 <autostart_arrays+c2/c6>
Trace; c010508a <init+2a/190>
Trace; c0105728 <kernel_thread+28/40>
Code;  c01b6246 <sync_sbs+76/2d0>
00000000 <_EIP>:
Code;  c01b6246 <sync_sbs+76/2d0>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c01b6248 <sync_sbs+78/2d0>
   2:   8b 44 24 34               mov    0x34(%esp,1),%eax
Code;  c01b624c <sync_sbs+7c/2d0>
   6:   c7 00 fc 4e 2b a9         movl   $0xa92b4efc,(%eax)
Code;  c01b6252 <sync_sbs+82/2d0>
   c:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  c01b6254 <sync_sbs+84/2d0>
   f:   8b 54 24 34               mov    0x34(%esp,1),%edx
Code;  c01b6258 <sync_sbs+88/2d0>
  13:   89 00                     mov    %eax,(%eax)


I have a raid5 with 3 drives and compiled it with 3.1 and 2.95.3, same
problem. 2.5.26 did boot up.

Regards.

TWISTI


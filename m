Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSKMVKx>; Wed, 13 Nov 2002 16:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKMVKG>; Wed, 13 Nov 2002 16:10:06 -0500
Received: from 205-158-62-133.outblaze.com ([205.158.62.133]:7117 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264614AbSKMVIw>; Wed, 13 Nov 2002 16:08:52 -0500
Message-ID: <20021113211539.21064.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2002 05:15:39 +0800
Subject: oops with 2.5.47-mm2
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
X-Habeas-Swe-1: winter into spring
X-Habeas-Swe-2: brightly anticipated
X-Habeas-Swe-3: like Habeas SWE (tm)
X-Habeas-Swe-4: Copyright 2002 Habeas (tm)
X-Habeas-Swe-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-Swe-6: email in exchange for a license for this Habeas
X-Habeas-Swe-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-Swe-8: Message (HCM) and not spam. Please report use of this
X-Habeas-Swe-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I can reproduce an oops simply running fillmem 400

kernel is 2.5.47-mm2
fs is ext3.

ksymoops 2.3.7 on i686 2.5.47-mm2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47-mm2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 0ebbb04f
 c012e137
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0060:[<c012e137>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010206
 eax: ce720e58   ebx: 00131000   ecx: 0ebbb047   edx: 00131000
 esi: ce720e58   edi: c13d4000   ebp: c12782b0   esp: c13d5d08
 ds: 0068   es: 0068   ss: 0068
 Stack: 00000000 00131000 c013dfb2 ce720e58 00131000 00131000 c013e00a ce720e58
        00131000 00131000 c12782b0 c013e14a c121e508 00131000 cfd1d744 c121e508
               cfd1d984 cd8ed4c4 c0147ef7 c1245040 ce841314 cfd0dd80 c12782b0 c12782b0
               Call Trace: [<c013dfb2>]  [<c013e00a>]  [<c013e14a>]  [<c0147ef7>]  [<c013e2a2>]  [<c0135e40>]  [<c0135685>]  [<c0136851>]  [<c01362a3>]  [<c013694f>]  [<c0136bb9>]  [<c0136d5e>]  [<c0118f20>]  [<c011737b>]  [<c0118f20>]  [<c0136c40>]  [<c0108b01>]
               Code: 39 59 08 76 05 39 59 04 76 2c 8b 56 04 31 c9 eb 0b 8b 52 0c

>>EIP; c012e137 <get_fs_type+7/30>   <=====
Trace; c013dfb2 <copy_tree+52/d0>
Trace; c013e00a <copy_tree+aa/d0>
Trace; c013e14a <do_loopback+1a/150>
Trace; c0147ef7 <tty_ioctl+197/350>
Trace; c013e2a2 <do_remount+22/b0>
Trace; c0135e40 <send_sigio+40/a0>
Trace; c0135685 <.text.lock.namei+1c6/221>
Trace; c0136851 <filldir+d1/e0>
Trace; c01362a3 <sys_ioctl+123/190>
Trace; c013694f <filldir64+4f/140>
Trace; c0136bb9 <__pollwait+19/90>
Trace; c0136d5e <do_select+4e/240>
Trace; c0118f20 <sys_setfsuid+90/c0>
Trace; c011737b <sys_rt_sigprocmask+7b/1d0>
Trace; c0118f20 <sys_setfsuid+90/c0>
Trace; c0136c40 <max_select_fd+10/e0>
Trace; c0108b01 <show_stack+11/80>
Code;  c012e137 <get_fs_type+7/30>
00000000 <_EIP>:
Code;  c012e137 <get_fs_type+7/30>   <=====
   0:   39 59 08                  cmp    %ebx,0x8(%ecx)   <=====
Code;  c012e13a <get_fs_type+a/30>
   3:   76 05                     jbe    a <_EIP+0xa> c012e141 <get_fs_type+11/30>
Code;  c012e13c <get_fs_type+c/30>
   5:   39 59 04                  cmp    %ebx,0x4(%ecx)
Code;  c012e13f <get_fs_type+f/30>
   8:   76 2c                     jbe    36 <_EIP+0x36> c012e16d <alloc_super+d/170>
Code;  c012e141 <get_fs_type+11/30>
   a:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c012e144 <get_fs_type+14/30>
   d:   31 c9                     xor    %ecx,%ecx
Code;  c012e146 <get_fs_type+16/30>
   f:   eb 0b                     jmp    1c <_EIP+0x1c> c012e153 <get_fs_type+23/30>
Code;  c012e148 <get_fs_type+18/30>
  11:   8b 52 0c                  mov    0xc(%edx),%edx


1 warning and 1 error issued.  Results may not be reliable.

Let me know is you need further information.

Ciao,
        Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze

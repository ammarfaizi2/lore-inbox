Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRLLRDo>; Wed, 12 Dec 2001 12:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRLLRDf>; Wed, 12 Dec 2001 12:03:35 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:26631 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S281214AbRLLRDY>; Wed, 12 Dec 2001 12:03:24 -0500
Date: Wed, 12 Dec 2001 17:09:21 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] LVM and (I think) devfs
Message-ID: <20011212170921.A25596@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just started playing with LVM, (with devfs), and I've found I can reproduce
the attached oops consistently doing the following:

# vgchange -a y
# vgchange -a n
# vgchange -a y

Once this happens, the lvm becomes unreponsive and requires a reboot to
activate it again.

It looks like the oops happens in devfs_open().

I'm using 2.4.17-pre8 with LVM 1.0.1, and the kernel driver from that package.

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-devfs-oops

ksymoops 2.4.3 on i686 2.4.17-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre8/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0181226>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: f7e63320   ecx: f79f29a0   edx: c02b1788
esi: f7b22060   edi: f7e63328   ebp: f79f29a0   esp: f7981f40
ds: 0018   es: 0018   ss: 0018
Process vgchange (pid: 137, stackpage=f7981000)
Stack: f79f29a0 f7b22060 ffffffe9 c200eea0 c02a1f20 c0133159 f7b22060 f79f29a0
       40052500 f79bb000 00000000 bffff91c c013306e f7b24920 c200eea0 00000000
       00000004 f79bb000 bffffa6c f7b24920 c200eea0 bffffa6c bffff91c 00000000
Call Trace: [<c0133159>] [<c013306e>] [<c01333be>] [<c0106d7b>]
Code: 89 50 18 eb 2b 90 8d 74 26 00 8b 43 08 85 c0 74 1a 8b 00 85

>>EIP; c0181226 <devfs_open+76/168>   <=====
Trace; c0133158 <dentry_open+e0/188>
Trace; c013306e <filp_open+52/5c>
Trace; c01333be <sys_open+36/cc>
Trace; c0106d7a <system_call+32/38>
Code;  c0181226 <devfs_open+76/168>
0000000000000000 <_EIP>:
Code;  c0181226 <devfs_open+76/168>   <=====
   0:   89 50 18                  mov    %edx,0x18(%eax)   <=====
Code;  c0181228 <devfs_open+78/168>
   3:   eb 2b                     jmp    30 <_EIP+0x30> c0181256 <devfs_open+a6/168>
Code;  c018122a <devfs_open+7a/168>
   5:   90                        nop    
Code;  c018122c <devfs_open+7c/168>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0181230 <devfs_open+80/168>
   a:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0181232 <devfs_open+82/168>
   d:   85 c0                     test   %eax,%eax
Code;  c0181234 <devfs_open+84/168>
   f:   74 1a                     je     2b <_EIP+0x2b> c0181250 <devfs_open+a0/168>
Code;  c0181236 <devfs_open+86/168>
  11:   8b 00                     mov    (%eax),%eax
Code;  c0181238 <devfs_open+88/168>
  13:   85 00                     test   %eax,(%eax)


1 warning issued.  Results may not be reliable.

--SUOF0GtieIMvvwua--

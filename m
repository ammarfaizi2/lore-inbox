Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSCQLBT>; Sun, 17 Mar 2002 06:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSCQLBK>; Sun, 17 Mar 2002 06:01:10 -0500
Received: from mail.crol.net ([213.191.143.189]:18048 "EHLO crolvax.crol.net")
	by vger.kernel.org with ESMTP id <S289025AbSCQLBA>;
	Sun, 17 Mar 2002 06:01:00 -0500
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 - strange Oops (Bug report)
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: CRoL d.o.o.
X-Operating-System: GNU/Linux 2.4.18
From: Miroslav Zubcic <mvz@crol.net>
Date: 17 Mar 2002 12:00:49 +0100
Message-ID: <lzwuwb4fxa.fsf@crolvax.crol.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night my workstation crashed. There was no heavy load and machine
was locked with xscreensaver.

4 seconds before that, logrotate was rotating logs, and after that
smbd(8) and nmbd(8) get couple of _strange_ SIGHUP's. There was no
mounted smbfs volumes, I'm using NFS.

This box is on Linux 1 and half years without problems, there was no
hardware upgrades in the last 5 months, and before 2.4.18 there was
2.4.14, 2.4.13.

System main components: (nothing special or weird ...)

PIII 500Mhz (Katmai)
256 RAM
IBM IDE disk 40MB
Riva TNT card

When I come in the morning machine was dead, no response. I have found this in
logs: (ksymoops output):

---------------------------------------------------------------------------------
(root){crolvax}[mqueue]# ksymoops -v /usr/src/linux/vmlinux /tmp/oops
ksymoops 2.4.1 on i686 2.4.18.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Mar 17 04:02:26 crolvax kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000080
Mar 17 04:02:26 crolvax kernel: c0113504
Mar 17 04:02:26 crolvax kernel: *pde = 00000000
Mar 17 04:02:26 crolvax kernel: Oops: 0000
Mar 17 04:02:26 crolvax kernel: CPU:    0
Mar 17 04:02:26 crolvax kernel: EIP:    0010:[__wake_up+36/176]    Not tainted
Mar 17 04:02:26 crolvax kernel: EIP:    0010:[<c0113504>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 17 04:02:26 crolvax kernel: EFLAGS: 00010082
Mar 17 04:02:26 crolvax kernel: eax: cabc84e0   ebx: 00000080   ecx: 00000001   edx: 00000001
Mar 17 04:02:26 crolvax kernel: esi: ccfbfda0   edi: 00000001   ebp: cc789f44   esp: cc789f2c
Mar 17 04:02:26 crolvax kernel: ds: 0018   es: 0018   ss: 0018
Mar 17 04:02:26 crolvax kernel: Process uniq (pid: 23189, stackpage=cc789000)
Mar 17 04:02:26 crolvax kernel: Stack: 00000282 00000001 cabc84e0 cabc84e0 ccfbfda0 ccfbfda0 ca0e2520 c0139121 
Mar 17 04:02:26 crolvax kernel:        c9e2f8a0 c1405260 c013914e ccfbfda0 00000001 00000000 c0131d5d ccfbfda0 
Mar 17 04:02:26 crolvax kernel:        c9e2f8a0 c9e2f8a0 ffffffea 00001000 00000000 c9e2f8a0 00000000 00000000 
Mar 17 04:02:26 crolvax kernel: Call Trace: [pipe_release+113/144] [pipe_read_release+14/32] [fput+77/208] [filp_close+83/96] [sys_close+67/80] 
Mar 17 04:02:26 crolvax kernel: Call Trace: [<c0139121>] [<c013914e>] [<c0131d5d>] [<c0130ce3>] [<c0130d33>] 
Mar 17 04:02:26 crolvax kernel:    [<c0106cfb>] 
Mar 17 04:02:26 crolvax kernel: Code: 8b 13 0f 18 02 eb 6b 90 8d 74 26 00 8b 4b fc 8b 01 85 45 ec 

>>EIP; c0113504 <__wake_up+24/b0>   <=====
Trace; c0139121 <pipe_release+71/90>
Trace; c013914e <pipe_read_release+e/20>
Trace; c0131d5d <fput+4d/d0>
Trace; c0130ce3 <filp_close+53/60>
Trace; c0130d33 <sys_close+43/50>
Trace; c0106cfb <system_call+33/38>
Code;  c0113504 <__wake_up+24/b0>
00000000 <_EIP>:
Code;  c0113504 <__wake_up+24/b0>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c0113506 <__wake_up+26/b0>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0113509 <__wake_up+29/b0>
   5:   eb 6b                     jmp    72 <_EIP+0x72> c0113576 <__wake_up+96/b0>
Code;  c011350b <__wake_up+2b/b0>
   7:   90                        nop    
Code;  c011350c <__wake_up+2c/b0>
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0113510 <__wake_up+30/b0>
   c:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0113513 <__wake_up+33/b0>
   f:   8b 01                     mov    (%ecx),%eax
Code;  c0113515 <__wake_up+35/b0>
  11:   85 45 ec                  test   %eax,0xffffffec(%ebp)
---------------------------------------------------------------------------------

Hope this helps ...

-- 
This signature intentionally left blank


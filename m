Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbQKNUsL>; Tue, 14 Nov 2000 15:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQKNUrv>; Tue, 14 Nov 2000 15:47:51 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:30224 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130682AbQKNUrk>; Tue, 14 Nov 2000 15:47:40 -0500
Date: Tue, 14 Nov 2000 21:17:10 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.0-t9: Oops in ipcperms
Message-ID: <20001114211709.A19282@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

running XFree86-3.3.6 on a TNT2 graphics card for many days, I got a kernel
Oops. I just had started a ssh -X forwarded X11 client on another machine.
X of course got killed, which left the VGA card in an unuseable state.

ksymoops 0.7c on i686 2.4.0-test9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test9/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
[...]

Unable to handle kernel paging request at virtual address 5ad05b04
printing eip: c01931eb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01931eb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013286
eax: 00000000   ebx: 00009001   ecx: 000001b6   edx: 00000036
esi: 000001b6   edi: 5ad05af0   ebp: 00000002   esp: ce1c3f4c
                     ^^^^^^^^
ds: 0018   es: 0018   ss: 0018
Process X (pid: 32383, stackpage=ce1c3000)
Stack: 00009001 00000000 00000000 c0197845 5ad05af0 000001b6 00009001 00000000
       00000000 bffff868 00000003 00000001 00001cb4 00000000 00000000 ce1c3f78
       c010eded 00009001 00000000 00000000 ce1c3fb4 ce1c2000 bffff868 00000000
Call Trace: [<c0197845>] [<c010eded>] [<c010a657>]
Code: 0f b7 5f 14 3b 47 0c 74 05 3b 47 04 75 07 c1 fb 06 eb 25 89

>>EIP; c01931eb <ipcperms+2b/90>   <=====
Trace; c0197845 <sys_shmat+d1/25c>
Trace; c010eded <sys_ipc+159/1fc>
Trace; c010a657 <system_call+33/38>
Code;  c01931eb <ipcperms+2b/90>
00000000 <_EIP>:
Code;  c01931eb <ipcperms+2b/90>   <=====
   0:   0f b7 5f 14               movzwl 0x14(%edi),%ebx   <=====
Code;  c01931ef <ipcperms+2f/90>
   4:   3b 47 0c                  cmp    0xc(%edi),%eax
Code;  c01931f2 <ipcperms+32/90>
   7:   74 05                     je     e <_EIP+0xe> c01931f9 <ipcperms+39/90>
Code;  c01931f4 <ipcperms+34/90>
   9:   3b 47 04                  cmp    0x4(%edi),%eax
Code;  c01931f7 <ipcperms+37/90>
   c:   75 07                     jne    15 <_EIP+0x15> c0193200 <ipcperms+40/90>
Code;  c01931f9 <ipcperms+39/90>
   e:   c1 fb 06                  sar    $0x6,%ebx
Code;  c01931fc <ipcperms+3c/90>
  11:   eb 25                     jmp    38 <_EIP+0x38> c0193223 <ipcperms+63/90>
Code;  c01931fe <ipcperms+3e/90>
  13:   89 00                     mov    %eax,(%eax)

1 warning issued.  Results may not be reliable.

Apparently, the ipcp passed by sys_shmat() to ipcperms() was invalid.

Any ideas?

Regards,
-- 
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

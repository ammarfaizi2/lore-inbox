Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293189AbSCFPfu>; Wed, 6 Mar 2002 10:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCFPfj>; Wed, 6 Mar 2002 10:35:39 -0500
Received: from zamok.crans.org ([138.231.136.6]:55771 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S293189AbSCFPfe>;
	Wed, 6 Mar 2002 10:35:34 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
Organization: Kabale Inc
Date: Wed, 06 Mar 2002 16:35:29 +0100
Message-ID: <m3pu2hn1z2.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I encounter problems with xmms segfaulting on two different
kernels. The first one is 2.4.18-xfs-preempt-lockbreak-bttv. I use
alsa drivers (0.90.0b12) for my SB PCI 128 card. The second one is
2.4.19-pre2-ac2 with shawn patch (xfs + rmap 12g) and preempt patch.

Here are the oops for the 2.4.18 :

ksymoops 2.4.4 on i686 2.4.18-xfs-preempt-lock-bttv.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfs-preempt-lock-bttv/ (default)
     -m /boot/System.map-2.4.18-xfs-preempt-lock-bttv (specified)

Unable to handle kernel paging request at virtual address d8d5c000
d8d56730
*pde = 17c45067
Oops: 0000
CPU:    0
EIP:    0010:[3c59x:__insmod_3c59x_S.bss_L40+828820/101914768]    Not tainted
EFLAGS: 00210202
eax: 00000001   ebx: 00000003   ecx: ffff389f   edx: fffff888
esi: fffff888   edi: d8d59fa6   ebp: d8d5bffe   esp: c445fe90
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 2679, stackpage=c445f000)
Stack: d8d56840 d8d56730 cae1c710 cae1c6f0 00000000 00000004 00000004 00000001 
       f871f871 00000c29 000003ec 00000400 cae1c680 c551b3c0 d8d56a8a cae1c680 
       c7a8b500 c7a8b480 00000400 000003ec cae1c680 00000400 cae1c680 00000400 
Call Trace: [3c59x:__insmod_3c59x_S.bss_L40+829092/101914496] [3c59x:__insmod_3c59x_S.bss_L40+828820/101914768] [3c59x:__insmod_3c59x_S.bss_L40+829678/101913910] [3c59x:__insmod_3c59x_S.bss_L40+817016/101926572] [3c59x:__insmod_3c59x_S.bss_L40+802037/101941551] 
Code: 8b 75 00 e9 87 00 00 00 8b 75 00 81 f6 00 80 00 00 eb 7c 8b 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 75 00                  mov    0x0(%ebp),%esi
Code;  00000003 Before first symbol
   3:   e9 87 00 00 00            jmp    8f <_EIP+0x8f> 0000008f Before first symbol
Code;  00000008 Before first symbol
   8:   8b 75 00                  mov    0x0(%ebp),%esi
Code;  0000000b Before first symbol
   b:   81 f6 00 80 00 00         xor    $0x8000,%esi
Code;  00000011 Before first symbol
  11:   eb 7c                     jmp    8f <_EIP+0x8f> 0000008f Before first symbol
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

I don't have any problem with the network card after the oops, however
I can't use the sound card any more (already used). xmms wasn't using
the network. I didn't do a ksymoops on the another oops but it was
located on 3c59x too.

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xb000. Vers LK1.1.16

With 2.4.17, I didn't have this problem.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRLUMrj>; Fri, 21 Dec 2001 07:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLUMrd>; Fri, 21 Dec 2001 07:47:33 -0500
Received: from mailrelay.netcologne.de ([194.8.194.96]:50372 "EHLO
	mailrelay.netcologne.de") by vger.kernel.org with ESMTP
	id <S281214AbRLUMrP>; Fri, 21 Dec 2001 07:47:15 -0500
Date: Fri, 21 Dec 2001 13:46:34 +0100
From: Wolfgang Weisselberg <eskdyswngvi1s001@sneakemail.com>
To: Karsten Keil <keil@isdn4linux.de>, kkeil@suse.de,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Kernel Oops in [free_page_and_swap_cache+50/52]
Message-ID: <20011221134634.A14357@tiger.bigcats.invalid>
Mail-Followup-To: Wolfgang Weisselberg <eskdyswngvi1s001@sneakemail.com>,
	Karsten Keil <keil@isdn4linux.de>, kkeil@suse.de,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope to have reached the correct addresses... :-/

This is a modified SuSE 7.0 box, with the 2.4.17-rc1 kernel +
the following patches:
    LVM 1.0.1                      (the L)
    linux-2.4.11-VFS-lock.patch    (the V)
    and LVM_VFS_ENHANCEMENT enabled in drivers/md/lvm.c
                                   (the X)
        (which basically allows exploiting the usage of the
         linux-2.4.11-VFS-lock.patch to mount online snapshots
         of journalled file systems.)

Current-Linux ls a softlink to the correct linux sources, set
via uname during the boot process.

The machine is a Dual-Celeron SMP machine on the ABIT BP-6
board.

jpilot is a 'palm pilot' connection program (and more), a
Handspring Visor (a palm-clone) was syncing via it's USB
connection as the oops happened.  The logfiles say that ISDN
had disconnected almost exactly a minute before the oops, so
it was offline.

The kernel keeps chugging on, luckily.

The oops: 
------------------------------------------------------------
ksymoops 2.3.4 on i686 2.4.17-rc1-LVX.  Options used
     -v /usr/src/Current-Linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1-LVX/ (default)
     -m /boot/System.map-2.4.17-rc1-LVX (default)

Dec 21 12:45:49 tiger kernel: Unable to handle kernel paging request at virtual address 000b00c5
Dec 21 12:45:49 tiger kernel: d08b3ea7
Dec 21 12:45:49 tiger kernel: *pde = 00000000
Dec 21 12:45:49 tiger kernel: Oops: 0000
Dec 21 12:45:49 tiger kernel: CPU:    0
Dec 21 12:45:49 tiger kernel: EIP:    0010:[hisax:__insmod_hisax_O/lib/modules/2.4.17-rc1-LVX/kernel/drivers/+-803161/96]    Not tainted
Dec 21 12:45:49 tiger kernel: EFLAGS: 00010206
Dec 21 12:45:49 tiger kernel: eax: 000b0005   ebx: c210989c   ecx: 00000286   edx: c4b3d36c
Dec 21 12:45:49 tiger kernel: esi: c2da9e9c   edi: c2109800   ebp: c21098fc   esp: c88a9e94
Dec 21 12:45:49 tiger kernel: ds: 0018   es: 0018   ss: 0018
Dec 21 12:45:49 tiger kernel: Process jpilot (pid: 14343, stackpage=c88a9000)
Dec 21 12:45:49 tiger kernel: Stack: d08d02f0 c4b3d36c c210989c c2109800 cdc3fc94 00000000 d08ca340 c210989c 
Dec 21 12:45:49 tiger kernel:        cdc3fc94 c3c87000 c17bb824 c158cfa0 c0187270 c3c87000 cdc3fc94 cdc3fc94 
Dec 21 12:45:49 tiger kernel:        c17bb824 c158cfa0 cdcc58ec 00000001 c0247a68 00000202 00000000 00002329 
Dec 21 12:45:49 tiger kernel: Call Trace: [hisax:__insmod_hisax_O/lib/modules/2.4.17-rc1-LVX/kernel/drivers/+-687376/96] [hisax:__insmod_hisax_O/lib/modules/2.4.17-rc1-LVX/kernel/drivers/+-711872/96] [release_dev+576/1340] [page_cache_release+45/48] [free_page_and_swap_cache+50/52] 
Dec 21 12:45:49 tiger kernel: Code: 8b 80 c0 00 00 00 85 c0 74 11 8b 40 18 85 c0 74 0a 52 8b 40 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 80 c0 00 00 00         mov    0xc0(%eax),%eax
Code;  00000006 Before first symbol
   6:   85 c0                     test   %eax,%eax
Code;  00000008 Before first symbol
   8:   74 11                     je     1b <_EIP+0x1b> 0000001b Before first symbol
Code;  0000000a Before first symbol
   a:   8b 40 18                  mov    0x18(%eax),%eax
Code;  0000000d Before first symbol
   d:   85 c0                     test   %eax,%eax
Code;  0000000f Before first symbol
   f:   74 0a                     je     1b <_EIP+0x1b> 0000001b Before first symbol
Code;  00000011 Before first symbol
  11:   52                        push   %edx
Code;  00000012 Before first symbol
  12:   8b 40 00                  mov    0x0(%eax),%eax
------------------------------------------------------------


Disassembling as per Documentation/oops-tracing.txt:

------------------------------------------------------------
tiger:~ # gdb /usr/src/Current-Linux/vmlinux 
(gdb) disassemble free_page_and_swap_cache+50/52 
Dump of assembler code for function free_page_and_swap_cache:
0xc0137a10 <free_page_and_swap_cache>:  push   %ebx
0xc0137a11 <free_page_and_swap_cache+1>:        mov    0x8(%esp,1),%ebx
0xc0137a15 <free_page_and_swap_cache+5>:        cmpl   $0xc0247920,0x8(%ebx)
0xc0137a1c <free_page_and_swap_cache+12>:       jne    0xc0137a3b <free_page_and_swap_cache+43>
0xc0137a1e <free_page_and_swap_cache+14>:       xor    %eax,%eax
0xc0137a20 <free_page_and_swap_cache+16>:       lock bts %eax,0x18(%ebx)
0xc0137a25 <free_page_and_swap_cache+21>:       sbb    %eax,%eax
0xc0137a27 <free_page_and_swap_cache+23>:       test   %eax,%eax
0xc0137a29 <free_page_and_swap_cache+25>:       jne    0xc0137a3b <free_page_and_swap_cache+43>
0xc0137a2b <free_page_and_swap_cache+27>:       push   %ebx
0xc0137a2c <free_page_and_swap_cache+28>:       call   0xc0138194 <remove_exclusive_swap_page>
0xc0137a31 <free_page_and_swap_cache+33>:       mov    %ebx,%eax
0xc0137a33 <free_page_and_swap_cache+35>:       call   0xc012cfd4 <unlock_page>
0xc0137a38 <free_page_and_swap_cache+40>:       add    $0x4,%esp
0xc0137a3b <free_page_and_swap_cache+43>:       mov    %ebx,%eax
0xc0137a3d <free_page_and_swap_cache+45>:       call   0xc01374dc <page_cache_release>
0xc0137a42 <free_page_and_swap_cache+50>:       pop    %ebx
0xc0137a43 <free_page_and_swap_cache+51>:       ret    
End of assembler dump.


(gdb) disassemble page_cache_release+45/48
Dump of assembler code for function page_cache_release:
0xc01374dc <page_cache_release>:        push   %ebx
0xc01374dd <page_cache_release+1>:      mov    %eax,%ebx
0xc01374df <page_cache_release+3>:      mov    0x18(%ebx),%eax
0xc01374e2 <page_cache_release+6>:      test   $0x40,%ah
0xc01374e5 <page_cache_release+9>:      jne    0xc0137509 <page_cache_release+45>
0xc01374e7 <page_cache_release+11>:     lock decl 0x14(%ebx)
0xc01374eb <page_cache_release+15>:     sete   %al
0xc01374ee <page_cache_release+18>:     test   %al,%al
0xc01374f0 <page_cache_release+20>:     je     0xc0137509 <page_cache_release+45>
0xc01374f2 <page_cache_release+22>:     mov    0x18(%ebx),%eax
0xc01374f5 <page_cache_release+25>:     test   $0x40,%al
0xc01374f7 <page_cache_release+27>:     je     0xc0137500 <page_cache_release+36>
0xc01374f9 <page_cache_release+29>:     mov    %ebx,%eax
0xc01374fb <page_cache_release+31>:     call   0xc01355d4 <lru_cache_del>
0xc0137500 <page_cache_release+36>:     xor    %edx,%edx
0xc0137502 <page_cache_release+38>:     mov    %ebx,%eax
0xc0137504 <page_cache_release+40>:     call   0xc0136a80 <__free_pages_ok>
0xc0137509 <page_cache_release+45>:     pop    %ebx
0xc013750a <page_cache_release+46>:     ret    
0xc013750b <page_cache_release+47>:     nop    
End of assembler dump.


(gdb) disassemble release_dev+576/1340
Dump of assembler code for function release_dev:
0xc0187030 <release_dev>:	sub    $0x50,%esp
0xc0187033 <release_dev+3>:	push   %ebp
0xc0187034 <release_dev+4>:	push   %edi
0xc0187035 <release_dev+5>:	push   %esi
0xc0187036 <release_dev+6>:	push   %ebx
0xc0187037 <release_dev+7>:	mov    0x64(%esp,1),%eax
0xc018703b <release_dev+11>:	mov    0x5c(%eax),%ebx
0xc018703e <release_dev+14>:	mov    0x8(%eax),%eax
0xc0187041 <release_dev+17>:	mov    0x8(%eax),%eax
0xc0187044 <release_dev+20>:	movzwl 0x40(%eax),%eax
0xc0187048 <release_dev+24>:	test   %ebx,%ebx
0xc018704a <release_dev+26>:	jne    0xc0187065 <release_dev+53>
0xc018704c <release_dev+28>:	push   $0xc0225dd2
0xc0187051 <release_dev+33>:	movzwl %ax,%eax
0xc0187054 <release_dev+36>:	push   %eax
0xc0187055 <release_dev+37>:	call   0xc013f14c <kdevname>
0xc018705a <release_dev+42>:	add    $0x4,%esp
0xc018705d <release_dev+45>:	push   %eax
0xc018705e <release_dev+46>:	push   $0xc0225c40
0xc0187063 <release_dev+51>:	jmp    0xc0187084 <release_dev+84>
0xc0187065 <release_dev+53>:	cmpl   $0x5401,(%ebx)
0xc018706b <release_dev+59>:	je     0xc0187093 <release_dev+99>
0xc018706d <release_dev+61>:	push   $0xc0225dd2
0xc0187072 <release_dev+66>:	movzwl %ax,%eax
0xc0187075 <release_dev+69>:	push   %eax
0xc0187076 <release_dev+70>:	call   0xc013f14c <kdevname>
0xc018707b <release_dev+75>:	add    $0x4,%esp
0xc018707e <release_dev+78>:	push   %eax
0xc018707f <release_dev+79>:	push   $0xc0225c00
0xc0187084 <release_dev+84>:	call   0xc0118e10 <printk>
0xc0187089 <release_dev+89>:	mov    $0x1,%eax
0xc018708e <release_dev+94>:	add    $0xc,%esp
0xc0187091 <release_dev+97>:	jmp    0xc0187095 <release_dev+101>
0xc0187093 <release_dev+99>:	xor    %eax,%eax
0xc0187095 <release_dev+101>:	test   %eax,%eax
0xc0187097 <release_dev+103>:	jne    0xc0187562 <release_dev+1330>
0xc018709d <release_dev+109>:	push   $0xc0225dd2
0xc01870a2 <release_dev+114>:	push   %ebx
0xc01870a3 <release_dev+115>:	call   0xc0185b78 <check_tty_count>
0xc01870a8 <release_dev+120>:	push   $0x0
0xc01870aa <release_dev+122>:	mov    0x70(%esp,1),%edx
0xc01870ae <release_dev+126>:	push   %edx
0xc01870af <release_dev+127>:	push   $0xffffffff
0xc01870b1 <release_dev+129>:	call   0xc0187ae0 <tty_fasync>
0xc01870b6 <release_dev+134>:	movzbl 0x110(%ebx),%ecx
0xc01870bd <release_dev+141>:	mov    %ecx,0x24(%esp,1)
0xc01870c1 <release_dev+145>:	movswl 0x16(%ebx),%eax
0xc01870c5 <release_dev+149>:	sub    %eax,0x24(%esp,1)
0xc01870c9 <release_dev+153>:	movl   $0x0,0x30(%esp,1)
0xc01870d1 <release_dev+161>:	add    $0x14,%esp
0xc01870d4 <release_dev+164>:	cmpw   $0x4,0x1a(%ebx)
0xc01870d9 <release_dev+169>:	jne    0xc01870ee <release_dev+190>
0xc01870db <release_dev+171>:	mov    $0x1,%eax
0xc01870e0 <release_dev+176>:	cmpw   $0x1,0x1c(%ebx)
0xc01870e5 <release_dev+181>:	cmovne 0x1c(%esp,1),%eax
0xc01870ea <release_dev+186>:	mov    %eax,0x1c(%esp,1)
0xc01870ee <release_dev+190>:	mov    0x128(%ebx),%ebp
0xc01870f4 <release_dev+196>:	cmpl   $0x0,0x10(%esp,1)
0xc01870f9 <release_dev+201>:	jl     0xc0187105 <release_dev+213>
0xc01870fb <release_dev+203>:	movswl 0x18(%ebx),%eax
0xc01870ff <release_dev+207>:	cmp    %eax,0x10(%esp,1)
0xc0187103 <release_dev+211>:	jl     0xc0187125 <release_dev+245>
0xc0187105 <release_dev+213>:	movzwl 0x110(%ebx),%eax
0xc018710c <release_dev+220>:	push   %eax
0xc018710d <release_dev+221>:	call   0xc013f14c <kdevname>
0xc0187112 <release_dev+226>:	push   %eax
0xc0187113 <release_dev+227>:	push   $0xc0225de0
0xc0187118 <release_dev+232>:	call   0xc0118e10 <printk>
0xc018711d <release_dev+237>:	add    $0xc,%esp
0xc0187120 <release_dev+240>:	jmp    0xc0187562 <release_dev+1330>
0xc0187125 <release_dev+245>:	mov    0x54(%ebx),%eax
0xc0187128 <release_dev+248>:	mov    0x10(%esp,1),%edx
0xc018712c <release_dev+252>:	cmp    (%eax,%edx,4),%ebx
0xc018712f <release_dev+255>:	je     0xc0187150 <release_dev+288>
0xc0187131 <release_dev+257>:	movzwl 0x110(%ebx),%eax
0xc0187138 <release_dev+264>:	push   %eax
0xc0187139 <release_dev+265>:	call   0xc013f14c <kdevname>
0xc018713e <release_dev+270>:	push   %eax
0xc018713f <release_dev+271>:	mov    0x18(%esp,1),%ecx
0xc0187143 <release_dev+275>:	push   %ecx
0xc0187144 <release_dev+276>:	push   $0xc0225e20
0xc0187149 <release_dev+281>:	jmp    0xc018723a <release_dev+522>
0xc018714e <release_dev+286>:	mov    %esi,%esi
0xc0187150 <release_dev+288>:	mov    0x58(%ebx),%eax
0xc0187153 <release_dev+291>:	mov    0x10(%esp,1),%edx
0xc0187157 <release_dev+295>:	mov    (%eax,%edx,4),%eax
0xc018715a <release_dev+298>:	cmp    %eax,0x100(%ebx)
0xc0187160 <release_dev+304>:	je     0xc0187180 <release_dev+336>
0xc0187162 <release_dev+306>:	movzwl 0x110(%ebx),%eax
0xc0187169 <release_dev+313>:	push   %eax
0xc018716a <release_dev+314>:	call   0xc013f14c <kdevname>
0xc018716f <release_dev+319>:	push   %eax
0xc0187170 <release_dev+320>:	mov    0x18(%esp,1),%ecx
0xc0187174 <release_dev+324>:	push   %ecx
0xc0187175 <release_dev+325>:	push   $0xc0225e60
0xc018717a <release_dev+330>:	jmp    0xc018723a <release_dev+522>
0xc018717f <release_dev+335>:	nop    
0xc0187180 <release_dev+336>:	mov    0x5c(%ebx),%eax
0xc0187183 <release_dev+339>:	mov    0x10(%esp,1),%edx
0xc0187187 <release_dev+343>:	mov    (%eax,%edx,4),%eax
0xc018718a <release_dev+346>:	cmp    %eax,0x104(%ebx)
0xc0187190 <release_dev+352>:	je     0xc01871b0 <release_dev+384>
0xc0187192 <release_dev+354>:	movzwl 0x110(%ebx),%eax
0xc0187199 <release_dev+361>:	push   %eax
0xc018719a <release_dev+362>:	call   0xc013f14c <kdevname>
0xc018719f <release_dev+367>:	push   %eax
0xc01871a0 <release_dev+368>:	mov    0x18(%esp,1),%ecx
0xc01871a4 <release_dev+372>:	push   %ecx
0xc01871a5 <release_dev+373>:	push   $0xc0225ea0
0xc01871aa <release_dev+378>:	jmp    0xc018723a <release_dev+522>
0xc01871af <release_dev+383>:	nop    
0xc01871b0 <release_dev+384>:	mov    0x50(%ebx),%edx
0xc01871b3 <release_dev+387>:	test   %edx,%edx
0xc01871b5 <release_dev+389>:	je     0xc0187261 <release_dev+561>
0xc01871bb <release_dev+395>:	mov    0x50(%edx),%eax
0xc01871be <release_dev+398>:	mov    0x10(%esp,1),%ecx
0xc01871c2 <release_dev+402>:	cmp    (%eax,%ecx,4),%ebp
0xc01871c5 <release_dev+405>:	je     0xc01871e1 <release_dev+433>
0xc01871c7 <release_dev+407>:	movzwl 0x110(%ebx),%eax
0xc01871ce <release_dev+414>:	push   %eax
0xc01871cf <release_dev+415>:	call   0xc013f14c <kdevname>
0xc01871d4 <release_dev+420>:	push   %eax
0xc01871d5 <release_dev+421>:	mov    0x18(%esp,1),%eax
0xc01871d9 <release_dev+425>:	push   %eax
0xc01871da <release_dev+426>:	push   $0xc0225f00
0xc01871df <release_dev+431>:	jmp    0xc018723a <release_dev+522>
0xc01871e1 <release_dev+433>:	mov    0x54(%edx),%eax
0xc01871e4 <release_dev+436>:	mov    0x10(%esp,1),%ecx
0xc01871e8 <release_dev+440>:	mov    (%eax,%ecx,4),%eax
0xc01871eb <release_dev+443>:	cmp    %eax,0x100(%ebp)
0xc01871f1 <release_dev+449>:	je     0xc0187210 <release_dev+480>
0xc01871f3 <release_dev+451>:	movzwl 0x110(%ebx),%eax
0xc01871fa <release_dev+458>:	push   %eax
0xc01871fb <release_dev+459>:	call   0xc013f14c <kdevname>
0xc0187200 <release_dev+464>:	push   %eax
0xc0187201 <release_dev+465>:	mov    0x18(%esp,1),%eax
0xc0187205 <release_dev+469>:	push   %eax
0xc0187206 <release_dev+470>:	push   $0xc0225f40
0xc018720b <release_dev+475>:	jmp    0xc018723a <release_dev+522>
0xc018720d <release_dev+477>:	lea    0x0(%esi),%esi
0xc0187210 <release_dev+480>:	mov    0x58(%edx),%eax
0xc0187213 <release_dev+483>:	mov    0x10(%esp,1),%edx
0xc0187217 <release_dev+487>:	mov    (%eax,%edx,4),%eax
0xc018721a <release_dev+490>:	cmp    %eax,0x104(%ebp)
0xc0187220 <release_dev+496>:	je     0xc0187247 <release_dev+535>
0xc0187222 <release_dev+498>:	movzwl 0x110(%ebx),%eax
0xc0187229 <release_dev+505>:	push   %eax
0xc018722a <release_dev+506>:	call   0xc013f14c <kdevname>
0xc018722f <release_dev+511>:	push   %eax
0xc0187230 <release_dev+512>:	mov    0x18(%esp,1),%ecx
0xc0187234 <release_dev+516>:	push   %ecx
0xc0187235 <release_dev+517>:	push   $0xc0225f80
0xc018723a <release_dev+522>:	call   0xc0118e10 <printk>
0xc018723f <release_dev+527>:	add    $0x10,%esp
0xc0187242 <release_dev+530>:	jmp    0xc0187562 <release_dev+1330>
0xc0187247 <release_dev+535>:	cmp    %ebx,0x128(%ebp)
0xc018724d <release_dev+541>:	je     0xc0187261 <release_dev+561>
0xc018724f <release_dev+543>:	push   $0xc0225fe0
0xc0187254 <release_dev+548>:	call   0xc0118e10 <printk>
0xc0187259 <release_dev+553>:	add    $0x4,%esp
0xc018725c <release_dev+556>:	jmp    0xc0187562 <release_dev+1330>
0xc0187261 <release_dev+561>:	mov    0x68(%ebx),%eax
0xc0187264 <release_dev+564>:	test   %eax,%eax
0xc0187266 <release_dev+566>:	je     0xc0187273 <release_dev+579>
0xc0187268 <release_dev+568>:	mov    0x64(%esp,1),%edx
0xc018726c <release_dev+572>:	push   %edx
0xc018726d <release_dev+573>:	push   %ebx
0xc018726e <release_dev+574>:	call   *%eax
0xc0187270 <release_dev+576>:	add    $0x8,%esp
0xc0187273 <release_dev+579>:	cmpl   $0x1,0x118(%ebx)
0xc018727a <release_dev+586>:	setle  %al
0xc018727d <release_dev+589>:	movzbl %al,%eax
0xc0187280 <release_dev+592>:	mov    %eax,0x18(%esp,1)
0xc0187284 <release_dev+596>:	movl   $0x0,0x14(%esp,1)
0xc018728c <release_dev+604>:	test   %ebp,%ebp
0xc018728e <release_dev+606>:	je     0xc01872ab <release_dev+635>
0xc0187290 <release_dev+608>:	mov    0x1c(%esp,1),%al
0xc0187294 <release_dev+612>:	movzbl %al,%edx
0xc0187297 <release_dev+615>:	mov    $0x1,%eax
0xc018729c <release_dev+620>:	cmp    %edx,0x118(%ebp)
0xc01872a2 <release_dev+626>:	cmovg  0x14(%esp,1),%eax
0xc01872a7 <release_dev+631>:	mov    %eax,0x14(%esp,1)
0xc01872ab <release_dev+635>:	xor    %edi,%edi
0xc01872ad <release_dev+637>:	cmpl   $0x0,0x18(%esp,1)
0xc01872b2 <release_dev+642>:	je     0xc01872fe <release_dev+718>
0xc01872b4 <release_dev+644>:	lea    0x988(%ebx),%esi
0xc01872ba <release_dev+650>:	lea    0x8(%esi),%eax
0xc01872bd <release_dev+653>:	cmp    %eax,0x990(%ebx)
0xc01872c3 <release_dev+659>:	je     0xc01872db <release_dev+683>
0xc01872c5 <release_dev+661>:	mov    $0x1,%ecx
0xc01872ca <release_dev+666>:	mov    $0x3,%edx
0xc01872cf <release_dev+671>:	mov    %esi,%eax
0xc01872d1 <release_dev+673>:	call   0xc0114d8c <__wake_up>
0xc01872d6 <release_dev+678>:	mov    $0x1,%edi
0xc01872db <release_dev+683>:	lea    0x978(%ebx),%esi
0xc01872e1 <release_dev+689>:	lea    0x8(%esi),%eax
0xc01872e4 <release_dev+692>:	cmp    %eax,0x980(%ebx)
0xc01872ea <release_dev+698>:	je     0xc01872fe <release_dev+718>
0xc01872ec <release_dev+700>:	mov    $0x1,%ecx
0xc01872f1 <release_dev+705>:	mov    $0x3,%edx
0xc01872f6 <release_dev+710>:	mov    %esi,%eax
0xc01872f8 <release_dev+712>:	call   0xc0114d8c <__wake_up>
0xc01872fd <release_dev+717>:	inc    %edi
0xc01872fe <release_dev+718>:	cmpl   $0x0,0x14(%esp,1)
0xc0187303 <release_dev+723>:	je     0xc018734b <release_dev+795>
0xc0187305 <release_dev+725>:	lea    0x988(%ebp),%esi
0xc018730b <release_dev+731>:	lea    0x8(%esi),%eax
0xc018730e <release_dev+734>:	cmp    %eax,0x990(%ebp)
0xc0187314 <release_dev+740>:	je     0xc0187328 <release_dev+760>
0xc0187316 <release_dev+742>:	mov    $0x1,%ecx
0xc018731b <release_dev+747>:	mov    $0x3,%edx
0xc0187320 <release_dev+752>:	mov    %esi,%eax
0xc0187322 <release_dev+754>:	call   0xc0114d8c <__wake_up>
0xc0187327 <release_dev+759>:	inc    %edi
0xc0187328 <release_dev+760>:	lea    0x978(%ebp),%esi
0xc018732e <release_dev+766>:	lea    0x8(%esi),%eax
0xc0187331 <release_dev+769>:	cmp    %eax,0x980(%ebp)
0xc0187337 <release_dev+775>:	je     0xc018734b <release_dev+795>
0xc0187339 <release_dev+777>:	mov    $0x1,%ecx
0xc018733e <release_dev+782>:	mov    $0x3,%edx
0xc0187343 <release_dev+787>:	mov    %esi,%eax
0xc0187345 <release_dev+789>:	call   0xc0114d8c <__wake_up>
0xc018734a <release_dev+794>:	inc    %edi
0xc018734b <release_dev+795>:	test   %edi,%edi
0xc018734d <release_dev+797>:	je     0xc0187372 <release_dev+834>
0xc018734f <release_dev+799>:	lea    0x20(%esp,1),%eax
0xc0187353 <release_dev+803>:	push   %eax
0xc0187354 <release_dev+804>:	push   %ebx
0xc0187355 <release_dev+805>:	call   0xc0185b58 <tty_name>
0xc018735a <release_dev+810>:	push   %eax
0xc018735b <release_dev+811>:	push   $0xc0226020
0xc0187360 <release_dev+816>:	call   0xc0118e10 <printk>
0xc0187365 <release_dev+821>:	call   0xc01145ac <schedule>
0xc018736a <release_dev+826>:	add    $0x10,%esp
0xc018736d <release_dev+829>:	jmp    0xc0187273 <release_dev+579>
0xc0187372 <release_dev+834>:	cmpl   $0x0,0x1c(%esp,1)
0xc0187377 <release_dev+839>:	je     0xc01873b8 <release_dev+904>
0xc0187379 <release_dev+841>:	mov    0x118(%ebp),%eax
0xc018737f <release_dev+847>:	lea    0xffffffff(%eax),%ecx
0xc0187382 <release_dev+850>:	mov    %ecx,0x118(%ebp)
0xc0187388 <release_dev+856>:	mov    %ecx,%eax
0xc018738a <release_dev+858>:	test   %eax,%eax
0xc018738c <release_dev+860>:	jge    0xc01873b8 <release_dev+904>
0xc018738e <release_dev+862>:	lea    0x20(%esp,1),%eax
0xc0187392 <release_dev+866>:	push   %eax
0xc0187393 <release_dev+867>:	push   %ebp
0xc0187394 <release_dev+868>:	call   0xc0185b58 <tty_name>
0xc0187399 <release_dev+873>:	push   %eax
0xc018739a <release_dev+874>:	mov    0x118(%ebp),%eax
0xc01873a0 <release_dev+880>:	push   %eax
0xc01873a1 <release_dev+881>:	push   $0xc0226060
0xc01873a6 <release_dev+886>:	call   0xc0118e10 <printk>
0xc01873ab <release_dev+891>:	movl   $0x0,0x118(%ebp)
0xc01873b5 <release_dev+901>:	add    $0x14,%esp
0xc01873b8 <release_dev+904>:	mov    0x118(%ebx),%eax
0xc01873be <release_dev+910>:	lea    0xffffffff(%eax),%edx
0xc01873c1 <release_dev+913>:	mov    %edx,0x118(%ebx)
0xc01873c7 <release_dev+919>:	mov    %edx,%eax
0xc01873c9 <release_dev+921>:	test   %eax,%eax
0xc01873cb <release_dev+923>:	jge    0xc01873f7 <release_dev+967>
0xc01873cd <release_dev+925>:	lea    0x20(%esp,1),%eax
0xc01873d1 <release_dev+929>:	push   %eax
0xc01873d2 <release_dev+930>:	push   %ebx
0xc01873d3 <release_dev+931>:	call   0xc0185b58 <tty_name>
0xc01873d8 <release_dev+936>:	push   %eax
0xc01873d9 <release_dev+937>:	mov    0x118(%ebx),%eax
0xc01873df <release_dev+943>:	push   %eax
0xc01873e0 <release_dev+944>:	push   $0xc02260a0
0xc01873e5 <release_dev+949>:	call   0xc0118e10 <printk>
0xc01873ea <release_dev+954>:	movl   $0x0,0x118(%ebx)
0xc01873f4 <release_dev+964>:	add    $0x14,%esp
0xc01873f7 <release_dev+967>:	mov    0x64(%esp,1),%ecx
0xc01873fb <release_dev+971>:	movl   $0x0,0x5c(%ecx)
0xc0187402 <release_dev+978>:	cmpl   $0x0,0x18(%esp,1)
0xc0187407 <release_dev+983>:	je     0xc0187416 <release_dev+998>
0xc0187409 <release_dev+985>:	mov    $0x7,%eax
0xc018740e <release_dev+990>:	lock bts %eax,0x114(%ebx)
0xc0187416 <release_dev+998>:	cmpl   $0x0,0x14(%esp,1)
0xc018741b <release_dev+1003>:	je     0xc018742a <release_dev+1018>
0xc018741d <release_dev+1005>:	mov    $0x7,%eax
0xc0187422 <release_dev+1010>:	lock bts %eax,0x114(%ebp)
0xc018742a <release_dev+1018>:	cmpl   $0x0,0x18(%esp,1)
0xc018742f <release_dev+1023>:	jne    0xc018743c <release_dev+1036>
0xc0187431 <release_dev+1025>:	cmpl   $0x0,0x14(%esp,1)
0xc0187436 <release_dev+1030>:	je     0xc01874c8 <release_dev+1176>
0xc018743c <release_dev+1036>:	mov    $0xc02908c0,%esi
0xc0187441 <release_dev+1041>:	cmpl   $0xdeaf1eed,0xc02908c4
0xc018744b <release_dev+1051>:	je     0xc0187461 <release_dev+1073>
0xc018744d <release_dev+1053>:	push   $0xba
0xc0187452 <release_dev+1058>:	push   $0xc0225a80
0xc0187457 <release_dev+1063>:	call   0xc0113608 <do_BUG>
0xc018745c <release_dev+1068>:	ud2a   
0xc018745e <release_dev+1070>:	add    $0x8,%esp
0xc0187461 <release_dev+1073>:	mov    %esi,%eax
0xc0187463 <release_dev+1075>:	lock subl $0x1,(%eax)
0xc0187467 <release_dev+1079>:	js     0xc02044de <stext_lock+15710>
0xc018746d <release_dev+1085>:	mov    0xc0254048,%eax
0xc0187472 <release_dev+1090>:	cmp    $0xc0254000,%eax
0xc0187477 <release_dev+1095>:	je     0xc01874a6 <release_dev+1142>
0xc0187479 <release_dev+1097>:	lea    0x0(%esi,1),%esi
0xc0187480 <release_dev+1104>:	mov    0x358(%eax),%edx
0xc0187486 <release_dev+1110>:	cmp    %ebx,%edx
0xc0187488 <release_dev+1112>:	je     0xc0187492 <release_dev+1122>
0xc018748a <release_dev+1114>:	test   %ebp,%ebp
0xc018748c <release_dev+1116>:	je     0xc018749c <release_dev+1132>
0xc018748e <release_dev+1118>:	cmp    %ebp,%edx
0xc0187490 <release_dev+1120>:	jne    0xc018749c <release_dev+1132>
0xc0187492 <release_dev+1122>:	movl   $0x0,0x358(%eax)
0xc018749c <release_dev+1132>:	mov    0x48(%eax),%eax
0xc018749f <release_dev+1135>:	cmp    $0xc0254000,%eax
0xc01874a4 <release_dev+1140>:	jne    0xc0187480 <release_dev+1104>
0xc01874a6 <release_dev+1142>:	lock incl 0xc02908c0
0xc01874ad <release_dev+1149>:	mov    0xc02bc5c4,%eax
0xc01874b2 <release_dev+1154>:	cmp    %ebx,%eax
0xc01874b4 <release_dev+1156>:	je     0xc01874be <release_dev+1166>
0xc01874b6 <release_dev+1158>:	test   %ebp,%ebp
0xc01874b8 <release_dev+1160>:	je     0xc01874c8 <release_dev+1176>
0xc01874ba <release_dev+1162>:	cmp    %ebp,%eax
0xc01874bc <release_dev+1164>:	jne    0xc01874c8 <release_dev+1176>
0xc01874be <release_dev+1166>:	movl   $0x0,0xc02bc5c4
0xc01874c8 <release_dev+1176>:	cmpl   $0x0,0x18(%esp,1)
0xc01874cd <release_dev+1181>:	je     0xc0187562 <release_dev+1330>
0xc01874d3 <release_dev+1187>:	test   %ebp,%ebp
0xc01874d5 <release_dev+1189>:	je     0xc01874e2 <release_dev+1202>
0xc01874d7 <release_dev+1191>:	cmpl   $0x0,0x14(%esp,1)
0xc01874dc <release_dev+1196>:	je     0xc0187562 <release_dev+1330>
0xc01874e2 <release_dev+1202>:	mov    0xd4(%ebx),%eax
0xc01874e8 <release_dev+1208>:	test   %eax,%eax
0xc01874ea <release_dev+1210>:	je     0xc01874f2 <release_dev+1218>
0xc01874ec <release_dev+1212>:	push   %ebx
0xc01874ed <release_dev+1213>:	call   *%eax
0xc01874ef <release_dev+1215>:	add    $0x4,%esp
0xc01874f2 <release_dev+1218>:	lea    0xc0(%ebx),%edi
0xc01874f8 <release_dev+1224>:	mov    $0xc02bc5e0,%esi
0xc01874fd <release_dev+1229>:	cld    
0xc01874fe <release_dev+1230>:	mov    $0x10,%ecx
0xc0187503 <release_dev+1235>:	repz movsl %ds:(%esi),%es:(%edi)
0xc0187505 <release_dev+1237>:	mov    0x100(%ebx),%eax
0xc018750b <release_dev+1243>:	movb   $0x0,0x10(%eax)
0xc018750f <release_dev+1247>:	test   %ebp,%ebp
0xc0187511 <release_dev+1249>:	je     0xc0187536 <release_dev+1286>
0xc0187513 <release_dev+1251>:	mov    0xd4(%ebp),%eax
0xc0187519 <release_dev+1257>:	test   %eax,%eax
0xc018751b <release_dev+1259>:	je     0xc0187523 <release_dev+1267>
0xc018751d <release_dev+1261>:	push   %ebp
0xc018751e <release_dev+1262>:	call   *%eax
0xc0187520 <release_dev+1264>:	add    $0x4,%esp
0xc0187523 <release_dev+1267>:	lea    0xc0(%ebp),%edi
0xc0187529 <release_dev+1273>:	mov    $0xc02bc5e0,%esi
0xc018752e <release_dev+1278>:	cld    
0xc018752f <release_dev+1279>:	mov    $0x10,%ecx
0xc0187534 <release_dev+1284>:	repz movsl %ds:(%esi),%es:(%edi)
0xc0187536 <release_dev+1286>:	cmpl   $0xc0247410,0xc0247410
0xc0187540 <release_dev+1296>:	je     0xc018754f <release_dev+1311>
0xc0187542 <release_dev+1298>:	push   $0xc0247410
0xc0187547 <release_dev+1303>:	call   0xc011e304 <__run_task_queue>
0xc018754c <release_dev+1308>:	add    $0x4,%esp
0xc018754f <release_dev+1311>:	call   0xc012778c <flush_scheduled_tasks>
0xc0187554 <release_dev+1316>:	mov    0x10(%esp,1),%eax
0xc0187558 <release_dev+1320>:	push   %eax
0xc0187559 <release_dev+1321>:	push   %ebx
0xc018755a <release_dev+1322>:	call   0xc0186f80 <release_mem>
0xc018755f <release_dev+1327>:	add    $0x8,%esp
0xc0187562 <release_dev+1330>:	pop    %ebx
0xc0187563 <release_dev+1331>:	pop    %esi
0xc0187564 <release_dev+1332>:	pop    %edi
0xc0187565 <release_dev+1333>:	pop    %ebp
0xc0187566 <release_dev+1334>:	add    $0x50,%esp
0xc0187569 <release_dev+1337>:	ret    
0xc018756a <release_dev+1338>:	mov    %esi,%esi
End of assembler dump.
------------------------------------------------------------

-Wolfgang

PS: Yes, the email address is replyable and is being read :-)

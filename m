Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSFQHYd>; Mon, 17 Jun 2002 03:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSFQHXM>; Mon, 17 Jun 2002 03:23:12 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:27778 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316823AbSFQHWk>; Mon, 17 Jun 2002 03:22:40 -0400
Date: Mon, 17 Jun 2002 09:22:14 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: isdn oops with 2.4.19-pre10
Message-Id: <20020617092214.03789a68.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I tried to unload the isdn modules (I'm using a hisax and a avm b1 card) and get these oopses:

ksymoops 2.4.3 on i586 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (specified)

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
 Unable to handle kernel NULL pointer dereference at virtual address 00000008 
 c5845a2e 
 *pde = 00000000 
 Oops: 0000 
 CPU:    0 
 EIP:    0010:[sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-878034/96]    Not tainted 
 EIP:    0010:[<c5845a2e>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010297 
 eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c5859000 
 esi: 00000000   edi: c10fe320   ebp: c3e0fa60   esp: c475fefc 
 ds: 0018   es: 0018   ss: 0018 
 Process ipppd (pid: 15480, stackpage=c475f000) 
 Stack: 00000080 c3a55be0 c38c2260 400f1cd0 00000000 c475e000 00000004 c0113b34  
        080671e0 00000000 c475e000 00000000 00000000 c16f635c 400f1cd0 c475e564  
        c475ffc4 00030002 bffff120 00000000 c475ffbc 00000000 00000000 bffff178  
 Call Trace: [do_page_fault+0/1207] [sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-865259/96] [fput+76/208] [filp_close+85/96] [sys_close+67/84]  
 Call Trace: [<c0113b34>] [<c5848c15>] [<c01340a4>] [<c01330c5>] [<c0133113>]  
    [<c01088a3>]  
 Code: 83 78 08 00 7e 37 8d 44 24 08 89 5c 24 08 c7 44 24 10 00 00  

>>EIP; c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
Trace; c0113b34 <do_page_fault+0/4b6>
Trace; c5848c14 <[isdn]isdn_close+68/b0>
Trace; c01340a4 <fput+4c/d0>
Trace; c01330c4 <filp_close+54/60>
Trace; c0133112 <sys_close+42/54>
Trace; c01088a2 <system_call+32/40>
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>
00000000 <_EIP>:
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
   0:   83 78 08 00               cmpl   $0x0,0x8(%eax)   <=====
Code;  c5845a32 <[isdn]isdn_unlock_drivers+2a/74>
   4:   7e 37                     jle    3d <_EIP+0x3d> c5845a6a <[isdn]isdn_unlock_drivers+62/74>
Code;  c5845a34 <[isdn]isdn_unlock_drivers+2c/74>
   6:   8d 44 24 08               lea    0x8(%esp,1),%eax
Code;  c5845a38 <[isdn]isdn_unlock_drivers+30/74>
   a:   89 5c 24 08               mov    %ebx,0x8(%esp,1)
Code;  c5845a3c <[isdn]isdn_unlock_drivers+34/74>
   e:   c7 44 24 10 00 00 00      movl   $0x0,0x10(%esp,1)
Code;  c5845a42 <[isdn]isdn_unlock_drivers+3a/74>
  15:   00 

  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000008 
 c5845a2e 
 *pde = 00000000 
 Oops: 0000 
 CPU:    0 
 EIP:    0010:[sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-878034/96]    Not tainted 
 EIP:    0010:[<c5845a2e>]    Not tainted 
 EFLAGS: 00010297 
 eax: 00000000   ebx: 00000000   ecx: 00000082   edx: c5859000 
 esi: 00000000   edi: 00000000   ebp: 000000d0   esp: c44c3e04 
 ds: 0018   es: 0018   ss: 0018 
 Process ifconfig (pid: 17958, stackpage=c44c3000) 
 Stack: 00000000 c2b5f610 c2b5f610 00000004 c408ac60 c408ac00 00000086 00000296  
        c3759d20 00000009 c02299ec 00000086 00000282 c3bd6e00 00000009 c01b7959  
        c408fe20 c588c6a9 c408fe20 c2b5f610 00000202 c2b5f610 c01b763f c2b5f6a8  
 Call Trace: [qdisc_reset+17/24] [sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-588119/96] [dev_watchdog_down+23/68] [dev_deactivate+66/104] [sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-877938/96]  
 Call Trace: [<c01b7959>] [<c588c6a9>] [<c01b763f>] [<c01b7abe>] [<c5845a8e>]  
    [<c583bba1>] [<c01afecb>] [<c01b0e08>] [<c01dfbc7>] [<c014d9fd>] [<c01b0ed9>]  
    [<c01e1b17>] [<c01aa295>] [<c013fa66>] [<c01aa274>] [<c01088a3>]  
 Code: 83 78 08 00 7e 37 8d 44 24 08 89 5c 24 08 c7 44 24 10 00 00  

>>EIP; c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
Trace; c01b7958 <qdisc_reset+10/18>
Trace; c588c6a8 <[sch_cbq]cbq_reset+c4/108>
Trace; c01b763e <dev_watchdog_down+16/44>
Trace; c01b7abe <dev_deactivate+42/68>
Trace; c5845a8e <[isdn]isdn_MOD_DEC_USE_COUNT+12/14>
Trace; c583bba0 <[isdn]isdn_net_close+38/44>
Trace; c01afeca <dev_close+36/70>
Trace; c01b0e08 <dev_change_flags+54/114>
Trace; c01dfbc6 <devinet_ioctl+35a/684>
Trace; c014d9fc <proc_get_inode+40/118>
Trace; c01b0ed8 <dev_ifsioc+10/364>
Trace; c01e1b16 <inet_ioctl+132/17c>
Trace; c01aa294 <sock_ioctl+20/28>
Trace; c013fa66 <sys_ioctl+17a/194>
Trace; c01aa274 <sock_ioctl+0/28>
Trace; c01088a2 <system_call+32/40>
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>
00000000 <_EIP>:
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
   0:   83 78 08 00               cmpl   $0x0,0x8(%eax)   <=====
Code;  c5845a32 <[isdn]isdn_unlock_drivers+2a/74>
   4:   7e 37                     jle    3d <_EIP+0x3d> c5845a6a <[isdn]isdn_unlock_drivers+62/74>
Code;  c5845a34 <[isdn]isdn_unlock_drivers+2c/74>
   6:   8d 44 24 08               lea    0x8(%esp,1),%eax
Code;  c5845a38 <[isdn]isdn_unlock_drivers+30/74>
   a:   89 5c 24 08               mov    %ebx,0x8(%esp,1)
Code;  c5845a3c <[isdn]isdn_unlock_drivers+34/74>
   e:   c7 44 24 10 00 00 00      movl   $0x0,0x10(%esp,1)
Code;  c5845a42 <[isdn]isdn_unlock_drivers+3a/74>
  15:   00 

  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000008 
 c5845a2e 
 *pde = 00000000 
 Oops: 0000 
 CPU:    0 
 EIP:    0010:[sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-878034/96]    Not tainted 
 EIP:    0010:[<c5845a2e>]    Not tainted 
 EFLAGS: 00010297 
 eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c5859000 
 esi: 00000000   edi: c10fe320   ebp: c3ea4640   esp: c27b3efc 
 ds: 0018   es: 0018   ss: 0018 
 Process isdnlog (pid: 15459, stackpage=c27b3000) 
 Stack: 00000040 c1158320 c23f2ea0 080570d4 00000000 c27b2000 00000004 c0113b34  
        bfffa514 00000000 c27b2000 bfffc90c 00000001 c16f617c 080570d4 c27b2564  
        c27b3fc4 00030002 00000000 00000000 00004618 00000000 00000000 bfffa33c  
 Call Trace: [do_page_fault+0/1207] [sch_sfq:__insmod_sch_sfq_O/lib/modules/2.4.19-pre10/kernel/net/sche+-865259/96] [fput+76/208] [filp_close+85/96] [sys_close+67/84]  
 Call Trace: [<c0113b34>] [<c5848c15>] [<c01340a4>] [<c01330c5>] [<c0133113>]  
    [<c01088a3>]  
 Code: 83 78 08 00 7e 37 8d 44 24 08 89 5c 24 08 c7 44 24 10 00 00  

>>EIP; c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
Trace; c0113b34 <do_page_fault+0/4b6>
Trace; c5848c14 <[isdn]isdn_close+68/b0>
Trace; c01340a4 <fput+4c/d0>
Trace; c01330c4 <filp_close+54/60>
Trace; c0133112 <sys_close+42/54>
Trace; c01088a2 <system_call+32/40>
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>
00000000 <_EIP>:
Code;  c5845a2e <[isdn]isdn_unlock_drivers+26/74>   <=====
   0:   83 78 08 00               cmpl   $0x0,0x8(%eax)   <=====
Code;  c5845a32 <[isdn]isdn_unlock_drivers+2a/74>
   4:   7e 37                     jle    3d <_EIP+0x3d> c5845a6a <[isdn]isdn_unlock_drivers+62/74>
Code;  c5845a34 <[isdn]isdn_unlock_drivers+2c/74>
   6:   8d 44 24 08               lea    0x8(%esp,1),%eax
Code;  c5845a38 <[isdn]isdn_unlock_drivers+30/74>
   a:   89 5c 24 08               mov    %ebx,0x8(%esp,1)
Code;  c5845a3c <[isdn]isdn_unlock_drivers+34/74>
   e:   c7 44 24 10 00 00 00      movl   $0x0,0x10(%esp,1)
Code;  c5845a42 <[isdn]isdn_unlock_drivers+3a/74>
  15:   00 


1 warning issued.  Results may not be reliable.


a lsmod after the oops says the following:

# lsmod
Module                  Size  Used by    Not tainted
sch_sfq                 3520   3 
sch_cbq                12160   1 
ipt_TOS                 1016  28 
ipt_MASQUERADE          1688   1 
ipt_LOG                 3192 269 
ipt_REJECT              2840   5 
ipt_limit                920  61 
iptable_nat            18968   1  [ipt_MASQUERADE]
ipt_state                568  22 
ip_conntrack           20348   2  [ipt_MASQUERADE iptable_nat ipt_state]
iptable_mangle          2100   1 
iptable_filter          1672   1 
ip_tables              13304  11  [ipt_TOS ipt_MASQUERADE ipt_LOG ipt_REJECT ipt_limit iptable_nat ipt_state iptable_mangle iptable_filter]
hisax                 492836   3 
isdn                  119072   2  [hisax]
slhc                    4624   1  [isdn]
ibmtr                  16344   0  (autoclean) (unused)
tlan                   23672   1  (autoclean)

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97] (rev 03)
00:0c.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
00:0d.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
00:10.0 Network controller: Compaq Computer Corporation Integrated Netelligent 10/100 (rev 10)
00:14.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 31)
00:14.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:14.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
00:14.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI (rev 01)

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDHQ0v (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTDHQ0v (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:26:51 -0400
Received: from smtp02.web.de ([217.72.192.151]:22290 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261323AbTDHQ0k (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:26:40 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Karsten Keil <keil@isdn4linux.de>
Subject: [2.5.67] oops in hisax
Date: Tue, 8 Apr 2003 18:37:43 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304081837.43751.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I got an oops while booting 2.5.67 from hisax subsystem:

ksymoops 2.4.8 on i686 2.4.21-pre6.  Options used
     -v linux-2.5/linux-2.5.67/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m linux-2.5/linux-2.5.67/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c030c19a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c030c19a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: cfd0fc00   ecx: cfd12000   edx: cfd0fde0
esi: cfd12000   edi: cfd1210c   ebp: c1293de0   esp: c1293dd0
ds: 007b   es: 007b   ss: 0068
Stack: cfd0fc00 cfd0fc2c cfd0fc00 cfd12000 c1293e10 c0317b51 cfd0fc00 cfd12000 
       cfd1210c cfd1210c cfd12000 c1293e10 c0317a64 cfd12124 cfd1210c cfd12000 
       c1293e2c c0317d80 cfd1210c cfd1213c cfd12000 c1293e9e cfd120da c1293e48 
Call Trace:
 [<c0317b51>] init_d_st+0x52/0x11d
 [<c0317a64>] init_PStack+0x20/0xbb
 [<c0317d80>] init_chan+0x10b/0x115
 [<c0317db0>] CallcNewChan+0x26/0xbf
 [<c030a073>] hisax_register+0x86/0x12b
 [<c0210240>] pci_device_probe+0x5a/0x68
 [<c02758bd>] bus_match+0x43/0x6e
 [<c02759be>] driver_attach+0x5d/0x6f
 [<c0275cda>] bus_add_driver+0xe9/0xeb
 [<c02760f4>] driver_register+0x3a/0x3e
 [<c0210357>] pci_register_driver+0x49/0x59
 [<c01291e2>] init_workqueues+0x12/0x2c
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0107289>] kernel_thread_helper+0x5/0xb
Code: 8b 50 04 85 d2 75 0a 8b 5d f8 8b 75 fc 89 ec 5d c3 89 74 24 


>>EIP; c030c19a <setstack_HiSax+85/a2>   <=====

>>ebx; cfd0fc00 <_end+f792e48/3fa8304c>
>>ecx; cfd12000 <_end+f795248/3fa8304c>
>>edx; cfd0fde0 <_end+f793028/3fa8304c>
>>esi; cfd12000 <_end+f795248/3fa8304c>
>>edi; cfd1210c <_end+f795354/3fa8304c>
>>ebp; c1293de0 <_end+d17028/3fa8304c>
>>esp; c1293dd0 <_end+d17018/3fa8304c>

Trace; c0317b51 <init_d_st+52/11d>
Trace; c0317a64 <init_PStack+20/bb>
Trace; c0317d80 <init_chan+10b/115>
Trace; c0317db0 <CallcNewChan+26/bf>
Trace; c030a073 <hisax_register+86/12b>
Trace; c0210240 <pci_device_probe+5a/68>
Trace; c02758bd <bus_match+43/6e>
Trace; c02759be <driver_attach+5d/6f>
Trace; c0275cda <bus_add_driver+e9/eb>
Trace; c02760f4 <driver_register+3a/3e>
Trace; c0210357 <pci_register_driver+49/59>
Trace; c01291e2 <init_workqueues+12/2c>
Trace; c01050a3 <init+39/196>
Trace; c010506a <init+0/196>
Trace; c0107289 <kernel_thread_helper+5/b>

Code;  c030c19a <setstack_HiSax+85/a2>
00000000 <_EIP>:
Code;  c030c19a <setstack_HiSax+85/a2>   <=====
   0:   8b 50 04                  mov    0x4(%eax),%edx   <=====
Code;  c030c19d <setstack_HiSax+88/a2>
   3:   85 d2                     test   %edx,%edx
Code;  c030c19f <setstack_HiSax+8a/a2>
   5:   75 0a                     jne    11 <_EIP+0x11>
Code;  c030c1a1 <setstack_HiSax+8c/a2>
   7:   8b 5d f8                  mov    0xfffffff8(%ebp),%ebx
Code;  c030c1a4 <setstack_HiSax+8f/a2>
   a:   8b 75 fc                  mov    0xfffffffc(%ebp),%esi
Code;  c030c1a7 <setstack_HiSax+92/a2>
   d:   89 ec                     mov    %ebp,%esp
Code;  c030c1a9 <setstack_HiSax+94/a2>
   f:   5d                        pop    %ebp
Code;  c030c1aa <setstack_HiSax+95/a2>
  10:   c3                        ret    
Code;  c030c1ab <setstack_HiSax+96/a2>
  11:   89 74 24 00               mov    %esi,0x0(%esp,1)


GDB:
Dump of assembler code for function setstack_HiSax:
0xc030c115 <setstack_HiSax>:    push   %ebp
0xc030c116 <setstack_HiSax+1>:  mov    %esp,%ebp
0xc030c118 <setstack_HiSax+3>:  sub    $0x10,%esp
0xc030c11b <setstack_HiSax+6>:  mov    %ebx,0xfffffff8(%ebp)
0xc030c11e <setstack_HiSax+9>:  mov    %esi,0xfffffffc(%ebp)
0xc030c121 <setstack_HiSax+12>: mov    0x8(%ebp),%ebx
0xc030c124 <setstack_HiSax+15>: mov    0xc(%ebp),%esi
0xc030c127 <setstack_HiSax+18>: mov    %esi,0x4(%ebx)
0xc030c12a <setstack_HiSax+21>: mov    0x8(%esi),%eax
0xc030c12d <setstack_HiSax+24>: movl   $0x0,0x10(%ebx)
0xc030c134 <setstack_HiSax+31>: movl   $0x1,0x18(%ebx)
0xc030c13b <setstack_HiSax+38>: mov    %eax,0x230(%ebx)
0xc030c141 <setstack_HiSax+44>: movl   $0xc0573874,0x14(%ebx)
0xc030c148 <setstack_HiSax+51>: mov    0x9b0(%esi),%eax
0xc030c14e <setstack_HiSax+57>: movl   $0xc030af09,0x28(%ebx)
0xc030c155 <setstack_HiSax+64>: movl   $0x0,0x24(%ebx)
0xc030c15c <setstack_HiSax+71>: mov    %eax,0x1c(%ebx)
0xc030c15f <setstack_HiSax+74>: mov    %ebx,0x20(%ebx)
0xc030c162 <setstack_HiSax+77>: lea    0x2c(%ebx),%eax
0xc030c165 <setstack_HiSax+80>: mov    %eax,0x4(%esp,1)
0xc030c169 <setstack_HiSax+84>: lea    0x14(%ebx),%eax
0xc030c16c <setstack_HiSax+87>: mov    %eax,(%esp,1)
0xc030c16f <setstack_HiSax+90>: call   0xc031962c <FsmInitTimer>
0xc030c174 <setstack_HiSax+95>: mov    %ebx,(%esp,1)
0xc030c177 <setstack_HiSax+98>: call   0xc030ce86 <setstack_tei>
0xc030c17c <setstack_HiSax+103>:        mov    %ebx,(%esp,1)
0xc030c17f <setstack_HiSax+106>:        call   0xc03146bf <setstack_manager>
0xc030c184 <setstack_HiSax+111>:        lea    0x98c(%esi),%eax
0xc030c18a <setstack_HiSax+117>:        movl   $0xc030be55,0x5c(%ebx)
0xc030c191 <setstack_HiSax+124>:        mov    %eax,0xc(%ebx)
0xc030c194 <setstack_HiSax+127>:        mov    0xfc(%esi),%eax

0xc030c19a <setstack_HiSax+133>:        mov    0x4(%eax),%edx
// => if (cs->dc_l1_ops->open)
// here it oopses
// dc_l1_ops == null-pointer here?
0xc030c19d <setstack_HiSax+136>:        test   %edx,%edx
0xc030c19f <setstack_HiSax+138>:        jne    0xc030c1ab <setstack_HiSax+150>

0xc030c1a1 <setstack_HiSax+140>:        mov    0xfffffff8(%ebp),%ebx
0xc030c1a4 <setstack_HiSax+143>:        mov    0xfffffffc(%ebp),%esi
0xc030c1a7 <setstack_HiSax+146>:        mov    %ebp,%esp
0xc030c1a9 <setstack_HiSax+148>:        pop    %ebp
0xc030c1aa <setstack_HiSax+149>:        ret    
0xc030c1ab <setstack_HiSax+150>:        mov    %esi,0x4(%esp,1)
0xc030c1af <setstack_HiSax+154>:        mov    %ebx,(%esp,1)
0xc030c1b2 <setstack_HiSax+157>:        call   *0x4(%eax)
0xc030c1b5 <setstack_HiSax+160>:        jmp    0xc030c1a1 <setstack_HiSax+140>
End of assembler dump.

I've tried to "fix" it with this realy stupid patch, but
I got another oops upon that (This was clear to me, while writing
the patch :)

--- drivers/isdn/hisax/isdnl1.c.orig    2003-04-08 17:52:08.000000000 +0200
+++ drivers/isdn/hisax/isdnl1.c 2003-04-08 17:53:35.000000000 +0200
@@ -905,7 +905,7 @@
        setstack_manager(st);
        st->l1.stlistp = &(cs->stlist);
        st->l1.l2l1  = dch_l2l1;
-       if (cs->dc_l1_ops->open)
+       if (cs->dc_l1_ops && cs->dc_l1_ops->open)
                cs->dc_l1_ops->open(st, cs);
 }


I have too small (very small) knowledge of the hisax subsystem, so I'm not
able to fix this oops. What's dc_l1_ops for? It seems to be a struct holding
various function pointers. Where *should* this pointer be assigned
(but actually isn't -> is currently null-pointer)?

Thanks for help.

Regards
Michael Buesch.

PS: Last part of ttylog is:

i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes @ cfdc66a0
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
md: raid0 personality registered as nr 2
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
ISDN subsystem initialized
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
get_drv 0: 0 -> 1
HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c030c19a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c030c19a>]    Not tainted
EFLAGS: 00010286
EIP is at setstack_HiSax+0x85/0xa2
eax: 00000000   ebx: cfd0fc00   ecx: cfd12000   edx: cfd0fde0
esi: cfd12000   edi: cfd1210c   ebp: c1293de0   esp: c1293dd0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1292000 task=c12ae080)
Stack: cfd0fc00 cfd0fc2c cfd0fc00 cfd12000 c1293e10 c0317b51 cfd0fc00 cfd12000 
       cfd1210c cfd1210c cfd12000 c1293e10 c0317a64 cfd12124 cfd1210c cfd12000 
       c1293e2c c0317d80 cfd1210c cfd1213c cfd12000 c1293e9e cfd120da c1293e48 
Call Trace:
 [<c0317b51>] init_d_st+0x52/0x11d
 [<c0317a64>] init_PStack+0x20/0xbb
 [<c0317d80>] init_chan+0x10b/0x115
 [<c0317db0>] CallcNewChan+0x26/0xbf
 [<c030a073>] hisax_register+0x86/0x12b
 [<c0210240>] pci_device_probe+0x5a/0x68
 [<c02758bd>] bus_match+0x43/0x6e
 [<c02759be>] driver_attach+0x5d/0x6f
 [<c0275cda>] bus_add_driver+0xe9/0xeb
 [<c02760f4>] driver_register+0x3a/0x3e
 [<c0210357>] pci_register_driver+0x49/0x59
 [<c01291e2>] init_workqueues+0x12/0x2c
 [<c01050a3>] init+0x39/0x196
 [<c010506a>] init+0x0/0x196
 [<c0107289>] kernel_thread_helper+0x5/0xb
Code: 8b 50 04 85 d2 75 0a 8b 5d f8 8b 75 fc 89 ec 5d c3 89 74 24 
 <0>Kernel panic: Attempted to kill init!


-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTIKPK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbTIKPK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:10:57 -0400
Received: from halon.barra.com ([144.203.11.1]:51935 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S261335AbTIKPKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:10:43 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: shuchen@realtek.com.tw
Subject: [OOPS][RTL8180] kernel panic with rtl8180 driver.
Date: Thu, 11 Sep 2003 07:23:19 -0700
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XVIY/Fem/NIq3sd"
Message-Id: <200309110723.19489.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XVIY/Fem/NIq3sd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi!

I am trying to use rtl8180 driver version 1.3 for gcc 3.x
Driver loads and inits successfully, and when I do iwpriv wlan0 enable 
it starts to work (prints messages about joining BSS, Roaming etc..), 
but after a few second (apparently after some Rx) I get the attached 
kernel panic. I am using vanilla 2.4.22 kernel with all debug options 
compiled in so looks like a memory allocation problem is being caught 
here.

Thanks,

Fedor.

--Boundary-00=_XVIY/Fem/NIq3sd
Content-Type: text/plain;
  charset="us-ascii";
  name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops.txt"

ksymoops 2.4.8 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
kernel BUG at slab.c:1220!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01308ac>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: cdd3e000   ebx: 00000000   ecx: 00001000   edx: c12997f8
esi: cdc4cd64   edi: cdd3e000   ebp: c02b7e50   esp: c02b7e44
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b7000)
Stack: cdd3e012 cdd3e012 cdd3f012 c02b7e74 c013131c c12997f8 cdc4cd64 cdd3e012
       cdc4cd64 002606a8 cdd3e012 00000286 c02b7e90 c0130a48 c12997f8 cdd3e012
       cddbb69c cdd3e020 cefc3400 c02b7ea4 c01ee6f4 cdd3e012 cddbb69c cddbb69c
Call Trace:    [<c013131c>] [<c0130a48>] [<c01ee6f4>] [<c01ee812>] [<c02006b8>]
  [<cfd96285>] [<c01f2b54>] [<c01f2c89>] [<c01f2d8a>] [<c011e314>] [<c01089aa>]
  [<c01053a0>] [<c010ad18>] [<c01053a0>] [<c01053c6>] [<c0105442>] [<c0105000>]
Code: 0f 0b c4 04 f5 d9 24 c0 8b 46 14 83 f8 ff 74 11 8d 74 26 00


>>EIP; c01308ac <kmem_extra_free_checks+3c/70>   <=====

>>eax; cdd3e000 <_end+da33be8/f9b8c68>
>>edx; c12997f8 <_end+f8f3e0/f9b8c68>
>>esi; cdc4cd64 <_end+d94294c/f9b8c68>
>>edi; cdd3e000 <_end+da33be8/f9b8c68>
>>ebp; c02b7e50 <init_task_union+1e50/2000>
>>esp; c02b7e44 <init_task_union+1e44/2000>

Trace; c013131c <kmem_cache_free_one+ec/200>
Trace; c0130a48 <kfree+58/a0>
Trace; c01ee6f4 <kfree_skbmem+14/70>
Trace; c01ee812 <__kfree_skb+c2/110>
Trace; c02006b8 <ip_rcv_finish+118/220>
Trace; cfd96285 <[rtl8180]Rx_Int_handler+221/2c4>
Trace; c01f2b54 <netif_receive_skb+c4/180>
Trace; c01f2c89 <process_backlog+79/110>
Trace; c01f2d8a <net_rx_action+6a/100>
Trace; c011e314 <do_softirq+94/a0>
Trace; c01089aa <do_IRQ+ba/e0>
Trace; c01053a0 <default_idle+0/30>
Trace; c010ad18 <call_do_IRQ+5/d>
Trace; c01053a0 <default_idle+0/30>
Trace; c01053c6 <default_idle+26/30>
Trace; c0105442 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c01308ac <kmem_extra_free_checks+3c/70>
00000000 <_EIP>:
Code;  c01308ac <kmem_extra_free_checks+3c/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01308ae <kmem_extra_free_checks+3e/70>
   2:   c4 04 f5 d9 24 c0 8b      les    0x8bc024d9(,%esi,8),%eax
Code;  c01308b5 <kmem_extra_free_checks+45/70>
   9:   46                        inc    %esi
Code;  c01308b6 <kmem_extra_free_checks+46/70>
   a:   14 83                     adc    $0x83,%al
Code;  c01308b8 <kmem_extra_free_checks+48/70>
   c:   f8                        clc    
Code;  c01308b9 <kmem_extra_free_checks+49/70>
   d:   ff 74 11 8d               pushl  0xffffff8d(%ecx,%edx,1)
Code;  c01308bd <kmem_extra_free_checks+4d/70>
  11:   74 26                     je     39 <_EIP+0x39>

 <0>Kernel panic: Aiee, killing interrupt handler!

--Boundary-00=_XVIY/Fem/NIq3sd--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269277AbTCBTIm>; Sun, 2 Mar 2003 14:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269278AbTCBTIm>; Sun, 2 Mar 2003 14:08:42 -0500
Received: from pipgate.pipsworld.sara.nl ([145.100.9.18]:52608 "EHLO
	dinkie.pipsworld.sara.nl") by vger.kernel.org with ESMTP
	id <S269277AbTCBTIl>; Sun, 2 Mar 2003 14:08:41 -0500
Date: Sun, 2 Mar 2003 20:19:04 +0100
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       Jeff Garzik <jgarzik@pobox.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Oops in tulip op ppc on 2.5.62 and 2.5.63
Message-Id: <20030302201904.5303c48e.r.post@sara.nl>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, this one has been reported by me before on 2.5.62 and 2.5.63. I just
enabled kksymoops, so I'd get maybe some more complete info.

It has been very reproducable on my motorola powerstack 2 mobo. I just
boot, and try to ping my default gateway. Well, there is no reply, and
the gateway never sees the ping requests. DHCP does sem to work, because
the my little testbox does get the correct IP, and I do see the DHCP
reply's on the wire (the requests must be there as well, I just don't
see them because I had to filter the tcpdump).

Well, after a few failed pings, when I unplug the ethernet:


flops:~# eth1: 10baseT-HD link ok, status ffffffc8                      
       
eth1: link down                                                         
       
eth1: timeout expired stopping DMA                                      
       
kernel BUG at drivers/net/tulip/de2104x.c:925!                          
       
Oops: Exception in kernel mode, sig: 4                                  
       
NIP: C013A7F0 LR: C013A7F0 SP: C0295E00 REGS: c0295d50 TRAP: 0700    
Not taintedMSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11                                
TASK = c0231530[0] 'swapper' Last syscall: 120                                 
GPR00: C013A7F0 C0295E00 C0231530 0000002F 00000001 C0295CB8 C0291B80 C02D0000  
GPR08: 000016F0 00000000 00000000 C0295D30 4000C088 00000000 00000000 00000000  
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000  
GPR24: 00000000 00000000 00000002 00001032 C3F7C000 00009032 FFFFFFCE C3F7C1C0  
Call trace:                                                                     
[c013ab30] de21040_media_timer+0x128/0x1c0                                     
[c0020744] run_timer_softirq+0x10c/0x164                                       
[c001b864] do_softirq+0x88/0x104                                               
[c0007e80] timer_interrupt+0x284/0x298                                         
[c00061c4] ret_from_except+0x0/0x14                                            
[c0007b84] default_idle+0x20/0x60                                              
[c0007bf8] cpu_idle+0x34/0x38                                                  
[c0003ae8] rest_init+0x24/0x34                                                 
[c0296508] 0xc0296508                                                          
[00003798] 0x3798                                                       
     
Kernel panic: Aiee, killing interrupt handler!                                 
In interrupt handler - not syncing                                            

Hope any of you know how to fix this... For this box, the ethernet not working 
is currently the only part that doesn't seem to work in the current 2.5 kernel.


-- 

Remco

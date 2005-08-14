Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVHNATm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVHNATm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVHNATm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:19:42 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:22405 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751348AbVHNATm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:19:42 -0400
Message-ID: <42FE8DD2.10204@gmail.com>
Date: Sun, 14 Aug 2005 02:18:26 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-parport@lists.infradead.org
Subject: [BUG] PLIP: Badness in enable_irq and Oops
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

While I have been using plip (without that, it is ok), this badness 
appeared several times:
Badness in enable_irq at /l/latest/xxx/kernel/irq/manage.c:113
 [<c0103db8>] dump_stack+0x1e/0x20
 [<c0141e28>] enable_irq+0x6f/0xce
 [<e1904c43>] plip_error+0xae/0x10c [plip]
 [<e19031eb>] plip_bh+0x4a/0x97 [plip]
 [<c012eb63>] worker_thread+0x18f/0x241
 [<c0132f07>] kthread+0xb1/0xb5
 [<c0101199>] kernel_thread_helper+0x5/0xb
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03cf6c7>] .... _spin_lock_irqsave+0x10/0x70

and finally, one oops:
Aug 14 00:31:20 bellona kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000008c
Aug 14 00:31:20 bellona kernel:  printing eip:
Aug 14 00:31:20 bellona kernel: e190357a
Aug 14 00:31:20 bellona kernel: *pde = 00000000
Aug 14 00:31:20 bellona kernel: Oops: 0000 [#1]
Aug 14 00:31:20 bellona kernel: PREEMPT SMP
Aug 14 00:31:20 bellona kernel: last sysfs file: /class/net/plip0/ifindex
Aug 14 00:31:20 bellona kernel: Modules linked in: parport_pc plip 
parport sunrpc ipv6 video hotkey ftdi_sio usbserial i2c_i801
Aug 14 00:31:20 bellona kernel: CPU:    1
Aug 14 00:31:20 bellona kernel: EIP:    0060:[<e190357a>]    Not tainted VLI
Aug 14 00:31:20 bellona kernel: EFLAGS: 00010292   (2.6.13-rc5-mm1)
Aug 14 00:31:20 bellona kernel: EIP is at plip_type_trans+0xf/0xbf [plip]
Aug 14 00:31:20 bellona kernel: eax: d930c74c   ebx: 00000000   ecx: 
dfe41000   edx: d930c400
Aug 14 00:31:20 bellona kernel: esi: d930c400   edi: 00000bb8   ebp: 
dfe41edc   esp: dfe41ec8
Aug 14 00:31:20 bellona kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 00:31:20 bellona kernel: Process events/1 (pid: 9, 
threadinfo=dfe41000 task=dff026a0)
Aug 14 00:31:20 bellona kernel: Stack: 00000001 00000000 00000000 
d930c400 00000bb8 dfe41f20 e1903670 00000000
Aug 14 00:31:21 bellona kernel:        d930c400 000001d9 d930c6cb 
b477541a 000001d9 00000000 00000140 dff027dc
Aug 14 00:31:21 bellona kernel:        dff026a0 ce1db280 c140e160 
d930c640 d930c400 d930c74c dfe41f4c e19031eb
Aug 14 00:31:21 bellona kernel: Call Trace:
Aug 14 00:31:21 bellona kernel:  [<c0103d64>] show_stack+0x9b/0xd1
Aug 14 00:31:21 bellona kernel:  [<c0103f43>] show_registers+0x189/0x21f
Aug 14 00:31:21 bellona kernel:  [<c010417d>] die+0x11b/0x19d
Aug 14 00:31:21 bellona kernel:  [<c03d03cc>] do_page_fault+0x33c/0x66e
Aug 14 00:31:21 bellona kernel:  [<c01039ef>] error_code+0x4f/0x54
Aug 14 00:31:21 bellona kernel:  [<e1903670>] 
plip_receive_packet+0x46/0xb3c [plip]
Aug 14 00:31:21 bellona kernel:  [<e19031eb>] plip_bh+0x4a/0x97 [plip]
Aug 14 00:31:21 bellona kernel:  [<c012eb63>] worker_thread+0x18f/0x241
Aug 14 00:31:21 bellona kernel:  [<c0132f07>] kthread+0xb1/0xb5
Aug 14 00:31:21 bellona kernel:  [<c0101199>] kernel_thread_helper+0x5/0xb
Aug 14 00:31:21 bellona kernel: ---------------------------
Aug 14 00:31:21 bellona kernel: | preempt count: 00000001 ]
Aug 14 00:31:21 bellona kernel: | 1 level deep critical section nesting:
Aug 14 00:31:21 bellona kernel: ----------------------------------------
Aug 14 00:31:21 bellona kernel: .. [<c03cf6c7>] .... 
_spin_lock_irqsave+0x10/0x70
Aug 14 00:31:21 bellona kernel: .....[<c01040a1>] ..   ( <= die+0x3f/0x19d)
Aug 14 00:31:21 bellona kernel:
Aug 14 00:31:21 bellona kernel: Code: eb b5 c7 04 24 c8 57 90 e1 e8 6e 
ac 81 de e8 38 08 80
de eb c3 55 89 e5 31 c0 5d c3 55 89 e5 57 56 53 83 ec 08 8b 5d 08 8b 75 
0c <8b> 8b 8c 00 00
00 89 4b 24 0f b7 56 66 8b 43 58 39 c2 77 17 29

I founded out, that in plip_error (drivers/plip.c)
                ENABLE(dev->irq);
is called by before not calling
                DISABLE(dev->irq);
in plip_bh_timeout_error in
        if (error == HS_TIMEOUT) { ...
My opinion is, that ENABLE in plip_error should be called only if the 
error was HS_TIMEOUT too.
That was badness. And what about the oops:
        case PLIP_PK_DONE:
                /* Inform the upper layer for the arrival of a packet. */
                rcv->skb->protocol=plip_type_trans(rcv->skb, dev); <---- 
the skb here is NULL
                netif_rx(rcv->skb);
Should we inform somebody, if skb is NULL?

I don't know if the 2 things have something, that join them (at least, 
they are in plip), so I send it as one e-mail.

Linux bellona 2.6.13-rc5-mm1 #18 SMP PREEMPT Sun Aug 7 17:48:53 CEST 
2005 i686 i686 i386 GNU/Linux

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10


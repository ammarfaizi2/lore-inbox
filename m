Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTEKOe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbTEKOe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:34:58 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:50184 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id S261566AbTEKOe5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:34:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
Date: Sun, 11 May 2003 16:47:31 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305111647.32113.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i see that one on shutdown with a xircom ce3 10/100 16bit pcmcia network card,
driver xirc2ps_cs. the netdevice also never gets free, so the shutdown never
finishs. 2.5.68 also doesn't work, 2.5.67 does work.

rgds
-daniel

irq 3: nobody cared!
Call Trace:
 [<c010d5ff>] handle_IRQ_event+0x93/0x104
 [<c010d607>] handle_IRQ_event+0x9b/0x104
 [<c010dac1>] do_IRQ+0x181/0x2cc
 [<d0839b80>] +0x0/0xa80 [yenta_socket]
 [<c010bfe0>] common_interrupt+0x18/0x20
 [<d0839b80>] +0x0/0xa80 [yenta_socket]
 [<d0836938>] yenta_set_socket+0x144/0x250 [yenta_socket]
 [<d083847e>] +0x55e/0x87e [yenta_socket]
 [<d0836144>] pci_set_socket+0x28/0x34 [yenta_socket]
 [<d0839b80>] +0x0/0xa80 [yenta_socket]
 [<d0888192>] set_socket+0x16/0x1c [pcmcia_core]
 [<d0889d0b>] pcmcia_release_configuration+0xa7/0x110 [pcmcia_core]
 [<d088b018>] CardServices+0x1b8/0x340 [pcmcia_core]
 [<d084bec0>] xirc2ps_cs_driver+0x0/0xa0 [xirc2ps_cs]
 [<d0849268>] xirc2ps_release+0x68/0x94 [xirc2ps_cs]
 [<d084bf60>] +0x0/0xe0 [xirc2ps_cs]
 [<d084a621>] +0x21/0x60 [xirc2ps_cs]
 [<c013cdd5>] sys_delete_module+0x1b5/0x1d8
 [<c0154e5c>] sys_munmap+0x44/0x64
 [<c010b673>] syscall_call+0x7/0xb

handlers:
[<d0849438>] (xirc2ps_interrupt+0x0/0x59c [xirc2ps_cs])
unregister_netdevice: waiting for eth0 to become free. Usage count = 2
unregister_netdevice: waiting for eth0 to become free. Usage count = 2
unregister_netdevice: waiting for eth0 to become free. Usage count = 2
unregister_netdevice: waiting for eth0 to become free. Usage count = 2


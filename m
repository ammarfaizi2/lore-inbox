Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTEYXpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 19:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbTEYXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 19:45:43 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:9643
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263798AbTEYXpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 19:45:41 -0400
Date: Sun, 25 May 2003 19:58:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] irda merges
Message-ID: <20030525235851.GA7891@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/irda-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk18-irda1.patch.bz2

This will update the following files:

 drivers/net/irda/Kconfig            |   21 
 drivers/net/irda/Makefile           |    9 
 drivers/net/irda/ali-ircc.c         |    4 
 drivers/net/irda/donauboe.c         |    4 
 drivers/net/irda/irport.c           |  482 ++++---
 drivers/net/irda/irtty-sir.c        |    9 
 drivers/net/irda/nsc-ircc.c         |    4 
 drivers/net/irda/sir_kthread.c      |    7 
 drivers/net/irda/smc-ircc.c         |   12 
 drivers/net/irda/smsc-ircc2.c       | 2441 ++++++++++++++++++++++++++++++++++++
 drivers/net/irda/smsc-ircc2.h       |  194 ++
 drivers/net/irda/smsc-sio.h         |  100 +
 drivers/net/irda/w83977af_ir.c      |    2 
 include/net/irda/iriap.h            |    2 
 include/net/irda/irlan_common.h     |    2 
 include/net/irda/irlmp_event.h      |   20 
 include/net/irda/irport.h           |    1 
 net/irda/af_irda.c                  |   13 
 net/irda/ircomm/ircomm_core.c       |   36 
 net/irda/ircomm/ircomm_event.c      |   10 
 net/irda/ircomm/ircomm_lmp.c        |   56 
 net/irda/ircomm/ircomm_ttp.c        |   53 
 net/irda/ircomm/ircomm_tty.c        |   21 
 net/irda/ircomm/ircomm_tty_attach.c |   22 
 net/irda/iriap.c                    |  136 +-
 net/irda/iriap_event.c              |   35 
 net/irda/irlan/irlan_common.c       |   14 
 net/irda/irlan/irlan_eth.c          |    8 
 net/irda/irlap.c                    |   16 
 net/irda/irlap_event.c              |    7 
 net/irda/irlap_frame.c              |  185 +-
 net/irda/irlmp.c                    |  171 +-
 net/irda/irlmp_event.c              |   41 
 net/irda/irlmp_frame.c              |   23 
 net/irda/irnet/irnet.h              |    6 
 net/irda/irnet/irnet_irda.c         |   30 
 net/irda/irnet/irnet_ppp.c          |    2 
 net/irda/irttp.c                    |  119 +
 38 files changed, 3655 insertions(+), 663 deletions(-)

through these ChangeSets:

<rusty@rustcorp.com.au> (03/05/25 1.1336)
   [irda] module refcounts in irlan

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.7)
   [PATCH] smsc-ircc2 driver
   
   ir259_smsc-ircc2-6.diff :
   		<Original patch from Daniele Peri>
   	o [FEATURE] New driver smsc-ircc2, improved FIR support

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.6)
   [PATCH] irport fixes
   
   ir259_irport-6.diff :
   	o [CORRECT] fix module ownership in irport
   	o [CORRECT] Properly initialise dev->trans_start in irport
   	o [CORRECT] Add delay to drain the Tx fifo to avoid corrupting
   		last outgoing Tx byte when changing speed
   	o [FEATURE] Safer locking around speed change in irport_hard_xmit()
   	o [FEATURE] Enforce half duplex operation in interrupt handler
   	o [FEATURE] Optimise interrupt handler for latency and I/O ops
   	o [FEATURE] Optimise Tx path in irport_write()
   	o [FEATURE] Add ZeroCopy Rx
   	o [FEATURE] Better debugging in watchdog timeout
   	o [FEATURE] Various other cleanups and comments

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.5)
   [PATCH] Various IrDA drivers
   
   ir259_trans_start-4.diff :
   	o [CORRECT] Properly initialise dev->trans_start in various drivers
   	o [CRITICA] Unregister power management at unload in smc-ircc
   	o [CORRECT] fix module ownership in smc-ircc

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.4)
   [PATCH] owner in irtty-sir
   
   ir259_sir_kthread_Morton-2.diff :
   	o [CORRECT] fix module ownership in irtty-sir
   	o [FEATURE] important comment in sir_kthread

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.3)
   [PATCH] IrLAP address fix
   
   ir257_caddr_mask.diff :
   		<Patch from Jan Kiszka>
   	o [CORRECT] ignore the C/R bit in the LAP connection address.

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.2)
   [PATCH] IrNET crasher
   
   ir257_irnet_bh.diff :
   	o [CRITICA] Replace spin_lock_irqsave() with spin_lock_bh()
   		to be compatible with ppp_generic locking
   	o [CRITICA] Disable call to ppp_unregister_channel()

<jt@bougret.hpl.hp.com> (03/05/20 1.1184.6.1)
   [PATCH] IrDA skb leak fixes
   
   ir259_skb_get-7.diff :
   		<Inspired by patches from Jan Kiszka>
   	o [CORRECT] Fix skb leaks in IrDA state machines
   	o [CORRECT] Fix skb leaks in connect/request error paths
   	o [FEATURE] Fix skb leaks in ASSERT
   	o [FEATURE] Simplify & document skb handling throughout the stack
   	o [FEATURE] other minor cleanups


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTBXSWs>; Mon, 24 Feb 2003 13:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBXSWV>; Mon, 24 Feb 2003 13:22:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5280 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267474AbTBXSUh>; Mon, 24 Feb 2003 13:20:37 -0500
Date: Mon, 24 Feb 2003 10:30:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 401] New: ISAPNP sleeping function called from illegal context
Message-ID: <18250000.1046111447@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=401

           Summary: ISAPNP sleeping function called from illegal context
    Kernel Version: 2.5.62-bk7
            Status: NEW
          Severity: low
             Owner: ambx1@neo.rr.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86
Software Environment:
CONFIG_PCI=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_CARD=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

Problem Description:
2.5.62-bk7 prints this on bootup. Last kernel tried, bk4, doesn't do this.

isapnp: Scanning for PnP cards...
Debug: sleeping function called from illegal context at mm/slab.c:1617
Call Trace:
 [<c0118ccc>] __might_sleep+0x54/0x58
 [<c013d89b>] kmalloc+0x5f/0x140
 [<c01f9633>] pnp_alloc+0x13/0x54
 [<c01fb6ef>] pnp_add_change+0x13/0x84
 [<c01fba76>] pnp_next_config+0x2a/0xcc
 [<c01fbc5c>] pnp_advanced_config+0x144/0x2a8
 [<c01fc2c6>] pnp_auto_config_dev+0x3e/0x44
 [<c01f9b86>] __pnp_add_device+0x18a/0x1ac
 [<c01fee3c>] pnpc_add_card+0x204/0x21c
 [<c010519b>] init+0xc3/0x288
 [<c01050d8>] init+0x0/0x288
 [<c01071f1>] kernel_thread_helper+0x5/0xc

isapnp: Card 'SYM 53C416'
isapnp: Card 'CS4236B'
isapnp: 2 Plug & Play cards detected total



Steps to reproduce:


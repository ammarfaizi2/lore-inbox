Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSLXNaO>; Tue, 24 Dec 2002 08:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSLXNaO>; Tue, 24 Dec 2002 08:30:14 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:43922 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263326AbSLXNaN>;
	Tue, 24 Dec 2002 08:30:13 -0500
Date: Tue, 24 Dec 2002 14:38:09 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: linux.nics@intel.com
Subject: [2.5.53] Freeing alive device
Message-ID: <20021224133809.GA498@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
loading the e100 module (Intel's one)  from the shell (single user mode,
nothing else running, no modules loaded) I see this message:

Freeing alive device cf88e800, eth%d

I added a dump_stack() at the beggining of netdev_finish_unregister()
(in net/core/dev.c). This is the trace:

Intel(R) PRO/100 Network Driver - version 2.1.24-k2
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
Call Trace:
 [<c02498b3>] netdev_finish_unregister+0x33/0xd0
 [<c024efbc>] linkwatch_run_queue+0xbc/0xe0
 [<c024f005>] linkwatch_event+0x25/0x30
 [<c01277e5>] run_workqueue+0x75/0x110
 [<c024efe0>] linkwatch_event+0x0/0x30
 [<c0127448>] worker_thread+0x1f8/0x230
 [<c0116960>] default_wake_function+0x0/0x40
 [<c0116960>] default_wake_function+0x0/0x40
 [<c0127250>] worker_thread+0x0/0x230
 [<c010738d>] kernel_thread_helper+0x5/0x18

Freeing alive device cf88e800, eth%d
e100: eth0: Compaq Fast Ethernet Server Adapter
  Mem:0xec100000  IRQ:10  Speed:0 Mbps  Dx:N/A


HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La Via prosegue senza fine."
	Bilbo Baggins - Il Signore degli Anelli - J.R.R. Tolkien

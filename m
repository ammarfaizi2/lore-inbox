Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUCAJmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUCAJmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:42:36 -0500
Received: from fmr10.intel.com ([192.55.52.30]:10449 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S261191AbUCAJmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:42:20 -0500
Date: Mon, 1 Mar 2004 17:36:22 +0800 (CST)
From: "Zhu, Yi" <yi.zhu@intel.com>
X-X-Sender: chuyee@mazda.sh.intel.com
Reply-To: "Zhu, Yi" <yi.zhu@intel.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [start_kernel] Suggest to move parse_args() before trap_init()
Message-ID: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm not sure it is _correct_ to move parse_args() before trap_init() in
start_kernel(). Is there any potencial dependencies? I did this on my P4 UP
box, it boots OK.

My issue is if the parse_args() runs after trap_init(), the kernel
parameter "lapic" and "nolapic" takes no effect. Because lapic_enable()
is called after init_apic_mappings().


--- init/main.c.orig    2004-03-01 16:54:23.000000000 +0800
+++ init/main.c 2004-03-01 16:54:45.000000000 +0800
@@ -416,11 +416,11 @@

        build_all_zonelists();
        page_alloc_init();
-       trap_init();
        printk("Kernel command line: %s\n", saved_command_line);
        parse_args("Booting kernel", command_line, __start___param,
                   __stop___param - __start___param,
                   &unknown_bootoption);
+       trap_init();
        sort_main_extable();
        rcu_init();
        init_IRQ();


Thanks,
-- 
-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent
Intel Corp.

Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820


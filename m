Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUKOBZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUKOBZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUKOBZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:25:11 -0500
Received: from fsmlabs.com ([168.103.115.128]:23428 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261406AbUKOBRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:17:09 -0500
Date: Sun, 14 Nov 2004 18:16:55 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <41968F16.1080706@aknet.ru>
Message-ID: <Pine.LNX.4.61.0411141759250.3754@musoma.fsmlabs.com>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
 <41968F16.1080706@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Stas Sergeev wrote:

> Zwane Mwaikambo wrote:
> > > 1. Local APIC stopped working. I know
> > Could you please apply the following patch and supply full dmesg?
> Done.
> Does this help?

Yep it does help, we setup the Local APIC earlier than the parameter 
parsing code. Please test the following;

Thanks,
	Zwane

Index: linux-2.6.10-rc1-mm5/init/main.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/init/main.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 main.c
--- linux-2.6.10-rc1-mm5/init/main.c	11 Nov 2004 17:21:39 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/init/main.c	15 Nov 2004 00:58:57 -0000
@@ -453,12 +453,12 @@ asmlinkage void __init start_kernel(void
 	preempt_disable();
 	build_all_zonelists();
 	page_alloc_init();
-	trap_init();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
+	trap_init();
 	sort_main_extable();
 	rcu_init();
 	init_IRQ();

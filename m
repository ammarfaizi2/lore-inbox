Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUJOVkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUJOVkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268483AbUJOVkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:40:35 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50936 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268467AbUJOVkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:40:21 -0400
Date: Fri, 15 Oct 2004 14:40:13 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, akpm@osdl.org
Subject: 2.6.9 kexec patch causes kernel panic during reboot on x86-64
Message-ID: <20041015214013.GA6555@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9 kexec patch adds a call to find_isa_irq_pin in disable_IO_APIC.
But find_isa_irq_pin is marked __init on x86-64, which leads to
kernel panic. This patch should fix it.


H.J.
--- linux-2.6.8/arch/x86_64/kernel/io_apic.c.init	2004-10-14 16:21:44.000000000 -0700
+++ linux-2.6.8/arch/x86_64/kernel/io_apic.c	2004-10-15 14:34:53.615495099 -0700
@@ -332,7 +332,7 @@ static int __init find_irq_entry(int api
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int __init find_isa_irq_pin(int irq, int type)
+static int find_isa_irq_pin(int irq, int type)
 {
 	int i;
 

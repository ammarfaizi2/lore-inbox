Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUJJW5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUJJW5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUJJW5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:57:25 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:6666 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S268536AbUJJW5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:57:23 -0400
Date: Sun, 10 Oct 2004 23:57:17 +0100
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] find_isa_irq_pin can't be __init
Message-ID: <20041010225717.GA27705@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As spotted by one of our Fedora users, we sometimes
oops during shutdown (http://www.roberthancock.com/kerneloops.png)
because disable_IO_APIC() wants to call find_isa_irq_pin(),
which we threw away during init.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.8/arch/i386/kernel/io_apic.c~	2004-10-10 18:54:27.490567168 -0400
+++ linux-2.6.8/arch/i386/kernel/io_apic.c	2004-10-10 18:54:44.660956872 -0400
@@ -745,7 +745,7 @@ static int __init find_irq_entry(int api
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int __init find_isa_irq_pin(int irq, int type)
+static int find_isa_irq_pin(int irq, int type)
 {
 	int i;
 

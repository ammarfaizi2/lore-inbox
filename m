Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVAYS3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVAYS3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVAYS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:29:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:63704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262039AbVAYS3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:29:37 -0500
Date: Tue, 25 Jan 2005 10:28:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-Id: <20050125102834.7e549322.akpm@osdl.org>
In-Reply-To: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
References: <20050125121704.GA22610@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> ACPI: DSDT (v001 ACER   IBIS     0x20020930 MSFT 0x0100000e) @ 0x00000000
>  Built 1 zonelists
>  __iounmap: bad address c00fffd9

Can you please add this?

--- 25/arch/i386/mm/ioremap.c~iounmap-debugging	2005-01-25 10:26:29.448809152 -0800
+++ 25-akpm/arch/i386/mm/ioremap.c	2005-01-25 10:27:07.054092280 -0800
@@ -233,7 +233,8 @@ void iounmap(volatile void __iomem *addr
 		return; 
 	p = remove_vm_area((void *) (PAGE_MASK & (unsigned long __force) addr));
 	if (!p) { 
-		printk("__iounmap: bad address %p\n", addr);
+		printk("iounmap: bad address %p\n", addr);
+		dump_stack();
 		return;
 	}
 
_

>  and:
>  __journal_remove_journal_head: freeing b_committed_data
> 

OK, that might be due to Alex's changes.  Is being crunched on, thanks.

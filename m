Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUGDKNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUGDKNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUGDKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 06:13:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:18147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265492AbUGDKNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 06:13:32 -0400
Date: Sun, 4 Jul 2004 03:12:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix power3 boot
Message-Id: <20040704031218.163f4b8b.akpm@osdl.org>
In-Reply-To: <20040704100407.GE4923@krispykreme>
References: <20040704100407.GE4923@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> @@ -588,7 +590,6 @@ void __init eeh_init(void)
>   	}
>   
>   	/* Enable EEH for all adapters.  Note that eeh requires buid's */
>  -	init_pci_config_tokens();
>   	for (phb = of_find_node_by_name(NULL, "pci"); phb;
>   	     phb = of_find_node_by_name(phb, "pci")) {
>   		unsigned long buid;
> 

That line was already deleted by paulus's "EEH fixes for POWER5 machines
(1/2)" patch, so we end up with the below.


diff -puN arch/ppc64/kernel/eeh.c~ppc64-fix-power3-boot arch/ppc64/kernel/eeh.c
--- 25/arch/ppc64/kernel/eeh.c~ppc64-fix-power3-boot	2004-07-04 03:08:52.772504640 -0700
+++ 25-akpm/arch/ppc64/kernel/eeh.c	2004-07-04 03:08:52.778503728 -0700
@@ -587,6 +587,8 @@ void __init eeh_init(void)
 		return;
 	}
 
+	init_pci_config_tokens();
+
 	ibm_set_eeh_option = rtas_token("ibm,set-eeh-option");
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUGDLfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUGDLfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUGDLfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:35:43 -0400
Received: from ozlabs.org ([203.10.76.45]:63628 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265521AbUGDLfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:35:42 -0400
Date: Sun, 4 Jul 2004 21:33:47 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix power3 boot
Message-ID: <20040704113346.GK4923@krispykreme>
References: <20040704100407.GE4923@krispykreme> <20040704031218.163f4b8b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704031218.163f4b8b.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That line was already deleted by paulus's "EEH fixes for POWER5 machines
> (1/2)" patch, so we end up with the below.1

Oh sorry, I missed that patch. Looks like that patch already added the
required call to init_pci_config_tokens:

 void __init eeh_init(void)
 {
-       struct device_node *phb;
+       struct device_node *phb, *np;
        struct eeh_early_enable_info info;
        char *eeh_force_off = strstr(saved_command_line, "eeh-force-off");

+       init_pci_config_tokens();
+
+       np = of_find_node_by_path("/rtas");
+       if (np == NULL) {
+               printk(KERN_WARNING "EEH: RTAS not found !\n");
+               return;
+       }
+


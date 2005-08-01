Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVHAWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVHAWPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVHAWNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:13:18 -0400
Received: from graphe.net ([209.204.138.32]:60615 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261316AbVHAWCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:02:53 -0400
Date: Mon, 1 Aug 2005 15:02:49 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122933133.7648.141.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508011456390.8188@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net> <1122933133.7648.141.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Richard Purdie wrote:

> cmpxchg_fail_flag_update 1359210189
> 
> That number rapidly increases and so it looks like something is failing
> and looping...

That looks like some trouble with the MMU. The time between pte read and 
write has been shortened through the page fault scalability patches. 

Does this patch fix it?

Index: linux-2.6.13-rc4-mm1/mm/memory.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/mm/memory.c	2005-08-01 12:59:49.000000000 -0700
+++ linux-2.6.13-rc4-mm1/mm/memory.c	2005-08-01 15:02:19.000000000 -0700
@@ -2105,6 +2105,7 @@
 		lazy_mmu_prot_update(entry);
 	} else {
 		inc_page_state(cmpxchg_fail_flag_update);
+		set_pte_at(mm, address, pte, new_entry);
 	}
 
 	pte_unmap(pte);

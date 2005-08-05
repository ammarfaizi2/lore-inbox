Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVHEPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVHEPSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVHEPS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:18:27 -0400
Received: from graphe.net ([209.204.138.32]:8832 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263050AbVHEPR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:17:58 -0400
Date: Fri, 5 Aug 2005 08:17:51 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1123166252.8987.50.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508050817060.28659@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net>  <1122931637.7648.125.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011438010.7888@graphe.net>  <1122933133.7648.141.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011517300.8498@graphe.net>  <1122937261.7648.151.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508031716001.24733@graphe.net>  <1123154825.8987.33.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508040703300.3277@graphe.net> <1123166252.8987.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Richard Purdie wrote:

> I'm at a disadvantage here as the linux mm system is one area I've
> avoided getting too deeply involved with so far. My knowledge is
> therefore limited and I won't know what correct or incorrect behaviour
> would look like.
> 
> We know the the failure case can be identified by the
> cmpxchg_fail_flag_update condition being met. Can you provide me with a
> patch to dump useful debugging information when that occurs?

Well yes simply print out the information available in that context.

Index: linux-2.6.13-rc4-mm1/mm/memory.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/mm/memory.c	2005-08-03 17:02:29.000000000 -0700
+++ linux-2.6.13-rc4-mm1/mm/memory.c	2005-08-05 08:17:14.000000000 -0700
@@ -2104,6 +2104,8 @@
 		update_mmu_cache(vma, address, entry);
 		lazy_mmu_prot_update(entry);
 	} else {
+		printk(KERN_CRIT "cmpxchg fail mm=%p vma=%p addr=%lx write=%d ptep=%p pmd=%p entry=%lx new=%lx\n",
+				mm, vma, address, write_access, pte, pmd, pte_val(entry), pte_val(new_entry));
 		inc_page_state(cmpxchg_fail_flag_update);
 	}
 

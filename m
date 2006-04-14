Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWDNUNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWDNUNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWDNUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:13:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5816 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965145AbWDNUNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:13:16 -0400
Date: Fri, 14 Apr 2006 13:12:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: Implement lookup_swap_cache for migration entries
In-Reply-To: <20060414125320.72599c7e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604141309520.22852@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org> <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
 <20060413222921.2834d897.akpm@osdl.org> <Pine.LNX.4.64.0604141025310.18575@schroedinger.engr.sgi.com>
 <20060414113104.72a5059b.akpm@osdl.org> <Pine.LNX.4.64.0604141143520.22475@schroedinger.engr.sgi.com>
 <20060414121537.11134d26.akpm@osdl.org> <Pine.LNX.4.64.0604141214060.22652@schroedinger.engr.sgi.com>
 <20060414125320.72599c7e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Andrew Morton wrote:

> So we're doing a get_page() on a random page which could be in any state -
> it could be on the freelists, or in the per-cpu pages arrays, it could have
> been reused for something else.

Hmmm... Yes, Ahh! The tree_lock prohibits this sort of thing from 
happening to regular pages. Right.... Yuck this could be expensive to fix.

We are holding the anon_vma lock while remapping migration ptes. So we 
could take the anonvma lock, check to see if the pte is still a migration
pte if so then it cannot change and we can safely increase page 
count.

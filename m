Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVCSUXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVCSUXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCSUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:23:03 -0500
Received: from fmr14.intel.com ([192.55.52.68]:18913 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261751AbVCSUW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:22:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] arch hook for notifying changes in PTE protections bits
Date: Sat, 19 Mar 2005 12:22:20 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943033468DE@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] arch hook for notifying changes in PTE protections bits
Thread-Index: AcUsOPwwc9cXCJepTpiHAdD6Rqj8rQAhC9cg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <davidm@hpl.hp.com>
X-OriginalArrivalTime: 19 Mar 2005 20:22:22.0552 (UTC) FILETIME=[5B828D80:01C52CC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <mailto:davem@davemloft.net> wrote on Friday, March 18,
2005 8:06 PM:

> 
> Take a look at set_pte_at().  You get the "mm", the
> virtual address, the pte pointer, and the new pte value.
> 

Thanks for pointing out the updated interface in 2.6.12-* kernel.  I
think I can overload the arch specific part of set_pte_at(or for that
matter set_pte, as what I need is only pte_t) to always check if we need
to do lazy I/D coherency for IA-64.....but this incurs extra cost for
making a check every time set_pte_at is called.  This new hook,
lazy_mmu_prot_update, though needs to be used only when the permissions
on a valid PTE is changing. For example, at the time of remap or swap,
this API is not called.
  
> What else could you possibly need to track stuff like this
> and react appropriately? :-)
> 

Stuff is there, though the call needs to be made to ensure we are
reacting to it most optimally and correctly.....I guess something
similar to why update_mmu_cache API is still existing in generic part
and not overloading arch specific set_pte_at definition.


-rohit

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVCSUaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVCSUaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVCSUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:30:17 -0500
Received: from palrel13.hp.com ([156.153.255.238]:28545 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261281AbVCSUaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:30:09 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16956.35789.229286.442052@napali.hpl.hp.com>
Date: Sat, 19 Mar 2005 12:30:05 -0800
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <davidm@hpl.hp.com>
Subject: RE: [patch] arch hook for notifying changes in PTE protections bits
In-Reply-To: <01EF044AAEE12F4BAAD955CB75064943033468DE@scsmsx401.amr.corp.intel.com>
References: <01EF044AAEE12F4BAAD955CB75064943033468DE@scsmsx401.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 19 Mar 2005 12:22:20 -0800, "Seth, Rohit" <rohit.seth@intel.com> said:

  Rohit> David S. Miller <mailto:davem@davemloft.net> wrote on Friday,
  Rohit> March 18, 2005 8:06 PM:

  >>  Take a look at set_pte_at().  You get the "mm", the virtual
  >> address, the pte pointer, and the new pte value.


  Rohit> Thanks for pointing out the updated interface in 2.6.12-*
  Rohit> kernel.  I think I can overload the arch specific part of
  Rohit> set_pte_at(or for that matter set_pte, as what I need is only
  Rohit> pte_t) to always check if we need to do lazy I/D coherency
  Rohit> for IA-64.....but this incurs extra cost for making a check
  Rohit> every time set_pte_at is called.  This new hook,
  Rohit> lazy_mmu_prot_update, though needs to be used only when the
  Rohit> permissions on a valid PTE is changing. For example, at the
  Rohit> time of remap or swap, this API is not called.

Careful though: not every PTE has an associated page_map entry.

I agree about your concern about cost.  Accessing the page_map is
expensive (integer division + memory access) and we have to do that in
order to find out if the page is i-cache clean.

	--david

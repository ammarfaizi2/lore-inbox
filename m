Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271527AbTGQRzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271525AbTGQRzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:55:08 -0400
Received: from palrel12.hp.com ([156.153.255.237]:38889 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S271520AbTGQRzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:55:03 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16150.58990.896840.65971@napali.hpl.hp.com>
Date: Thu, 17 Jul 2003 11:09:50 -0700
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: <davidm@hpl.hp.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remove pa->va->pa conversion for efi.acpi
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE548@fmsmsx406.fm.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE548@fmsmsx406.fm.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 17 Jul 2003 10:43:19 -0700, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com> said:

  >> Does ACPI really guarantee that the table is never stored at physical
  >> address 0?  If not, then leaving it as a virtual address might be
  >> safer.  (Yes, I know it's very unlikely for today's system, but at
  >> least on ia64, pfn 0 is normal RAM so it seems at least in principle
  >> possible to store the ACPI table there).

  Matthew> No guarantee that I could find...I suppose this is
  Matthew> technically possible. :) However, considering the ACPI
  Matthew> routines expect a physical address and thus immediately map
  Matthew> it to get the descriptor (either directly with virt_to_phys
  Matthew> or via ioremap), this seems redundant.  Given the mapping
  Matthew> scheme employed, is this still risky?  I'd like to reuse
  Matthew> the same code path for ia32, but don't want to break ia64.

Note that I'm only pointing this out because I thought there were some
NULL-pointer checks.  If it's a physical address, 0 is a valid
address.  If it's an (identity-mapped) kernel address, NULL-pointer
checks are OK.

	--david

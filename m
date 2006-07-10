Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWGJCit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWGJCit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWGJCit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:38:49 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:51073 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1161305AbWGJCis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:38:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] remove empty node at boot time
Date: Sun, 9 Jul 2006 20:38:40 -0600
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com> <200607071726.31646.bjorn.helgaas@hp.com> <20060710093418.be084931.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060710093418.be084931.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607092038.41053.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 18:34, KAMEZAWA Hiroyuki wrote:
> Then, your box has 
> node 0 : cpu x 4, small memory
> node 1 : cpu x 4, small memory
> node 2 : big memory.

Yes.

> if above node 0 and node 1 disappears, it looks there are some bugs in
> cpu detection.

Yes.  Here's the relevant part of the call tree:

setup_arch
  acpi_numa_init
    acpi_numa_arch_fixup
      acpi_online_node_fixup (test available_cpus)
  ... 
  acpi_boot_init
    acpi_table_parse_madt(..., acpi_parse_lsapic, ...)
      acpi_parse_lsapic (increment available_cpus)

Note that we test available_cpus in acpi_online_node_fixup()
before we increment it in acpi_parse_lsapic(), so the inner
loop is never executed.

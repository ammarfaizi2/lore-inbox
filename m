Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161323AbWGJD1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323AbWGJD1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWGJD1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:27:25 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36067 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161321AbWGJD1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:27:23 -0400
Date: Mon, 10 Jul 2006 12:29:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove empty node at boot time
Message-Id: <20060710122925.759c368b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200607092038.41053.bjorn.helgaas@hp.com>
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com>
	<200607071726.31646.bjorn.helgaas@hp.com>
	<20060710093418.be084931.kamezawa.hiroyu@jp.fujitsu.com>
	<200607092038.41053.bjorn.helgaas@hp.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 20:38:40 -0600
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> Yes.  Here's the relevant part of the call tree:
> 
> setup_arch
>   acpi_numa_init
>     acpi_numa_arch_fixup
>       acpi_online_node_fixup (test available_cpus)
>   ... 
>   acpi_boot_init
>     acpi_table_parse_madt(..., acpi_parse_lsapic, ...)
>       acpi_parse_lsapic (increment available_cpus)
> 
> Note that we test available_cpus in acpi_online_node_fixup()
> before we increment it in acpi_parse_lsapic(), so the inner
> loop is never executed.

Hmm...okay, I misunderstood the boot path..
To work with my remove-empty-node patch, parsing lsapic should be done
before SRAT. 
I'd like to fix this. BTW, can we move parsing MADT before SRAT ?

-Kame



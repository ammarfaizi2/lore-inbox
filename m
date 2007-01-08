Return-Path: <linux-kernel-owner+w=401wt.eu-S1750709AbXAHVHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXAHVHb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbXAHVHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:07:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:42530 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXAHVHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:07:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,160,1167638400"; 
   d="scan'208"; a="182799473:sNHT17866779"
Date: Mon, 8 Jan 2007 13:07:13 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-acpi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI bay - 2.6.20-rc3-mm1 hangs on boot
Message-Id: <20070108130713.57f3f351.kristen.c.accardi@intel.com>
In-Reply-To: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
References: <Pine.LNX.4.64.0701051351200.16747@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 14:19:41 +0100 (CET)
Jiri Kosina <jikos@jikos.cz> wrote:

> Hi,
> 
> 2.6.20-rc3-mm1 hangs on boot on my IBM T42p when compiled with ACPI_BAY=y. 
> Below is the trace of two BUGs I get.

Hi,
I was able to duplicate this problem - it only occurs when the bay
driver is built-in, not when the bay driver is compiled as a module.
While I work on the fix for the problem, you can as a temporary workaround
just use ACPI_BAY=m.  By the way, I also found that the bay driver will
not build at all if ACPI_DOCK=n.  Oops.  I will fix that too.

thanks,
Kristen


> 
> When compiled with ACPI_BAY=n, it boots fine.
> 
> The traces are hand-rewritten (no serial console on that machine), so I 
> have omitted the code offsets in the stacktraces.
> 
> ACPI: ACPI Dock Station Driver
> ACPI: \_SB_PCI0.IDE0.SCND.MSTR: found ejectable bay
> ACPI: \_SB_PCI0.IDE0.SCND.MSTR: Adding notify handler
> PM: Adding info for platform:bay.0
> ACPI: Bay [\_SB_.PCI0.IDE0.SCND.MSTR] Added
> BUG: at lib/kref.c:32 kref_get()
> 	kref_get+0x34/0x3b
> 	kobject_get+0xf/0x13
> 	get_bus+0xe/0x1d
> 	bus_add_driver+0x13/0x165
> 	init_waitqueue_head+0x12/0x1e
> 	bay_init+0x57/0x79
> 	find_bay+0x0/0x2c4
> 	init+0x88/0x16d
> 	restore_nocheck+0x12/0x15
> 	init+0x0/0x16d
> 	init+0x0/0x16d
> 	kernel_thread_helper+0x7/0x10
> 	==========
> BUG: at lib/kref.c:32 kref_get()
> 	kref_get+0x34/0x3b
> 	kobject_get+0xf/0x13
> 	kobject_init+0x5d/0x70
> 	kobject_set_name+0x5c/0x92
> 	bus_add_driver+0x50/0x79
> 	bay_init+0x57/0x79
> 	find_bay+0x0/0x2c4
> 	init+0x88/0x16d
> 	init+0x88/0x16d
> 	kernel_thread_helper+0x7/0x10
> 	=========
> 
> -- 
> Jiri Kosina
> 

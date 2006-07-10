Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWGJPkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWGJPkV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWGJPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:40:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:28680 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965053AbWGJPkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:40:20 -0400
Date: Mon, 10 Jul 2006 11:40:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Brown, Len" <len.brown@intel.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFA44@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.44L0.0607101137500.7513-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> Okay, if system_state is off limits, there here is what I've got
> (interesting part is the last 20 lines)
> 
> ACPI: acpi_os_allocate() fixes
> 
> Replace acpi_in_resume with a more general hack
> to check irqs_disabled() on any kmalloc() from ACPI.
> While setting (system_state != SYSTEM_RUNNING) on resume
> seemed more general, Andrew Morton preferred this approach.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=3469
> 
> Make acpi_os_allocate() into an inline function to
> allow /proc/slab_allocators to work.

Another problem with this patch; it doesn't compile.

Along with the other changes to include/acpi/platform/aclinux.h, you need 
to define acpi_size.  The easiest way is to #include <acpi/actypes.h> and 
then remove the unneeded definitions of acpi_cpu_flags and acpi_thread_id.

Alan Stern


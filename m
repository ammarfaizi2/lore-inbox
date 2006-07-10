Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422789AbWGJTPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbWGJTPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWGJTPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:15:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52999 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1422789AbWGJTPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:15:49 -0400
Date: Mon, 10 Jul 2006 15:15:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Brown, Len" <len.brown@intel.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ED008C@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.44L0.0607101513070.5721-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> >... a similar fix needs to be made in
> drivers/acpi/osl.c:acpi_os_wait_semaphore().
> >If interrupts are disabled the timeout argument should be set to 0, so
> that the 
> >routine will call down_trylock() instead of down() or
> schedule_timeout_interruptible().
> 
> We used to have a hack in acpi_os_wait_semaphore():
> 
> if (in_atomic())
> 	timeout = 0;
> 
> But we deleted it upon ACPICA 20060608 when the
> ACPICA locks that were used at interrupt-time were
> converted to be Linux spin-locks.
> 
> Now it is still conceivable that during resume before interrutps are
> re-enabled,
> the PCI interrupt link devices run AML and go to acquire an AML mutex
> with
> a timeout.  However, we are single threaded at that point, so it isn't
> possible for them to acquire the mutex -- timeout or not.
> 
> I don't like the looks of the "workaround" above -- it makes the code
> confusing.
> 
> I'd be open to putting a BUG_ON() in the sleep case if interrupts are
> not enabled.
> 
> Is there another case that you can think of?

I can't give you an answer now; this case was triggered during 
resume-from-disk on my computer at home.

Tonight I'll attach a stack trace to the bug report.  Let's continue 
further discussion there, off-list.

Alan Stern


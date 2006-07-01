Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933092AbWGASDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbWGASDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933150AbWGASDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 14:03:08 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:12859 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S933092AbWGASDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 14:03:05 -0400
Message-ID: <44A6B8CB.3030406@interia.pl>
Date: Sat, 01 Jul 2006 20:02:51 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul
 by rw semaphores
References: <fa.lpmuYQxc6OV7Bh11JMM/FzqVWyY@ifi.uio.no> <44A45F92.8000904@shaw.ca>
In-Reply-To: <44A45F92.8000904@shaw.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-EMID: 45e50acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> That really is a rather horrible design on their part. Who the hell at
> VIA thought this was a good idea?
> 

I have asked them. Answer is: support is in north/south bridge.
This code works fine (of course "clear BM bit for each device" removed):
[...]
	cx = &pr->power.states[ACPI_STATE_C3];
	printk("Begin..\n"); /* Just to be sure */
	preempt_disable();
	local_irq_save(flags);
[...]
	safe_halt();	/* Sync */

	ACPI_FLUSH_CPU_CACHE();

	wrmsrl(MSR_VIA_LONGHAUL, longhaul->val);
	/* Invoke C3 */
	inb(cx->address);
	/* Dummy op - must do something useless after P_LVL3 read */
	t2 = inl(acpi_fadt.xpm_tmr_blk.address);

	local_irq_disable();
[...]
	printk("..End\n");

30 min "hdparm -t", frequency changes at 1s interval.
CPU temperature is changing too.
Checked in Bashmark.

THIS IS WORKING.


------------------------------------------------------------------------
Najkrótsza trasa na wakacje: http://map24.interia.pl


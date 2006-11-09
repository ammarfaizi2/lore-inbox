Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423869AbWKIO6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423869AbWKIO6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423867AbWKIO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:58:14 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:39604 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423869AbWKIO6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:58:14 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 0/2] Oprofile-on-Cell prereqs
Date: Thu, 9 Nov 2006 08:58:11 -0600
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090858.11590.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two patches that provide some prerequisites for the upcoming 
Oprofile-on-Cell patches, which Maynard Johnson will be posting.

These patches are against the 2.6.18-arnd5 tree.

1. cbe_pmu_interrupts.diff
Add routines for managing the Cell PMU interrupts.

The following routines are added to arch/powerpc/platforms/cell/pmu.c:
 cbe_clear_pm_interrupts()
 cbe_enable_pm_interrupts()
 cbe_disable_pm_interrupts()
 cbe_query_pm_interrupts()
 pm_init_IRQ()

This also adds two routines to arch/powerpc/platforms/cell/interrupt.c
to manipulate the IIC_IS and IIC_IR registers:
 iic_clear_pmi_interrupt()
 iic_set_interrupt_routing()

We are still working on how to clean up cbe_clear_pm_interrupts() and
cbe_enable_pm_interrupts() so we hopefully won't need to call the
iic_ routines (and also not need the additions to interrupt.c).

2. export_hrtimer_forward.diff
Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
be built as a module.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/

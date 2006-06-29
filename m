Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWF2JB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWF2JB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWF2JB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:01:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50658 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751812AbWF2JBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:01:25 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: i386 IPI handlers running with hardirq_count == 0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 19:01:17 +1000
Message-ID: <26704.1151571677@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Macro arch/i386/kernel/entry.S::BUILD_INTERRUPT generates the code to
handle an IPI and call the corresponding smp_<name> C code.
BUILD_INTERRUPT does not update the hardirq_count for the interrupted
task, that is left to the C code.  Some of the C IPI handlers do not
call irq_enter(), so they are running in IRQ context but the
hardirq_count field does not reflect this.  For example,
smp_invalidate_interrupt does not set the hardirq count.

What is the best fix, change BUILD_INTERRUPT to adjust the hardirq
count or audit all the C handlers to ensure that they call irq_enter()?


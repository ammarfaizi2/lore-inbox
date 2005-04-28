Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVD1Gp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVD1Gp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVD1Gpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:45:55 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:23447 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261663AbVD1Gpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:45:50 -0400
Date: Thu, 28 Apr 2005 00:48:04 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       tony.luck@intel.com, gregkh@suse.de, hch@infradead.org
Subject: Re: Deferred handling of writes to /proc/irq/xx/smp_affinity
In-Reply-To: <20050427221538.A30702@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0504280039490.12903@montezuma.fsmlabs.com>
References: <20050427221538.A30702@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005, Ashok Raj wrote:

> Hi Andrew and all
> 
> It is safe to re-program rte entries in ioapic only when an intr is pending. 
> Existing code does this incorrectly by reprogamming rte entries immediatly
> when a value is written to /proc/irq/xx/smp_affinity. IRQ_BALANCE code in 
> kernel does this right, but /proc/irq needs to be handled the same way so that 
> user mode irq_balancer wont lock up systems or loose interrupts in the race.
> 
> This is already fixed in ia64, introduced for i386 and x86_64.
> 
> since this touches 3 arch's managing in -mm for trial would be best to make
> sure nothing is broken, before considering for main line.

Ashok, thanks for doing this, i only have minor nitpicks, can we avoid 
the wrapper for irq_desc and just index it directly? And could we use 
static inline functions for MOVE_IRQ and SET_IRQ_INFO macros and use nop 
functions where required.

Thanks,
	Zwane


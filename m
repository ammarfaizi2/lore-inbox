Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWEVSfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWEVSfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWEVSfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:35:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751013AbWEVSff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:35:35 -0400
Date: Mon, 22 May 2006 14:35:34 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cpu hotplug sleeping from invalid context
Message-ID: <20060522183534.GA8920@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.6.17rc4-git9)

echo 0 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu1/online

on my dual-core notebook gets me this:

CPU 1 is now offline
SMP alternatives: switching to UP code
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0799000 soft=c0779000
Initializing CPU#1
BUG: sleeping function called from invalid context at mm/page_alloc.c:945
in_atomic():0, irqs_disabled():1
 <c04500ce> __alloc_pages+0x32/0x2a8
 <c0425577> printk+0x1f/0xaf
 <c060674d> schedule+0xa21/0xa8a
 <c04503a6> get_zeroed_page+0x31/0x3d
 <c040a117> cpu_init+0x10a/0x323
 <c04176f5> start_secondary+0xc/0x3ef
 <c0417afa> cpu_exit_clear+0x22/0x43



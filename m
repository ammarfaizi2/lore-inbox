Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263862AbUEaHfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUEaHfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUEaHfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:35:22 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18556 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263862AbUEaHfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:35:19 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2 mismatched preempt count in arch/i386/kernel/irq.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 May 2004 17:35:08 +1000
Message-ID: <15151.1085988908@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-rc2 (and earlier) arch/i386/kernel/irq.c::do_IRQ() calls
irq_exit() which expands into preempt_enable_no_resched(), amongst
others.  With CONFIG_PREEMPT=y, preempt_enable_no_resched() does
dec_preempt_count().  Where is the corresponding inc_preempt_count?
AFAICT the use of preempt_enable_no_resched() is unbalanced.


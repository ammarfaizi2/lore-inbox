Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVDGKLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVDGKLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVDGKLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:11:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2709 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262411AbVDGKLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:11:19 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Apr 2005 20:10:13 +1000
Message-ID: <13730.1112868613@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
in_atomic() macro thinks that preempt_disable() indicates an atomic
region so calls to __might_sleep() result in a stack trace.
preempt_count() returns 1, no soft or hard irqs are running and no
spinlocks are held.  It looks like there is no way to distinguish
between the use of preempt_disable() in the lock functions (atomic) and
preempt_disable() outside the lock functions (do nothing that might
migrate me).


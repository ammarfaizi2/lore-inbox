Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWHYHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWHYHAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWHYHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:00:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53954 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751034AbWHYHAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:00:16 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: Incorrect alignment assumptions in x86_64 stacktrace
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 Aug 2006 16:59:58 +1000
Message-ID: <13065.1156489198@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc4 arch/x86_64/kernel/stacktrace.c::get_stack_end() incorrectly
assumes that the irqstackptr is IRQSTACKSIZE aligned.

	stack_end = (unsigned long)cpu_pda(cpu)->irqstackptr;
	if (stack_end) {
		stack_start = stack_end & ~(IRQSTACKSIZE-1);

irqstackptr is only guaranteed to be page aligned, not IRQSTACKSIZE
(4*PAGE_SIZE) aligned.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWA0VDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWA0VDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWA0VDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:03:38 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:65411 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932500AbWA0VDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:03:37 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ingo Molnar <mingo@redhat.com>
Subject: boot-time slowdown for measure_migration_cost
Date: Fri, 27 Jan 2006 14:03:27 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271403.27065.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The boot-time migration cost auto-tuning stuff seems to have
been merged to Linus' tree since 2.6.15.  On little one- or
two-processor systems, the time required to measure the
migration costs isn't very noticeable, but by the time we
get to even a four-processor ia64 box, it adds about
30 seconds to the boot time, which seems like a lot.

Is that expected?  Is the information we get really worth
that much?  Could the measurement be done at run-time
instead?  Is there a smaller hammer we could use, e.g.,
flushing just the buffer rather than the *entire* cache?
Did we just implement sched_cacheflush() incorrectly for
ia64?

Only ia64, x86, and x86_64 currently have a non-empty
sched_cacheflush(), and the x86* ones contain only "wbinvd()".
So I suspect that only ia64 sees this slowdown.  But I would
guess that other arches will implement it in the future.

Bjorn

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264776AbUEYFl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbUEYFl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUEYFj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:39:29 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:28034 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264779AbUEYFgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:36:38 -0400
Date: Tue, 25 May 2004 07:35:19 +0200
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200405250535.i4P5ZJo8017583@dbl.q-ag.de>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [RFC] 0/5 rcu lock update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to tackle the rcu scalability problem that Jack Steiner
noticed:
I found three changes that reduce the cache line trashing with
rcu_ctrlblk:
- Use generation numbers instead of the rcu_cpu_mask bitmap for 
  polling in rcu_pending. (patch 1)
- Use a sequence lock to check if a new batch must be started.  Right
  now each cpu acquires the global spinlock and usually notices that
  the batch is already running. (patch 2)
- Hide implementation details - only fields that are accessed by
  rcu_pending need to be visible in <linux/rcupdate.h> (patch 3)
- Preparation for hierarchical bitmap : hide locking (patch 4)
- Add a hierarchical bitmap (patch 5)

The first three patches are IMHO steps in the right direction,
suitable for inclusion. The last two patches are proof of concept
changes.

--
	Manfred

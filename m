Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbSJ1A2S>; Sun, 27 Oct 2002 19:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSJ1A2S>; Sun, 27 Oct 2002 19:28:18 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27612 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262791AbSJ1A2R>; Sun, 27 Oct 2002 19:28:17 -0500
Date: Sun, 27 Oct 2002 16:31:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3128418467.1035736310@[10.10.2.3]>
In-Reply-To: <200210280132.33624.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I'm trying to read your patch 1, fairly unsucessfully
(seems to be a lot more complex that Michael's).

Can you explain pool_lock? It does actually seem to work, but
it's rather confusing ....

build_pools() has a comment above it saying:

+/*
+ * Call pooldata_lock() before calling this function and
+ * pooldata_unlock() after!
+ */

But then you promptly call pooldata_lock inside build_pools
anyway ... looks like it's just a naff comment, but doesn't
help much.

Leaving aside the acknowledged mind-boggling ugliness of 
pooldata_lock(), what exactly is this lock protecting, and when? 
The only thing that actually calls pooldata_lock is build_pools, 
right? And the only other thing that looks at it is sched_balance_exec
via pooldata_is_locked ... can that happen before build_pools
(seems like you're in deep trouble if it does anyway, as it'll
just block). If you really still need to do this, RCU is now
in the kernel ;-) If not, can we just chuck all that stuff?

M.


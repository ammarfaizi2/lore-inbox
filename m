Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUIPXVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUIPXVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIPXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:05:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9917 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268314AbUIPXFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:05:13 -0400
Date: Thu, 16 Sep 2004 16:03:44 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, lse-tech@lists.sourceforge.net,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Message-Id: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
Subject: [PATCH 0/3] lockmeter: fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The first patch in this series is a replacement patch for the prempt-fix
patch I sent earlier this morning.  There was a missing paren in that
previous version.

Adding this to 2.6.9-rc2-mm1 (just after lockmeter-2.patch) fixes the
preempt compile problem on ia64, at least.  However, I then started 
getting a missing symbol for generic_raw_read_trylock.  Hence the second
patch of this series.

(It is the nature of this lockmeter fix for the COOL bits that whenever
a change is made to kernel/spinlock.c, you need to make a correspoding
change to the kernel/lockmeter.c code that parallels spinlock.c. I 
don't see any good way around this.)

Finally, Zwane has suggested making in_lock_functions() an inline.
I sent him and you a simple patch to do that, and if that is applied,
you then need the third patch of this series.

All three of these patches are intended to follow lockmeter-2.patch in
the series.

I compiled lockmeter on/off, preempt on/off (all 4) kernels on ia64.
I'm working on doing that for i386, but my i386 machines are much slower
than an 8-way Altix for doing compiles. :-)  I'll test some of these
as well.

Best Regards,

Ray

raybry@sgi.com

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------

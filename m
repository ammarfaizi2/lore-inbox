Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUHSSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUHSSSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUHSSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:18:23 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30603 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266912AbUHSSSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:18:21 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: 2.6.8 kmem_cache_alloc barfs
Date: Thu, 19 Aug 2004 18:18:20 +0000
Message-Id: <081920041818.4794.4124EEEB0009B419000012BA2200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in 2.6.8 with all features and config options (at least those that will build) with 4GB memory option selected, kmem_cache_alloc crashes when called with requests for 64KB chunks of memory which exceed the kernel address space of 1GB in size rather than returning an out of memory error.  

It is crashing here:

     /* Get colour for the slab, and cal the next value. */

->>>>CRASH!!!        offset = cachep->colour_next;

        cachep->colour_next++;
        if (cachep->colour_next >= cachep->colour)
                cachep->colour_next = 0;
        offset *= cachep->colour_off;
                                                                                
        spin_unlock(&cachep->spinlock);
                                                                                
        if (local_flags & __GFP_WAIT)
                local_irq_enable();


Jeff

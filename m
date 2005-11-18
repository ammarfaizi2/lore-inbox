Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVKRTdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVKRTdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVKRTdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:33:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:39879 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750892AbVKRTdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:33:06 -0500
Message-ID: <437E2C69.4000708@us.ibm.com>
Date: Fri, 18 Nov 2005 11:32:57 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 0/8] Critical Page Pool
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a clustering product that needs to be able to guarantee that the
networking system won't stop functioning in the case of OOM/low memory
condition.  The current mempool system is inadequate because to keep the
whole networking stack functioning, we need more than 1 or 2 slab caches to
be guaranteed.  We need to guarantee that any request made with a specific
flag will succeed, assuming of course that you've made your "critical page
pool" big enough.

The following patch series implements such a critical page pool.  It
creates 2 userspace triggers:

/proc/sys/vm/critical_pages: write the number of pages you want to reserve
for the critical pool into this file

/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
the system is in an emergency state and authorize the kernel to dip into
the critical pool to satisfy critical allocations.

We mark critical allocations with the __GFP_CRITICAL flag, and when the
system is in an emergency state, we are allowed to delve into this pool to
satisfy __GFP_CRITICAL allocations that cannot be satisfied through the
normal means.

Feedback on our approach would be appreciated.

Thanks!

-Matt

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWAYTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWAYTsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAYTsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:48:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54453 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750805AbWAYTsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:48:32 -0500
Subject: [patch 0/9] Critical Mempools
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:39:52 -0800
Message-Id: <1138217992.2092.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
The following is a new patch series designed to solve the same problems as the
"Critical Page Pool" patches that were sent out in December.  I've tried to
incorporate as much of the feedback that I received as possible into this new,
redesigned version.

Rather than inserting hooks directly into the page allocator, I've tried to
piggyback on the existing mempools infrastructure.  What I've done is created
a new "common" mempool allocator for whole pages.  I've also made some changes
to the mempool code to add more NUMA awareness.  Lastly, I've made some
changes to the slab allocator to allow a single mempool to act as the critical
pool for an entire subsystem.  All of these changes should be completely
transparent to existing users of mempools and the slab allocator.

Using this new approach, a subsystem can create a mempool and then pass a
pointer to this mempool on to all its slab allocations.  Anytime one of its
slab allocations needs to allocate memory that memory will be allocated
through the specified mempool, rather than through alloc_pages_node() directly.

Feedback on these patches (against 2.6.16-rc1) would be greatly appreciated.

Thanks!

-Matt


Return-Path: <linux-kernel-owner+w=401wt.eu-S1751676AbWLNSCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWLNSCy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWLNSCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:02:54 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:41889 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbWLNSCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:02:53 -0500
Date: Thu, 14 Dec 2006 10:03:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>
Subject: [PATCH] fix kernel-doc warnings in 2.6.20-rc1
Message-Id: <20061214100340.d1bda392.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kernel-doc warnings in 2.6.20-rc1.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 block/ll_rw_blk.c              |    1 +
 drivers/base/firmware_class.c  |    1 +
 drivers/message/i2o/exec-osm.c |    2 +-
 kernel/relay.c                 |    2 +-
 kernel/workqueue.c             |    4 ++--
 mm/slab.c                      |    1 +
 6 files changed, 7 insertions(+), 4 deletions(-)

--- linux-2620-rc1.orig/kernel/relay.c
+++ linux-2620-rc1/kernel/relay.c
@@ -302,7 +302,7 @@ static struct rchan_callbacks default_ch
 
 /**
  *	wakeup_readers - wake up readers waiting on a channel
- *	@private: the channel buffer
+ *	@work: work struct that contains the the channel buffer
  *
  *	This is the work function used to defer reader waking.  The
  *	reason waking is deferred is that calling directly from write
--- linux-2620-rc1.orig/kernel/workqueue.c
+++ linux-2620-rc1/kernel/workqueue.c
@@ -233,7 +233,7 @@ static void delayed_work_timer_fn(unsign
 /**
  * queue_delayed_work - queue work on a workqueue after delay
  * @wq: workqueue to use
- * @work: delayable work to queue
+ * @dwork: delayable work to queue
  * @delay: number of jiffies to wait before queueing
  *
  * Returns 0 if @work was already on a queue, non-zero otherwise.
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(queue_delayed_work);
  * queue_delayed_work_on - queue work on specific CPU after delay
  * @cpu: CPU number to execute work on
  * @wq: workqueue to use
- * @work: work to queue
+ * @dwork: work to queue
  * @delay: number of jiffies to wait before queueing
  *
  * Returns 0 if @work was already on a queue, non-zero otherwise.
--- linux-2620-rc1.orig/mm/slab.c
+++ linux-2620-rc1/mm/slab.c
@@ -3587,6 +3587,7 @@ out:
  * @cachep: The cache to allocate from.
  * @flags: See kmalloc().
  * @nodeid: node number of the target node.
+ * @caller: return address of caller, used for debug information
  *
  * Identical to kmem_cache_alloc but it will allocate memory on the given
  * node, which can improve the performance for cpu bound structures.
--- linux-2620-rc1.orig/drivers/base/firmware_class.c
+++ linux-2620-rc1/drivers/base/firmware_class.c
@@ -127,6 +127,7 @@ static ssize_t firmware_loading_show(str
 /**
  * firmware_loading_store - set value in the 'loading' control file
  * @dev: device pointer
+ * @attr: device attribute pointer
  * @buf: buffer to scan for loading control value
  * @count: number of bytes in @buf
  *
--- linux-2620-rc1.orig/block/ll_rw_blk.c
+++ linux-2620-rc1/block/ll_rw_blk.c
@@ -2464,6 +2464,7 @@ EXPORT_SYMBOL(blk_rq_map_user);
  * @rq:		request to map data to
  * @iov:	pointer to the iovec
  * @iov_count:	number of elements in the iovec
+ * @len:	I/O byte count
  *
  * Description:
  *    Data will be mapped directly for zero copy io, if possible. Otherwise
--- linux-2620-rc1.orig/drivers/message/i2o/exec-osm.c
+++ linux-2620-rc1/drivers/message/i2o/exec-osm.c
@@ -367,7 +367,7 @@ static int i2o_exec_remove(struct device
 
 /**
  *	i2o_exec_lct_modified - Called on LCT NOTIFY reply
- *	@work: work struct for a specific controller
+ *	@_work: work struct for a specific controller
  *
  *	This function handles asynchronus LCT NOTIFY replies. It parses the
  *	new LCT and if the buffer for the LCT was to small sends a LCT NOTIFY

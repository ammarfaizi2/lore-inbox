Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752551AbWCQHWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbWCQHWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbWCQHWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:22:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:65431 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752551AbWCQHWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:22:42 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:26 +1100
Message-Id: <1060317072126.28614@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 6] md: INIT_LIST_HEAD to LIST_HEAD conversions.
References: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A couple of places we all INIT_LIST_HEAD on a locally declared
variable.  This can be changed to a LIST_HEAD declaration.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c    |    2 +-
 ./drivers/md/raid5.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 18:17:56.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 18:18:19.000000000 +1100
@@ -2895,7 +2895,6 @@ static void autorun_array(mddev_t *mddev
  */
 static void autorun_devices(int part)
 {
-	struct list_head candidates;
 	struct list_head *tmp;
 	mdk_rdev_t *rdev0, *rdev;
 	mddev_t *mddev;
@@ -2904,6 +2903,7 @@ static void autorun_devices(int part)
 	printk(KERN_INFO "md: autorun ...\n");
 	while (!list_empty(&pending_raid_disks)) {
 		dev_t dev;
+		LIST_HEAD(candidates);
 		rdev0 = list_entry(pending_raid_disks.next,
 					 mdk_rdev_t, same_set);
 

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 18:17:57.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 18:18:19.000000000 +1100
@@ -345,7 +345,8 @@ static int resize_stripes(raid5_conf_t *
 	 * at some points in this operation.
 	 */
 	struct stripe_head *osh, *nsh;
-	struct list_head newstripes, oldstripes;
+	LIST_HEAD(newstripes);
+	LIST_HEAD(oldstripes);
 	struct disk_info *ndisks;
 	int err = 0;
 	kmem_cache_t *sc;
@@ -359,7 +360,7 @@ static int resize_stripes(raid5_conf_t *
 			       0, 0, NULL, NULL);
 	if (!sc)
 		return -ENOMEM;
-	INIT_LIST_HEAD(&newstripes);
+
 	for (i = conf->max_nr_stripes; i; i--) {
 		nsh = kmem_cache_alloc(sc, GFP_NOIO);
 		if (!nsh)
@@ -385,7 +386,6 @@ static int resize_stripes(raid5_conf_t *
 	/* OK, we have enough stripes, start collecting inactive
 	 * stripes and copying them over
 	 */
-	INIT_LIST_HEAD(&oldstripes);
 	list_for_each_entry(nsh, &newstripes, lru) {
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_stripe,

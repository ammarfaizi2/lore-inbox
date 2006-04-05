Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWDEACw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWDEACw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWDEACK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:02:10 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:50370
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750967AbWDEABw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:52 -0400
Date: Tue, 4 Apr 2006 17:01:07 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       clameter@sgi.com, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/26] Fix NULL pointer dereference in node_read_numastat()
Message-ID: <20060405000107.GV27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="clameter-sgi.com-re-fw-2.6.16-crashes-when-running.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@sgi.com>

Fix NULL pointer dereference in node_read_numastat()

zone_pcp() only returns valid values if the processor is online.

Change node_read_numastat() to only scan online processors.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.1.orig/drivers/base/node.c
+++ linux-2.6.16.1/drivers/base/node.c
@@ -106,7 +106,7 @@ static ssize_t node_read_numastat(struct
 	other_node = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *z = &pg->node_zones[i];
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for_each_online_cpu(cpu) {
 			struct per_cpu_pageset *ps = zone_pcp(z,cpu);
 			numa_hit += ps->numa_hit;
 			numa_miss += ps->numa_miss;

--

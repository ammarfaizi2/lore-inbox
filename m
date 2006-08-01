Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWHARgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWHARgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWHARgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:36:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2233 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751721AbWHARgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:36:22 -0400
Date: Tue, 1 Aug 2006 19:36:21 +0200
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix vmstat per cpu usage
Message-ID: <20060801173620.GM4995@hasse.suse.de>
MIME-Version: 1.0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="vmstat-fix.diff"
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Blunck <jblunck@suse.de>
Subject: fix vmstat per cpu usage

The per cpu variables are used incorrectly in vmstat.h.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 include/linux/vmstat.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-v2.6.18-rc3/include/linux/vmstat.h
===================================================================
--- linux-v2.6.18-rc3.orig/include/linux/vmstat.h
+++ linux-v2.6.18-rc3/include/linux/vmstat.h
@@ -41,23 +41,23 @@ DECLARE_PER_CPU(struct vm_event_state, v
 
 static inline void __count_vm_event(enum vm_event_item item)
 {
-	__get_cpu_var(vm_event_states.event[item])++;
+	__get_cpu_var(vm_event_states).event[item]++;
 }
 
 static inline void count_vm_event(enum vm_event_item item)
 {
-	get_cpu_var(vm_event_states.event[item])++;
+	get_cpu_var(vm_event_states).event[item]++;
 	put_cpu();
 }
 
 static inline void __count_vm_events(enum vm_event_item item, long delta)
 {
-	__get_cpu_var(vm_event_states.event[item]) += delta;
+	__get_cpu_var(vm_event_states).event[item] += delta;
 }
 
 static inline void count_vm_events(enum vm_event_item item, long delta)
 {
-	get_cpu_var(vm_event_states.event[item]) += delta;
+	get_cpu_var(vm_event_states).event[item] += delta;
 	put_cpu();
 }
 

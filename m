Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCPDcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCPDcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCPDcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:32:14 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21672 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932264AbWCPDcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:32:13 -0500
Date: Thu, 16 Mar 2006 12:30:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [10/19] ia64
Message-Id: <20060316123047.70a31152.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu

under arch/ia64/kernel/.
 module.c  |    2 +-
 smpboot.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fjitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/ia64/kernel/module.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/ia64/kernel/module.c
+++ linux-2.6.16-rc6-mm1/arch/ia64/kernel/module.c
@@ -947,7 +947,7 @@ void
 percpu_modcopy (void *pcpudst, const void *src, unsigned long size)
 {
 	unsigned int i;
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		memcpy(pcpudst + __per_cpu_offset[i], src, size);
 	}
 }
Index: linux-2.6.16-rc6-mm1/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/ia64/kernel/smpboot.c
+++ linux-2.6.16-rc6-mm1/arch/ia64/kernel/smpboot.c
@@ -643,7 +643,7 @@ remove_from_mtinfo(int cpu)
 {
 	int i;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		if (mt_info[i].valid &&  mt_info[i].socket_id ==
 		    				cpu_data(cpu)->socket_id)
 			mt_info[i].valid = 0;
@@ -883,7 +883,7 @@ check_for_mtinfo_index(void)
 {
 	int i;
 	
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		if (!mt_info[i].valid)
 			return i;
 
@@ -901,7 +901,7 @@ check_for_new_socket(__u16 logical_addre
 	int i;
 	__u32 sid = c->socket_id;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (mt_info[i].valid && mt_info[i].proc_fixed_addr == logical_address
 		    && mt_info[i].socket_id == sid) {
 			c->core_id = mt_info[i].core_id;

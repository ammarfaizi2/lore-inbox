Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWCPD2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWCPD2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWCPD2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:28:19 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:43173 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932244AbWCPD2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:28:18 -0500
Date: Thu, 16 Mar 2006 12:26:59 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [6/19] oprofile.
Message-Id: <20060316122659.3e1190c4.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/drivers/oprofile/oprofile_stats.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/drivers/oprofile/oprofile_stats.c
+++ linux-2.6.16-rc6-mm1/drivers/oprofile/oprofile_stats.c
@@ -22,7 +22,7 @@ void oprofile_reset_stats(void)
 	struct oprofile_cpu_buffer * cpu_buf; 
 	int i;
  
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		cpu_buf = &cpu_buffer[i]; 
 		cpu_buf->sample_received = 0;
 		cpu_buf->sample_lost_overflow = 0;
@@ -46,7 +46,7 @@ void oprofile_create_stats_files(struct 
 	if (!dir)
 		return;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		cpu_buf = &cpu_buffer[i]; 
 		snprintf(buf, 10, "cpu%d", i);
 		cpudir = oprofilefs_mkdir(sb, dir, buf);

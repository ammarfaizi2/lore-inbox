Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTEVPkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTEVPkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:40:24 -0400
Received: from holomorphy.com ([66.224.33.161]:29580 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261968AbTEVPkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:40:23 -0400
Date: Thu, 22 May 2003 08:53:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: arch/i386/kernel/mpparse.c warning fixes
Message-ID: <20030522155320.GP29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@digeo.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -prauN mm8-2.5.69-1/arch/i386/kernel/mpparse.c mm8-2.5.69-2/arch/i386/kernel/mpparse.c
--- mm8-2.5.69-1/arch/i386/kernel/mpparse.c	2003-05-22 04:54:48.000000000 -0700
+++ mm8-2.5.69-2/arch/i386/kernel/mpparse.c	2003-05-22 08:06:13.000000000 -0700
@@ -171,7 +171,7 @@ void __init MP_processor_info (struct mp
 
 	num_processors++;
 
-	if (m->mpc_apicid > MAX_APICS) {
+	if (MAX_APICS - m->mpc_apicid <= 0) {
 		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		--num_processors;
@@ -803,7 +803,7 @@ void __init mp_register_lapic (
 	struct mpc_config_processor processor;
 	int			boot_cpu = 0;
 	
-	if (id >= MAX_APICS) {
+	if (MAX_APICS - id <= 0) {
 		printk(KERN_WARNING "Processor #%d invalid (max %d)\n",
 			id, MAX_APICS);
 		return;

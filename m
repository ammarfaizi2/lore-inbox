Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWCPGbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWCPGbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWCPGbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:31:33 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:43227 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932386AbWCPGbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:31:32 -0500
Date: Thu, 16 Mar 2006 15:32:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] for_each_possible_cpu [9/19] i386 fix patch
Message-Id: <20060316153254.9f1ca93b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060316122952.e19f2726.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060316122952.e19f2726.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch for i386 for_each_possible_cpu() includes unnecessary parts...
Sorry..

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/oprofile/nmi_int.c
+++ linux-2.6.16-rc6-mm1/arch/i386/oprofile/nmi_int.c
@@ -123,11 +123,9 @@ static void free_msrs(void)
 {
 	int i;
 	for_each_possible_cpu(i) {
-		if (cpu_msrs[i].counters)
-			kfree(cpu_msrs[i].counters);
+		kfree(cpu_msrs[i].counters);
 		cpu_msrs[i].counters = NULL;
-		if (cpu_msrs[i].controls)
-			kfree(cpu_msrs[i].controls);
+		kfree(cpu_msrs[i].controls);
 		cpu_msrs[i].controls = NULL;
 	}
 }


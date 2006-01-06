Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWAFHS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWAFHS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWAFHS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:18:56 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8842 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932494AbWAFHSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:18:55 -0500
Date: Fri, 6 Jan 2006 08:18:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(percpu_data) and removes dependance against
 NR_CPUS
In-Reply-To: <43BD2406.2040007@cosmosbay.com>
Message-ID: <Pine.LNX.4.61.0601060816330.22809@yvahk01.tjqt.qr>
References: <1135251766.3557.13.camel@pmac.infradead.org>
 <20060105021929.498f45ef.akpm@osdl.org> <43BD2406.2040007@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.6.15/include/linux/percpu.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-edum/include/linux/percpu.h	2006-01-05 14:45:48.000000000 +0100
@@ -18,8 +18,7 @@
 #ifdef CONFIG_SMP
 
 struct percpu_data {
-	void *ptrs[NR_CPUS];
-	void *blkp;
+	void *ptrs[1]; /* real size depends on highest_possible_processor_id() */
 };
 
 /* 


I think we can use *ptrs[0] here.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/

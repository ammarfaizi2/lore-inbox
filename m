Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbTLWAih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLWAig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:38:36 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:41678
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264883AbTLWAiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:38:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Tue, 23 Dec 2003 11:38:21 +1100
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231138.21734.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done a resync and update of my batch scheduling that is also hyper-thread 
aware.

What is batch scheduling? Specifying a task as batch allows it to only use cpu 
time if there is idle time available, rather than having a proportion of the 
cpu time based on niceness.

Why do I need hyper-thread aware batch scheduling?

If you have a hyperthread (P4HT) processor and run it as two logical cpus you 
can have a very low priority task running that can consume 50% of your 
physical cpu's capacity no matter how high priority tasks you are running. 
For example if you use the distributed computing client setiathome you will 
be effectively be running at half your cpu's speed even if you run setiathome 
at nice 20. Batch scheduling for normal cpus allows only idle time to be used 
for batch tasks, and for HT cpus only allows idle time when both logical cpus 
are idle.

This is not being pushed for mainline kernel inclusion, but the issue of how 
to prevent low priority tasks slowing down HT cpus needs to be considered for 
the mainline HT scheduler if it ever gets included. This patch provides a 
temporising measure for those with HT processors, and a demonstrative way to 
handle them in mainline.

Patch available here:
http://ck.kolivas.org/patches/2.6/2.6.0/

Con


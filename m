Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbUKUU3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUKUU3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUU3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:29:44 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:44250 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261785AbUKUU31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:29:27 -0500
Date: Sun, 21 Nov 2004 21:29:23 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-kernel@vger.kernel.org
Subject: Priority Inheritance Test (Real-Time Preemption)
Message-Id: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 From realfeel I wrote a small, simple test to test how well priority
inheritance mechanism works. 

Basicly it samples how long a real-time task have to wait to get into a
protected region while non-real-time tasks also try to get into the
region (a character device). Their "job" in the region is to busy-loop for
1 ms. This ought to mimic how drivers and other parts of the kernel would
work in a real real-time application: Real time tasks using the driver
while non-real-time tasks also use the same driver.

With an ideal PI mutex the time the real-time task has to wait to get the
lock should be between 0 and 1 ms. 0 when the mutex is uncongested and 1
ms when one of the non-real-time tasks just got the mutex.

I tested it on V0.7.26-0 and my own U9.2-priom. Both implementations fails
when the mutex is congested by more than 1 non-real-time task. It works
well enough when there is only one non-real-time task trying to get the
mutex, but as soon as there are more it could look like the real-time task
not always is the first on the wait queue. I.e. sometimes it has to wait 2
ms! With 4 non-real-time tasks the most common is 1-2 ms!

Code, detailed description and data can be found at
 http://www.phys.au.dk/~simlo/Linux/pi_test.tgz

Esben




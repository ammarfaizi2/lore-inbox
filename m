Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVE2O3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVE2O3O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVE2O3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:29:14 -0400
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:22677 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S261325AbVE2O3L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:29:11 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Is wake_up safe on 2.4?
Date: Sun, 29 May 2005 19:58:21 +0530
Message-ID: <689F43A6CF84E541A721C5C3FD5ADECC030B5354@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is wake_up safe on 2.4?
Thread-Index: AcVkXBenM4vVt1jmRWaO4jGYFpghLg==
From: <manoj.sharma@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 May 2005 14:29:09.0002 (UTC) FILETIME=[C67FB6A0:01C5645A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it safe to use wake_up() in 2.4 inside an interrupt handler or in a
spin lock region?

wake_up() uses reshedule_idle() to find an idle cpu for the woken up
task. If it doesn't find any, it checks the current running tasks on all
CPUs and uses goodness value to pick up the best cpu to schedule the
woken up task.  Isn't possible to preempt the current task where
reschedule_idle() is running?

There are plenty of instances in the kernel (2.4) where wake_up() is
being used inside interrupt handler or after taking spin locks. If it
can preempt the task calling wake_up(), how safe is it to use then?



	Manoj



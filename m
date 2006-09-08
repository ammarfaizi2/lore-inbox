Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752224AbWIHFwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbWIHFwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 01:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbWIHFwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 01:52:41 -0400
Received: from [216.152.67.105] ([216.152.67.105]:51724 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1752221AbWIHFwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 01:52:40 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Uses for memory barriers
Date: Thu, 7 Sep 2006 22:52:32 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEGHOEAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <Pine.LNX.4.44L0.0609071549340.6535-100000@iolanthe.rowland.org>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Sep 2006 22:54:56 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Sep 2006 22:55:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Am I correct?  Or are there some easily-explained situations where mb()
> really should be used for inter-CPU synchronization?

	Consider when one CPU does the following:

while(!spinlock_acquire()) relax();
x=shared_value_protected_by_spinlock;

	We need to make sure we do not *read* the protected values (say due to
prefetching) before other CPUs see our write that locks the spinlock.

	DS



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVCGARD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVCGARD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCGARC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:17:02 -0500
Received: from ikar.perftech.si ([195.246.0.20]:34634 "EHLO ikar.perftech.si")
	by vger.kernel.org with ESMTP id S261609AbVCFXtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:49:21 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Samo Pogacnik <pogacsam@s5.net>
Message-Id: <200503070041.17863@pogacsam>
To: linux-kernel@vger.kernel.org
Subject: [patch] irq and softirq handler measurement
Date: Mon, 7 Mar 2005 00:51:38 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-MDRemoteIP: 195.246.28.130
X-Return-Path: pogacsam@s5.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Spam-Report: * -100 USER_IN_WHITELIST From: address is in the user's white-list
X-Spam-Processed: IKAR, Mon, 07 Mar 2005 00:49:16 +0100
X-MDAV-Processed: IKAR, Mon, 07 Mar 2005 00:49:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'd like to propose a modification of the linux kernel, which enables IRQ and
SOFTIRQ handler measurement. The patch currently covers only i386
architecture, but could be extented to other architectures as well.

I tried to measure time spent in mentioned hendler functions, by summarizing
times spent in every part of their execution. This means that a new nested
interrupt ends one part of time measurement for the first (previously 
running) IRQ or SOFTIRQ and starts a new part of time measurement for the
second (newly started) IRQ.
It may not be the most optimal solution (suggestions are most welcome), but
it's been helpfull to me. Measurements may be usefull, for developing
new drivers or if you are optimising your system.

The linux (2.6.0-test11) patch has not been pasted at the end of the
following usage description, because it is quite long, so here is the URL:
        http://friends.s5.net/pogacnik/patch-2.6.0-test11-usage-0.1.

=======================================================
Usage description:

1. Measure IRQ handlers

This option enables measurement of time spent in each IRQ handler.
Measured data is being displayed through the /proc/interrupts file. The CPU
usage mean value for each IRQ handler and the maximum continuous time spent
in each IRQ handler are being calculated for the time elapsed between two
subsequent reads of the /proc/interrupts file.

2. Measure SOFTIRQ handlers
This option enables measurement of time spent in each SOFTIRQ handler.
Measurement includes every tasklet, that is being registered for this measure
through the tasklet_register() function. The tasklet_init() calls register
tasklets automaticaly.
Measured data is being displayed through the /proc/softirqs file. The CPU
usage mean value for each SOFTIRQ handler and the maximum continuous
time spent in each SOFTIRQ handler are being calculated for the time elapsed
between two subsequent reads of the /proc/softirqs file. Additionally the
number of invocations for each SOFTIRQ handler (as well as for each tasklet)
is being displayed through the /proc/softirqs file.

3. The patch
This linux patch allows you to configure the kernel for compilation
without any of the above options.
First read of interrupts (or softirqs) file can not calculate CPU usage
correctly, because there is no previous time reference.
=======================================================

kind regards to all Linux developers, Samo Pogacnik


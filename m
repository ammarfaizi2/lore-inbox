Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUE0Lti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUE0Lti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUE0Lti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:49:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:39428 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261943AbUE0Lth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:49:37 -0400
Subject: 2.6.7-rc1-mm1: revert
	leave-runtime-suspended-devices-off-at-system-resume.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085658551.1998.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 27 May 2004 13:49:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

2.6.7-rc-mm1 includes
"leave-runtime-suspended-devices-off-at-system-resume" which causes
mayor problems when used on my ACPI laptop. After resuming from S3
(STR), both the CardBus and UHCI-HCD bridges won't come up from
suspension, rendering them completely unusable: neither my CardBus NIC,
nor my USB mouse are recognized or functional.

I can easily see this by looking at my Microsoft Intellimouse Explorer
optical mouse: the lights at the bottom of the mouse (used by the
optical sensors) are turned off, which means the device is not being
detected by the USB subsystem.

This behavior causes problems at system shutdown. The system hangs when
the rc.d scripts start stopping "hotplug". The system will hang at that
point without making any further progress since both the CardBus and USB
sybsystems are literally "frozen" (and I can't unload their modules by
hand).

Reverting "leave-runtime-suspend-devices-off-at-system-resume.patch"
fixes the problem for me.

Thanks.


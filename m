Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTHSLbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 07:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTHSLbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 07:31:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2054 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270237AbTHSLbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 07:31:04 -0400
Subject: Device class '3c59x' does not have a release() function, it is
	broken and must be fixed
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Content-Type: text/plain
Message-Id: <1061292661.845.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 13:31:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Whenever I try to unload the 3c59x.ko module from my running
2.6.0-test3-mm3 kernel, I get the following oops:

Device class 'eth0' does not have a release() function, it is broken and
must be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [<c019df4a>] kobject_cleanup+0x4a/0x50
 [<c025778e>] netdev_run_todo+0x10e/0x1f0
 [<d08ec504>] vortex_remove_one+0x24/0x120 [3c59x]
 [<c01a4c3b>] pci_device_remove+0x3b/0x40
 [<c01e51b6>] device_release_driver+0x66/0x70
 [<c01e52f5>] bus_remove_device+0x55/0xa0
 [<c01e3c45>] device_del+0x65/0xa0
 [<c01e3c93>] device_unregister+0x13/0x30
 [<c01a2293>] pci_destroy_dev+0x23/0xd0
 [<c01a243b>] pci_remove_behind_bridge+0x2b/0x40
 [<c020a698>] shutdown_socket+0x88/0x120
 [<c020adc3>] socket_remove+0x13/0x60
 [<c020ae7a>] socket_detect_change+0x6a/0x90
 [<c020aff8>] pccardd+0x158/0x1c0
 [<c011c62a>] preempt_schedule+0x2a/0x50
 [<c011c650>] default_wake_function+0x0/0x30
 [<c02ab586>] ret_from_fork+0x6/0x14
 [<c011c650>] default_wake_function+0x0/0x30
 [<c020aea0>] pccardd+0x0/0x1c0
 [<c010a259>] kernel_thread_helper+0x5/0xc

More information about this can be found at:

http://bugzilla.kernel.org/show_bug.cgi?id=1125

Thanks!


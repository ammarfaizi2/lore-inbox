Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWGGWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWGGWJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWGGWJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:09:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932335AbWGGWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:09:53 -0400
Date: Fri, 7 Jul 2006 18:09:51 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: framebuffer console code triggered might_sleep assertion.
Message-ID: <20060707220951.GA3356@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst printk'ing to both console and serial console, I got this...
(2.6.18rc1)

		Dave


BUG: sleeping function called from invalid context at kernel/sched.c:4438
in_atomic():0, irqs_disabled():1

Call Trace:
 [<ffffffff80271db8>] show_trace+0xaa/0x23d
 [<ffffffff80271f60>] dump_stack+0x15/0x17
 [<ffffffff8020b9f8>] __might_sleep+0xb2/0xb4
 [<ffffffff8029232e>] __cond_resched+0x15/0x55
 [<ffffffff80267eb8>] cond_resched+0x3b/0x42
 [<ffffffff80268c64>] console_conditional_schedule+0x12/0x14
 [<ffffffff80368159>] fbcon_redraw+0xf6/0x160
 [<ffffffff80369c58>] fbcon_scroll+0x5d9/0xb52
 [<ffffffff803a43c4>] scrup+0x6b/0xd6
 [<ffffffff803a4453>] lf+0x24/0x44
 [<ffffffff803a7ff8>] vt_console_print+0x166/0x23d
 [<ffffffff80295528>] __call_console_drivers+0x65/0x76
 [<ffffffff80295597>] _call_console_drivers+0x5e/0x62
 [<ffffffff80217e3f>] release_console_sem+0x14b/0x232
 [<ffffffff8036acd6>] fb_flashcursor+0x279/0x2a6
 [<ffffffff80251e3f>] run_workqueue+0xa8/0xfb
 [<ffffffff8024e5e0>] worker_thread+0xef/0x122
 [<ffffffff8023660f>] kthread+0x100/0x136
 [<ffffffff8026419e>] child_rip+0x8/0x12


-- 
http://www.codemonkey.org.uk

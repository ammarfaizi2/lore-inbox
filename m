Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWCPAQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWCPAQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWCPAQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:16:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24246 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932620AbWCPAQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:16:34 -0500
Date: Wed, 15 Mar 2006 16:16:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: time_interpolator: add __read_mostly
Message-ID: <Pine.LNX.4.64.0603151615500.30203@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer to the current time interpolator and the current list of
time interpolators are typically only changed during bootup. Adding
__read_mostly takes them away from possibly hot cachelines.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16-rc6/kernel/timer.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/timer.c	2006-03-11 14:12:55.000000000 -0800
+++ linux-2.6.16-rc6/kernel/timer.c	2006-03-15 16:13:05.000000000 -0800
@@ -1354,8 +1354,8 @@ void __init init_timers(void)
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
-struct time_interpolator *time_interpolator;
-static struct time_interpolator *time_interpolator_list;
+struct time_interpolator *time_interpolator __read_mostly;
+static struct time_interpolator *time_interpolator_list __read_mostly;
 static DEFINE_SPINLOCK(time_interpolator_lock);
 
 static inline u64 time_interpolator_get_cycles(unsigned int src)

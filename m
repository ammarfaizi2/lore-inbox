Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTJCHk1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTJCHk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:40:27 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:1541 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263553AbTJCHkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:40:23 -0400
Subject: [PATCH] macintosh/adbhid.c REP_DELAY fix (was Re: 2.6.0-test5 -
	stuck keys on iBook)
From: Brice Figureau <brice@tincell.com>
To: cliff white <cliffw@osdl.org>
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030930143149.4930ec9c.cliffw@osdl.org>
References: <20030930143149.4930ec9c.cliffw@osdl.org>
Content-Type: text/plain
Message-Id: <1065166822.7878.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Fri, 03 Oct 2003 09:40:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cliff,

On Tue, 2003-09-30 at 23:31, cliff white wrote:
> Kernel version: latest from ppc.bkbits.net/linuxppc-2.5
> 
> Symptom: keyboard diarrhea - single keypress == 3-7 characters.

Here is a patch that fixes the keyboard problem. The input layer
REP_DELAY (and REP_PERIOD) were changed from jiffies to ms but the adb
was not updated accordingly.

I hope this will help you.

Brice

--- drivers/macintosh/adbhid.c.orig	2003-10-02 22:39:31.112571794 +0200
+++ drivers/macintosh/adbhid.c	2003-10-02 22:40:22.888120863 +0200
@@ -611,8 +611,8 @@
 		/* HACK WARNING!! This should go away as soon there is an utility
 		 * to control that for event devices.
 		 */
-		adbhid[id]->input.rep[REP_DELAY] = HZ/2;   /* input layer default: HZ/4 */
-		adbhid[id]->input.rep[REP_PERIOD] = HZ/15; /* input layer default: HZ/33 */
+		adbhid[id]->input.rep[REP_DELAY] = 500;   /* input layer default: 250 */
+		adbhid[id]->input.rep[REP_PERIOD] = 66;   /* input layer default:  33 */
 	}
 }
 



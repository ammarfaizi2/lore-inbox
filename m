Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUAXW4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUAXW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:56:17 -0500
Received: from smtp07.auna.com ([62.81.186.17]:61423 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S262765AbUAXW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:56:16 -0500
Date: Sat, 24 Jan 2004 23:56:12 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Linux 2.6.2-rc1
Message-ID: <20040124225612.GC4072@werewolf.able.es>
References: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org> (from torvalds@osdl.org on Wed, Jan 21, 2004 at 05:43:53 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.21, Linus Torvalds wrote:
> 
> Ok, this is the next "big merge" with things from Andrew's -mm tree, along
> with a number of new drivers and arch updates.
> 

drivers/i2c/chips/w83781d.c is flooding my syslog with:

Jan 24 23:50:36 werewolf kernel: Starting device update
Jan 24 23:51:09 werewolf last message repeated 11 times
Jan 24 23:52:12 werewolf last message repeated 21 times
Jan 24 23:53:15 werewolf last message repeated 21 times
Jan 24 23:54:18 werewolf last message repeated 21 times

so:

--- linux-2.6.2-rc1/drivers/i2c/chips/w83781d.c.orig	2004-01-24 23:53:02.579206290 +0100
+++ linux-2.6.2-rc1/drivers/i2c/chips/w83781d.c	2004-01-24 23:53:13.862321904 +0100
@@ -1656,7 +1656,6 @@
 	if (time_after
 	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
 	    || time_before(jiffies, data->last_updated) || !data->valid) {
-		pr_debug("Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
 			if ((data->type == w83783s || data->type == w83697hf)

Correct ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc1-jam2 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))

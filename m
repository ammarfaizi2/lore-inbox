Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVBOAcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVBOAcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVBOAcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:32:23 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:25496 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261401AbVBOAcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:32:05 -0500
Date: Tue, 15 Feb 2005 01:31:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@cyclades.com, bernard@blackham.com.au,
       linux-kernel@vger.kernel.org
Subject: Fix pm_message_t in generic code [was Re: PATCH: Address lots of pending pm_message_t changes]
Message-ID: <20050215003150.GA5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes u32 vs. pm_message_t in generic code. No code
changes. Please apply,
								Pavel


--- clean-mm/Documentation/power/devices.txt	2005-02-15 00:34:36.000000000 +0100
+++ linux-mm/Documentation/power/devices.txt	2005-02-15 01:04:09.000000000 +0100
@@ -15,7 +15,7 @@
 
 struct bus_type {
        ...
-       int             (*suspend)(struct device * dev, u32 state);
+       int             (*suspend)(struct device * dev, pm_message_t state);
        int             (*resume)(struct device * dev);
 };
 

--- clean-mm/include/linux/device.h	2005-02-15 00:34:41.000000000 +0100
+++ linux-mm/include/linux/device.h	2005-02-15 01:04:11.000000000 +0100
@@ -111,7 +111,7 @@
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
-	int	(*suspend)	(struct device * dev, u32 state, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
 };
 
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

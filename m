Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVIKLk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVIKLk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVIKLk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:40:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43405 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932409AbVIKLk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:40:27 -0400
Date: Sun, 11 Sep 2005 13:38:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, dwmw2@infradead.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050911113824.GC2742@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <20050910153110.36a44eba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910153110.36a44eba.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  As for pm_register(), there are tons of users remaining.
> 
> Well it would kinda help if people knew what to _do_ about pm_register(). 
> Documentation/pm.txt cheerfully tells everyone how to use it in new code
> and the comment over the pm_register() implementation doesn't say that it's
> deprecated and doesn't tell people what to replace it with.

Well, Doc*/pm.txt seems to say this is "not to use"

Driver Interface -- OBSOLETE, DO NOT USE!
----------------*************************

anyway, if you want a comment "what to do with it", here it is:

---

Tell people not to use pm_register().

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/pm.txt b/Documentation/pm.txt
--- a/Documentation/pm.txt
+++ b/Documentation/pm.txt
@@ -38,6 +38,12 @@ system the associated daemon will exit g
 
 Driver Interface -- OBSOLETE, DO NOT USE!
 ----------------*************************
+
+Note: pm_register(), pm_access(), pm_dev_idle() and friends are
+obsolete. Please do not use them. Instead you should properly hook
+your driver into the driver model, and use its suspend()/resume()
+callbacks to do this kind of stuff.
+
 If you are writing a new driver or maintaining an old driver, it
 should include power management support.  Without power management
 support, a single driver may prevent a system with power management


-- 
if you have sharp zaurus hardware you don't need... you know my address

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbULIKxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbULIKxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULIKxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:53:17 -0500
Received: from gprs215-175.eurotel.cz ([160.218.215.175]:61824 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261503AbULIKxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:53:14 -0500
Date: Thu, 9 Dec 2004 11:53:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE: strange WAIT_READY dependency on APM
Message-ID: <20041209105302.GA1131@elf.ucw.cz>
References: <20041209034438.GF22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209034438.GF22324@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> IDE contains the following strange code:
> 
> <--  snip  -->
> 
> #if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
> #define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
> #else
> #define WAIT_READY      (HZ/10)         /* 100msec - should be instantaneous */
> #endif /* CONFIG_APM || CONFIG_APM_MODULE */
> 
> <--  snip  -->
> 
> On the one hand APM isn't enabled on all laptops.
> On the other hand, this also affects regular PCs with APM support (or 
> using a distribution kernel with APM support).
> 
> The time for the !APM case was already increased from 30msec in 2.4 .
> Isn't there a timeout that is suitable for all cases?

We should probably always make it the "big" timeout. Or put there
HZ/10, and see who screams :-).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

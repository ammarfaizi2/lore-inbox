Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVAJLmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVAJLmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVAJLmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:42:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:51172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262211AbVAJLmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:42:04 -0500
Date: Mon, 10 Jan 2005 03:42:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keventd gives exceptional priority to usermode helpers
Message-ID: <20050110034202.P469@build.pdx.osdl.net>
References: <Pine.LNX.4.61.0501101121370.11128@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501101121370.11128@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Mon, Jan 10, 2005 at 11:28:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> --- usr_A/src/kotd/linux-2.6.8-20041204030200/kernel/kmod.c	2004-12-06 14:28:44.000000000 +0100
> +++ usr_B/src/kotd/linux-2.6.8-20041204030200/kernel/kmod.c	2005-01-06 11:44:04.130600000 +0100
> @@ -165,6 +165,7 @@ static int ____call_usermodehelper(void 
>  
>  	/* We can run anywhere, unlike our parent keventd(). */
>  	set_cpus_allowed(current, CPU_MASK_ALL);
> +        set_user_nice(current, 0);

Seems reasonable.  Although, I don't see a niceval of -20, but -5 on
keventd (workqueues do set_user_nice(-5)).  Also, this patch is
whitespace damaged, should be tab not spaces.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

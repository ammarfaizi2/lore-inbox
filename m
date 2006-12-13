Return-Path: <linux-kernel-owner+w=401wt.eu-S932610AbWLMIAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWLMIAp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWLMIAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:00:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33820 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610AbWLMIAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:00:44 -0500
Date: Wed, 13 Dec 2006 00:00:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proper backlight selection for fbdev drivers
Message-Id: <20061213000029.edd9c91e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 17:59:01 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> Try this patch. This should fix any module/built-in dependencys.

drivers/video/aty/atyfb_base.c: In function 'atyfb_blank':
drivers/video/aty/atyfb_base.c:2817: warning: implicit declaration of function 'machine_is'
drivers/video/aty/atyfb_base.c:2817: error: 'powermac' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:2817: error: (Each undeclared identifier is reported only once
drivers/video/aty/atyfb_base.c:2817: error: for each function it appears in.)

This is i386 build.

#ifdef CONFIG_FB_ATY_BACKLIGHT
	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
#elif defined(CONFIG_FB_ATY_GENERIC_LCD)

It assumes that only pmacs have backlights.

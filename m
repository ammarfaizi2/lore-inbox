Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWARMVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWARMVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWARMVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:21:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030205AbWARMVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:21:21 -0500
Date: Wed, 18 Jan 2006 04:20:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jiri Slaby" <xslaby@fi.muni.cz>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, calin@ajvar.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: SBC EPX does not check/claim I/O ports it uses (2nd
 Edition)
Message-Id: <20060118042051.02fdc4ca.akpm@osdl.org>
In-Reply-To: <20060118121046.15C3122B38B@anxur.fi.muni.cz>
References: <1137520351.14135.40.camel@localhost.localdomain>
	<58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
	<20060118121046.15C3122B38B@anxur.fi.muni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jiri Slaby" <xslaby@fi.muni.cz> wrote:
>
> > static void __exit watchdog_exit(void)
>  But now, you forgot to add release_region in this (exit) function :)?

yup.  That'll give a nice oops reading /proc/ioports after rmmod...


--- devel/drivers/char/watchdog/sbc_epx_c3.c~sbc-epx-does-not-check-claim-i-o-ports-it-uses-2nd-edition-fix	2006-01-18 04:19:58.000000000 -0800
+++ devel-akpm/drivers/char/watchdog/sbc_epx_c3.c	2006-01-18 04:19:58.000000000 -0800
@@ -213,6 +213,7 @@ static void __exit watchdog_exit(void)
 {
 	misc_deregister(&epx_c3_miscdev);
 	unregister_reboot_notifier(&epx_c3_notifier);
+	release_region(EPXC3_WATCHDOG_CTL_REG, 2);
 }
 
 module_init(watchdog_init);
_


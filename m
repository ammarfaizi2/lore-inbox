Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264694AbTFQMDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbTFQMDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:03:31 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60677 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264694AbTFQMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:03:29 -0400
Date: Tue, 17 Jun 2003 16:16:39 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, evil@g-house.de
Subject: Re: 2.5.71 compile error on alpha
Message-ID: <20030617161639.A9777@jurassic.park.msu.ru>
References: <3EEE4A14.4090505@g-house.de> <yw1xhe6pzkzy.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xhe6pzkzy.fsf@zaphod.guide>; from mru@users.sourceforge.net on Tue, Jun 17, 2003 at 01:00:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 01:00:01AM +0200, Måns Rullgård wrote:
> Not looking at the code, I guess you could just remove the definition
> of srmcons_ops from srmcons.c.

No, use appended patch.

Ivan.

--- 2.5.72/arch/alpha/kernel/srmcons.c	Mon Jun 16 16:00:39 2003
+++ linux/arch/alpha/kernel/srmcons.c	Mon Jun 16 16:13:17 2003
@@ -291,6 +291,7 @@ srmcons_init(void)
 		driver->type = TTY_DRIVER_TYPE_SYSTEM;
 		driver->subtype = SYSTEM_TYPE_SYSCONS;
 		driver->init_termios = tty_std_termios;
+		tty_set_operations(driver, &srmcons_ops);
 		err = tty_register_driver(driver);
 		if (err) {
 			put_tty_driver(driver);

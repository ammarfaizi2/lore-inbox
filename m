Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUEKIcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUEKIcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUEKIcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:32:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:48358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262389AbUEKIcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:32:50 -0400
Date: Tue, 11 May 2004 01:32:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Patrice Bouchand <PBouchand@cyberdeck.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ib700wdt watchdog driver for 2.6.6
Message-Id: <20040511013223.2c1eafe8.akpm@osdl.org>
In-Reply-To: <200405101757.58104.PBouchand@cyberdeck.com>
References: <200405101757.58104.PBouchand@cyberdeck.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrice Bouchand <PBouchand@cyberdeck.com> wrote:
>
> --- ./ib700wdt.c.orig   2004-05-10 08:57:54.000000000 +0200
>  +++ ./ib700wdt.c        2004-05-10 08:44:50.000000000 +0200
>  @@ -135,7 +135,7 @@
>   ibwdt_ping(void)
>   {
>          /* Write a watchdog value */
>  -       outb_p(wd_times[wd_margin], WDT_START);
>  +       outb_p(wd_margin, WDT_START);
>   }

The patch certainly looks sensible, but what about ibwdt_close() and
ibwdt_notify_sys()?  They're doing

		outb_p(wd_times[wd_margin], WDT_STOP);

which also seems peculiar.

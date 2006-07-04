Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWGDAuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWGDAuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWGDAun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:50:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751307AbWGDAun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:50:43 -0400
Date: Mon, 3 Jul 2006 17:50:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: awe64 isa pnp ALSA problems since 2.6.17
Message-Id: <20060703175032.843ed1fb.akpm@osdl.org>
In-Reply-To: <20060703223128.GA2423@pul.manty.net>
References: <20060630205703.GA2840@pul.manty.net>
	<s5hd5cmtx61.wl%tiwai@suse.de>
	<20060703223128.GA2423@pul.manty.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 00:31:28 +0200
Santiago Garcia Mantinan <manty@manty.net> wrote:

> > The patch should fix the error above.
> 
> I have applied your patch, did a make mrproper and then compiled again, I'm
> still getting the very same message:
> 
> setup_irq: irq handler mismatch
>  <c0123883> setup_irq+0xe5/0xfb  <c01bfcb5> pnp_test_handler+0x0/0x6
>  <c0123904> request_irq+0x6b/0x8b  <c01bfe75> pnp_check_irq+0xb8/0x12f
>  <c01bfcb5> pnp_test_handler+0x0/0x6  <c01c085b> pnp_assign_irq+0xd7/0xf4
>  <c01c0aed> pnp_assign_resources+0x1bc/0x23a  <c01c0bcc>

This has been addressed in Linus's current tree, via:

                if (request_irq(*irq, pnp_test_handler,
                                IRQF_DISABLED|IRQF_PROBE_SHARED, "pnp", NULL))

in drivers/pnp/resource.c.

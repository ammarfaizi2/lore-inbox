Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVCHSSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVCHSSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVCHSSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:18:30 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:39566
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261478AbVCHSSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:18:14 -0500
Date: Tue, 8 Mar 2005 10:17:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: Fix suspend/resume problems with b44
Message-Id: <20050308101739.371968be.davem@davemloft.net>
In-Reply-To: <20050308094655.GA16775@elf.ucw.cz>
References: <20050308094655.GA16775@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 10:46:55 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> @@ -1934,6 +1936,9 @@
>  	if (!netif_running(dev))
>  		return 0;
>  
> +	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
> +		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
> +

This is a hard error and means that bringup of the chip
will totally fail.  It definitely deserves something harder
than a printk(), but unfortunately ->resume() has no way
to cleanly fail.


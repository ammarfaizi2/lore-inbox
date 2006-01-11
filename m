Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWAKSZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWAKSZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWAKSZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:25:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbWAKSZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:25:55 -0500
Date: Wed, 11 Jan 2006 10:25:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nils Rennebarth <nils.rennebarth@packetalarm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e100 in 2.6.15 fails unless irqpoll ist used
Message-Id: <20060111102536.5d91fd92.akpm@osdl.org>
In-Reply-To: <43C50ED4.3090707@packetalarm.com>
References: <43C50ED4.3090707@packetalarm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nils Rennebarth <nils.rennebarth@packetalarm.com> wrote:
>
> An upgrade from 2.6.14.3 to 2.6.15 on my testmachine disabled my network cards: 
>  no packets are sent or received.
> 
>  There is the following in dmesg:
> 
>  usbcore: registered new driver usbfs
>  usbcore: registered new driver hub
>  USB Universal Host Controller Interface driver v2.3
>  irq 11: nobody cared (try booting with the "irqpoll" option)
>    [<c012ae21>] __report_bad_irq+0x31/0x77
>    [<c012aef4>] note_interrupt+0x75/0x99
>    [<c012a9f0>] __do_IRQ+0x65/0x91
>  ...
> 
>  Rebooting with irqpoll will make the network cards work. The above message will 
>  appeare nonetheless.

This means that your IRQ routing broke and the card's interrupt requests
are not getting through.

This is likely to be an ACPI regression.  Please raise a report at
bugzilla.kernel.org, generate full `dmesg -s 1000000' output for both
2.6.14.3 and for 2.6.15 and attach them to the report, thanks.

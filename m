Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVAEBFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVAEBFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVAEBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:05:51 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9911 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262157AbVAEBFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:05:41 -0500
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
In-Reply-To: <41DAE8CC.3010904@gaisler.com>
References: <41DAE8CC.3010904@gaisler.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104877702.17166.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:01:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 19:04, Jiri Gaisler wrote:
> +            if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
> +			tty->flip.work.func((void *)tty);
> +			if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
> +				printk(KERN_WARNING "TTY_DONT_FLIP set\n");
> +				return;
> +			}

This code is broken. Please copy the fixes from the other
drivers/serial/*.c files as you've copied a bug from the reference code.
There are some other small cleanups in the base code that are worth
adding too in particular removing direct (ab)use of tty->flip. because
that will be changing some time in the future (when I finish debugging
the tty layer mess)



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754391AbWKMKOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbWKMKOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbWKMKOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:14:21 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:1983 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1754388AbWKMKOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L8PfE0k0BYDR2RYx9MlHBjtPZevPayYNsOJH4OklmT3xKuVPKBoQDb310IVeEJJn1s5mdyoQyY9t9KI2kBB/5Hl/4MlnD7NrmIrB8NJK8Gd4UwKoE5Zc/aWVLQSwQMQ6RY4wF0OpF3HKjXk7oJ+OQ/BZ9zGbii2mjbYzrwui/Wk=
Message-ID: <602211f80611130212u2a00f9ayd722e170372212fc@mail.gmail.com>
Date: Mon, 13 Nov 2006 11:12:53 +0100
From: "Romano Giannetti" <romano.giannetti@gmail.com>
To: "Pete Zaitcev" <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: pcmcia: patch to fix pccard_store_cis
In-Reply-To: <20061103160247.GB11160@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061001122107.9260aa5d.zaitcev@redhat.com>
	 <20061002003138.GB16938@isilmar.linta.de>
	 <1159794094.8246.2.camel@localhost>
	 <20061103160247.GB11160@dominikbrodowski.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry if you receive this message two times. Problems with the stupid
autodisclaimer signature of my institution).

>
> Does it work again (after re-copying the cis file to /lib/firmware) when
> you use this patch?
>
> Thanks,
>         Dominik
>
> From 4bb59569454f09e8bfc3a0f7bbdef46ccc7a51e0 Mon Sep 17 00:00:00 2001
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Date: Fri, 3 Nov 2006 10:54:00 -0500
> Subject: [PATCH] pcmcia: start over after CIS override
>
> When overriding the CIS, re-start the configuration of the card from
> scratch. Reported and debugged by Fabrice Bellet <fabrice@bellet.info>
>

Mr Dominik, all,

                I tried your patch on top of the kernel 2.6.17.13 that
came with ubuntu
        edgy (and had sufficient trouble with it, I do not know if I'll be able
        to try with a recent kernel.). This message is in copy to akpm which
        asked me a report on the same problem.

        I applied your patch and this one:
        http://lkml.org/lkml/2006/10/1/179

        but the kernel continues to ignore the second function of my card.
        Moreover, now the modem does not work even with the dear old cardmgr:

        [17179741.804000] pcmcia: registering new device pcmcia1.1
        [17179741.844000] 1.1: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
        [17179741.992000] setup_irq: irq handler mismatch
        [17179741.992000]  <c0139e82> setup_irq+0x102/0x110
<c0223250> serial8250_interrupt+0x0/0xf0
        [17179741.992000]  <c0139f29> request_irq+0x99/0xb0
<c0223195> serial8250_startup+0x415/0x440
        [17179741.992000]  <c021ec58> uart_startup+0x48/0x130
<c021fa3f> uart_open+0xbf/0x410
        [17179741.992000]  <c0160a13> cdev_get+0x23/0x60  <c020eba1>
tty_open+0x161/0x310
        [17179741.992000]  <c0160ace> chrdev_open+0x6e/0x140
<c0160a60> chrdev_open+0x0/0x140
        [17179741.992000]  <c0156924> __dentry_open+0xb4/0x1e0
<c0156b05> nameidata_to_filp+0x35/0x40
        [17179741.992000]  <c0156b60> do_filp_open+0x50/0x60
<c0156805> get_unused_fd+0x45/0xb0
        [17179741.992000]  <c0156bba> do_sys_open+0x4a/0xe0
<c0156c8c> sys_open+0x1c/0x20
        [17179741.992000]  <c0102dbb> sysenter_past_esp+0x54/0x79

        Mr Morton, do you still think I should open a bug in bugzilla? Even if I
        have not tested a newer kernel? It seems to me that nothing has changed
        over there, and this _is_ a regression (from 2.6.13, even).

        Romano

        PS: can anyone point me to a tutorial on howto install a new kernael
        easily on ubuntu? The procedure they point to (creating deb package,
        installing, etc) are quite cumbersome. Anyway, I will try.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUKJBPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUKJBPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKJBPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:15:49 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:32678 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261395AbUKJBPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:15:44 -0500
Subject: Re: [PATCH] remove explicit k_name use in atmel_cs.c, bt3c_cs.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110005941.GA9336@apps.cwi.nl>
References: <20041110005941.GA9336@apps.cwi.nl>
Content-Type: text/plain
Date: Wed, 10 Nov 2004 02:15:18 +0100
Message-Id: <1100049318.25879.13.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -uprN -X /linux/dontdiff a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
> --- a/drivers/bluetooth/bt3c_cs.c	2004-08-26 22:05:15.000000000 +0200
> +++ b/drivers/bluetooth/bt3c_cs.c	2004-11-10 01:23:01.000000000 +0100
> @@ -489,13 +489,10 @@ static int bt3c_hci_ioctl(struct hci_dev
>  
>  static struct device *bt3c_device(void)
>  {
> -	static char *kobj_name = "bt3c";
> -
>  	static struct device dev = {
>  		.bus_id = "pcmcia",
>  	};
> -	dev.kobj.k_name = kmalloc(strlen(kobj_name) + 1, GFP_KERNEL);
> -	strcpy(dev.kobj.k_name, kobj_name);
> +	kobject_set_name(&dev.kobj, "bt3c");
>  	kobject_init(&dev.kobj);
>  
>  	return &dev;

The part for the bt3c_cs driver is fine with me and I have no problem if
Andrew picks this up and sends it to Linus for final inclusion. Once the
PCMCIA subsystem if fully integrated into the device model this will go
away anyway.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>



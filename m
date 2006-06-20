Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWFTFXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWFTFXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFTFWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964995AbWFTFWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:15 -0400
Date: Mon, 19 Jun 2006 22:22:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 14/20] chardev: GPIO for SCx200 & PC-8736x: add
 platform_device for use w dev_dbg
Message-Id: <20060619222213.3e8d18b7.akpm@osdl.org>
In-Reply-To: <44944B7F.8070104@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944B7F.8070104@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:35:43 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 14/20. patch.pdev-pc8736x
> 
> Adds platform-device to (just introduced) driver, and uses it to
> replace many printks with dev_dbg() etc.  This could trivially be
> merged into previous patch, but this way matches better with the
> corresponding patch that does the same change to scx200_gpio.
> 
> 
>  static int __init pc8736x_gpio_init(void)
>  {
>  	int r, rc;
>  
> -	printk(KERN_DEBUG NAME " initializing\n");
> +        pdev = platform_device_alloc(DEVNAME, 0);
> +        if (!pdev)
> +                return -ENOMEM;
> +
> +        rc = platform_device_add(pdev);
> +        if (rc) {
> +                platform_device_put(pdev);
> +                return -ENODEV;
> +        }
> +        dev_info(&pdev->dev, "NatSemi pc8736x GPIO Driver Initializing\n");

The whitespace is all screwed up here.  Use hard tabs.

It's simplest if I edit all the diffs.

<does that>


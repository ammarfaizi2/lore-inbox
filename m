Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbSJTUPi>; Sun, 20 Oct 2002 16:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbSJTUPi>; Sun, 20 Oct 2002 16:15:38 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10112 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264640AbSJTUPh>;
	Sun, 20 Oct 2002 16:15:37 -0400
Date: Sun, 20 Oct 2002 13:24:22 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Hu Gang <hugang@soulinfo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH]1/2: fix power manager recall problem.
In-Reply-To: <20021019200104.650ba8bc.hugang@soulinfo.com>
Message-ID: <Pine.LNX.4.44.0210201322010.963-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> first the we call device suspend it suspend pci device and other device, but when we call pm_send_all to pm_suspend, it retry to suspend pci device, here is the real problem. 

> This patch can fix it. Please apply.
...

> +			char *name = dev->bus->name;
> +			pr_debug("bus is %s\n", name);
> +			if (strncmp(name, "pci", 3) ==  0) {
> +				pr_debug("skip pci bus\n");
> +				continue;
> +			}


This is a hack. the pm_* interface should not be used, as it cannot 
guarantee proper ordering when shutting down or resuming devices. If you 
experience problems, please remove the pm_send callbacks and make the 
drivers adhere to the new power management interface.

Thanks,

	-pat


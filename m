Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbTIJWcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTIJWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:32:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62981 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265872AbTIJWXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:23:06 -0400
Date: Wed, 10 Sep 2003 23:22:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910232257.N30046@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030910201124.GA11449@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910201124.GA11449@elf.ucw.cz>; from pavel@ucw.cz on Wed, Sep 10, 2003 at 10:11:26PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:11:26PM +0200, Pavel Machek wrote:
> pcmcia_socket_dev_suspend() still expects to receive it, but I do not
> see any place where it is generated. Should it be killed from
> device.h? And these 6 places fixed?

I've already fixed many of them, but I've introduced some others.

PPC people need to answer this:

> ./arch/ppc/ocp/ocp-driver.c:            if (level == SUSPEND_SAVE_STATE && ocp_dev->driver->save_state)

Fix pending merging:

> ./arch/arm/mach-sa1100/neponset.c:      if (level == SUSPEND_SAVE_STATE ||

These two will be gone shortly:

> ./drivers/pcmcia/i82092.c:      return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
> ./drivers/pcmcia/sa1111_generic.c:      return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);

These two are already gone:

> ./drivers/serial/8250_pci.c:                    serial8250_suspend_port(priv->line[i], SUSPEND_SAVE_STATE);
> ./drivers/serial/core.c:        case SUSPEND_SAVE_STATE:

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core

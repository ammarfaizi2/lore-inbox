Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTJRSHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTJRSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:07:32 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:10624 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261784AbTJRSH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:07:27 -0400
Date: Sat, 18 Oct 2003 20:05:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aviram Jenik <aviram@beyondsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp in test8 fails with intel-agp and i830
Message-ID: <20031018180551.GB461@elf.ucw.cz>
References: <200310152347.04263.aviram@beyondsecurity.com> <20031016202105.GL1659@openzaurus.ucw.cz> <200310181717.04001.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310181717.04001.aviram@beyondsecurity.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am not sure which of the two modules causes the problem, I can only load 
> them both. Unfortunately, without those modules the vaio laptop can only give 
> 640x480, so this is not much of a workaround...

With vesafb, you should be able to get any resultion you want at
60Hz. Which is okay, because you have LCD.

> To summarize:
> If the intel-agp and i830 modules are not loaded during startup, suspend via 
> echo 4 > /proc/acpi/sleep and restore work beautifully. If those modules 
> _are_ loaded, and X is running, resume reboots.

Okay, 

static int agp_intel_resume(struct pci_dev *pdev)
{
        struct agp_bridge_data *bridge = pci_get_drvdata(pdev);

        if (bridge->driver == &intel_generic_driver)
                intel_configure();
        else if (bridge->driver == &intel_845_driver)
                intel_845_configure();

        return 0;
}

intel_agp tries to implement resume, try to put printk("something");
mdelay(1000); in it and debug it this way.

drivers/char/drm/i830_drv driver is apparently using DMA _and_  has no
suspend/resume support. That looks dangerous to me, perhaps you'll
need to implement those, too.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

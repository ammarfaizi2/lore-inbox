Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUEOGFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUEOGFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbUEOGFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:05:33 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:13834 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262418AbUEOGFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:05:25 -0400
Date: Sat, 15 May 2004 08:06:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Perry Gilfillan <perrye@gilfillan.org>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: Any one using i2c-voodoo3 module on the 2.6 kernel?
Message-Id: <20040515080616.7587dc68.khali@linux-fr.org>
In-Reply-To: <40A424D3.7060006@gilfillan.org>
References: <40A424D3.7060006@gilfillan.org>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I'd like to start looking at the 2.6 kernel.  At this point it
> does not seem that the i2c-voodoo3 module is loading correctly.  The
> module is totaly silent in the logs, so I can't offer any immediate
> list of symptoms, except to say I can find no reference to it in the
> sysfs and proc directories.

It happens that I have an old Voodoo 3000 graphics card lying in a box
somewhere, so I thought I would try and plug it, and see what happens.

I was able to load the i2c-voodoo3 driver (Linux 2.6.6-rc3) and it seems
to work for me. I have the following line in the logs:

voodoo3 smbus 0000:01:00.0: Using Banshee/Voodoo3 I2C device at e8964000

After loading i2c-dev, "i2cdetect -l" sees two i2c busses on the card,
and I can use i2cdetect, i2cdump etc. So it seems to work fine.

I suspect that you have another driver requesting the card, such has a
framebuffer driver. The 2.4 driver doesn't request the device so no
conflict happens. The 2.6 driver does request it, because it is
considered Bad (TM) to use a device without requesting it. This probably
means that the i2c-voodoo3 driver should me merged into the framebuffer
driver, much like it was done for matroxfb and radeonfb. This also makes
sense because the framebuffer driver can use the DDC channel (which is
no more than I2C, renamed) to retrieve information about the monitor and
adapt its output. But this also raises the problem that people may want
to access the i2c busses without loading the full framebuffer driver...

> The call to pci_module_init returns zero. Replacing that with a call
> to pci_register_driver yeilds a one, but this may not be
> representative, since pci_register_driver always returns a non-zero
> value.

I'm not very qualified about PCI stuff, but this could confirm my
suspicion above.

> I'd appreciate any advice on where to look first, and where in sysfs
> to look for evidence that the module loaded correctly.

See what is done in proc/dump/i2cbusses.c (lm_sensors package). Looks
like you should point your shell to /sys/class/i2c-dev. This suggests
that you have actually loaded i2c-dev.

> Has anyone used the Banshee or Voodoo3 card with the i2c-voodoo3
> module in the 2.6 kernel with success?

Yes ;) although I didn't do anything useful with it after that.

-- 
Jean Delvare
http://khali.linux-fr.org/

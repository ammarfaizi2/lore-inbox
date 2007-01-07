Return-Path: <linux-kernel-owner+w=401wt.eu-S932513AbXAGLaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbXAGLaO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXAGLaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:30:14 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:4232 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932513AbXAGLaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:30:13 -0500
Date: Sun, 7 Jan 2007 12:30:13 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org,
       "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-Id: <20070107123013.097c1f23.khali@linux-fr.org>
In-Reply-To: <20070105232913.GU20714@stusta.de>
References: <20061219041315.GE6993@stusta.de>
	<20070105095233.4ce72e7e.khali@linux-fr.org>
	<20070105232913.GU20714@stusta.de>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sat, 6 Jan 2007 00:29:13 +0100, Adrian Bunk wrote:
> While looking at the code, I also noted the following:
> 
> quirk_sis_96x_compatible() is pretty useless since all it does is to set 
> a static variable that is only used in a printk().
> 
> quirk_sis_96x_compatible() was added with:
> 
> 
>     2003/05/13 13:48:50-07:00 mhoffman
>     [PATCH] i2c: Add SiS96x I2C/SMBus driver
>     
>     This patch adds support for the SMBus of SiS96x south
>     bridges.  It is based on i2c-sis645.c from the lm sensors
>     project, which never made it into an official kernel and
>     was anyway mis-named.
>     
>     This driver works on my SiS 645/961 board vs w83781d.
> 
> 
> It's usage in
> 
> 
> static void __init quirk_sis_503_smbus(struct pci_dev *dev)
> {
>        if (sis_96x_compatible)
>                quirk_sis_96x_smbus(dev);
> }
> 
> 
> Was removed in
> 
> 
> Author: torvalds <torvalds>
> Date:   Thu Oct 30 19:03:38 2003 +0000
> 
>     Stop SIS 96x chips from lying about themselves.
>     
>     Some machines with the SIS 96x southbridge have it set up
>     to claim it is a SIS 503 chip. That breaks irq routing logic
>     among other things. Fix it properly by making everybody aware
>     of the duplicity.
> 
> 
> Was this intentional (and quirk_sis_96x_compatible() should be removed), 
> or is this a bug that should be fixed?

I noticed this too in April 2006, see:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/016016.html

Quoting myself back then:
"The whole sis_96x_compatible stuff looks superfluous now. It was used
before 2.6.0-test10, but we could certainly get rid of it now."

I do not think there is a bug here, or someone would have complained by
now. Note though that I do not have a SiS-based motherboard to test on.
Mark may be able to help with testing.

Thanks,
-- 
Jean Delvare

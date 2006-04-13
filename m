Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDMO7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDMO7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWDMO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:59:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1546 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750826AbWDMO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:59:00 -0400
Date: Thu, 13 Apr 2006 15:57:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again if probe was unsuccessful
Message-ID: <20060413145756.GA29959@flint.arm.linux.org.uk>
Mail-Followup-To: Rene Herman <rene.herman@keyaccess.nl>,
	Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
	ALSA devel <alsa-devel@alsa-project.org>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de> <443E5AAD.5040800@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443E5AAD.5040800@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:05:33PM +0200, Rene Herman wrote:
> Not honouring/passing up probe() method error returns, not even -ENODEV, 
> makes some sense for discoverable busses such as PCI where you at least 
> have a driver independent bus_id sitting in /sys/devices/pci* that you 
> can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
> to a device, but not much sense for the platform bus. Platform devices 
> only "exist" (in /sys/devices/platform) due to the driver creating them 
> itself and keeping them after failing a probe means that directory 
> becomes an enumeration of the drivers we loaded, rather than a view of 
> what's present in the system.

Incorrect.  In some circumstances, they may be created by architecture
support code, and might be created and destroyed dynamically by
architecture support code.

> The driver model crowd did not seem exceedingly interested in the 
> problem though:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2

Incorrect summary.  The ALSA use model of the driver model doesn't fit
with the driver model use model.  It's not that we're not interested
in it - it's that it's perverted to the way driver model folk intend
the subsystem to work, and the way that platform devices are used on
some architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

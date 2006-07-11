Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWGKL1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWGKL1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWGKL1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:27:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42631 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751049AbWGKL1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:27:50 -0400
Date: Tue, 11 Jul 2006 13:27:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
       jgarzik@pobox.com, yi.zhu@intel.com, jketreno@linux.intel.com,
       netdev@vger.kernel.org, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
Message-ID: <20060711112721.GA1618@elf.ucw.cz>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <44B29C8A.8090405@intel.com> <20060710.114717.44959528.davem@davemloft.net> <1152557518.4874.79.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152557518.4874.79.camel@laptopd505.fenrus.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >> Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
> > > >> (not as a module). Unfortunately, such configuration does not work,
> > > >> because these drivers need a firmware, and it can't be loaded by
> > > >> userspace loader when userspace is not running.
> > > > 
> > > > False, initramfs...
> > > 
> > > which would warrant some extra documentation in Kconfig explaining that this 
> > > driver needs initramfs with firmware for it to work when compiled in the 
> > > kernel. A link to the ipw2x00 documentation might also help.
> > 
> > Besides, the initramfs runs long after the driver init routine
> > runs which is when the firmware needs to be available.
> 
> .. unless you use sysfs to do a fake hotunplug + replug the device, at
> which point the driver init routine runs again.

Ouch, nice trick. But how do I actually pull it up? There's nothing
that looks like allowing that in /sys:

root@amd:/sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0# ls
broken_parity_status  config  irq         power/     subsystem@
uevent
bus@                  device  local_cpus  resource   subsystem_device
vendor
class                 enable  modalias    resource0  subsystem_vendor
root@amd:/sys/devices/pci0000:00/0000:00:1e.0/0000:02:02.0#

I tried going to bus/drivers/ and unbind/rebind ipw2200 driver; that
does not work. I tried echo 0 > enable; echo 1 > enable, but no trick,
either.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

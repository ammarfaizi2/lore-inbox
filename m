Return-Path: <linux-kernel-owner+w=401wt.eu-S964932AbXADQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbXADQyR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXADQyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:54:16 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:1969 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964932AbXADQyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:54:16 -0500
Date: Thu, 4 Jan 2007 17:54:12 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg KH <greg@kroah.com>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [i2c] Why to I2c drivers not autoload like other PCI devices?
Message-Id: <20070104175412.76ebce25.khali@linux-fr.org>
In-Reply-To: <20070104055128.GA8115@kroah.com>
References: <20070103165020.4b277ebc@freekitty>
	<20070104005600.GA25712@kroah.com>
	<20070103172916.7f9ca11a@freekitty>
	<20070104055128.GA8115@kroah.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 21:51:28 -0800, Greg KH wrote:
> On Wed, Jan 03, 2007 at 05:29:16PM -0800, Stephen Hemminger wrote:
> > On Wed, 3 Jan 2007 16:56:00 -0800
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Wed, Jan 03, 2007 at 04:50:20PM -0800, Stephen Hemminger wrote:
> > > > Is there some missing magic (udev rule?) that keeps i2c device modules
> > > > from loading? For example: the Intel i2c-i801 module ought to get loaded
> > > > automatically on boot up since it has a set of PCI id's that generate
> > > > the necessary module aliases. It would be better if I2C device's autoloaded
> > > > like other PCI devices.
> > > 
> > > No, it should autoload, if it has a MODULE_DEVICE_TABLE() in it.  In
> > > fact, the i2c-i801 autoloads on one of my machines just fine.  Are you
> > > sure your pci ids match properly?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > This laptop is running Ubuntu Edgy (6.10) and it doesn't autoload.
> > Everything works fine if I manually load the module with modprobe.
> > 
> > This device should match:
> > 
> > 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
> > 00: 86 80 da 27 01 00 80 02 02 00 05 0c 00 00 00 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: a1 18 00 00 00 00 00 00 00 00 00 00 cf 10 88 13
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
> > 
> > This driver modinfo:
> > 
> > filename:       /lib/modules/2.6.20-rc3/kernel/drivers/i2c/busses/i2c-i801.ko
> 
> What does:
> 	modprobe --show-depends `cat /sys/bus/pci/0000:00:1f.3/modalias`
> show?

Greg really means:
	modprobe --show-depends `cat /sys/bus/pci/devices/0000:00:1f.3/modalias`
and same for the other commands below.

> 
> Is it different from:
> 	modprobe --config /dev/null --show-depends `cat /sys/bus/pci/0000:00:1f.3/modalias`
> ?
> 
> > author:         Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>
> > description:    I801 SMBus driver
> > license:        GPL
> > vermagic:       2.6.20-rc3 mod_unload PENTIUMM 4KSTACKS 
> > depends:        i2c-core
> > alias:          pci:v00008086d00002413sv*sd*bc*sc*i*
> > alias:          pci:v00008086d00002423sv*sd*bc*sc*i*
> > alias:          pci:v00008086d00002443sv*sd*bc*sc*i*
> > alias:          pci:v00008086d00002483sv*sd*bc*sc*i*
> > alias:          pci:v00008086d000024C3sv*sd*bc*sc*i*
> > alias:          pci:v00008086d000024D3sv*sd*bc*sc*i*
> > alias:          pci:v00008086d000025A4sv*sd*bc*sc*i*
> > alias:          pci:v00008086d0000266Asv*sd*bc*sc*i*
> > alias:          pci:v00008086d000027DAsv*sd*bc*sc*i*       <------- should match
> 
> Yeah, I would think so.  What does:
> 	cat /sys/bus/pci/0000:00:1f.3/modalias
> show?
> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c


-- 
Jean Delvare

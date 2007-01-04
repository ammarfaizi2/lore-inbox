Return-Path: <linux-kernel-owner+w=401wt.eu-S932197AbXADR6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXADR6a (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbXADR63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:58:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40262 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197AbXADR63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:58:29 -0500
Date: Thu, 4 Jan 2007 09:54:12 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [i2c] Why to I2c drivers not autoload like other PCI devices?
Message-ID: <20070104095412.16ac9f53@localhost>
In-Reply-To: <20070104175412.76ebce25.khali@linux-fr.org>
References: <20070103165020.4b277ebc@freekitty>
	<20070104005600.GA25712@kroah.com>
	<20070103172916.7f9ca11a@freekitty>
	<20070104055128.GA8115@kroah.com>
	<20070104175412.76ebce25.khali@linux-fr.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 17:54:12 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 3 Jan 2007 21:51:28 -0800, Greg KH wrote:
> > On Wed, Jan 03, 2007 at 05:29:16PM -0800, Stephen Hemminger wrote:
> > > On Wed, 3 Jan 2007 16:56:00 -0800
> > > Greg KH <greg@kroah.com> wrote:
> > > 
> > > > On Wed, Jan 03, 2007 at 04:50:20PM -0800, Stephen Hemminger wrote:
> > > > > Is there some missing magic (udev rule?) that keeps i2c device modules
> > > > > from loading? For example: the Intel i2c-i801 module ought to get loaded
> > > > > automatically on boot up since it has a set of PCI id's that generate
> > > > > the necessary module aliases. It would be better if I2C device's autoloaded
> > > > > like other PCI devices.
> > > > 
> > > > No, it should autoload, if it has a MODULE_DEVICE_TABLE() in it.  In
> > > > fact, the i2c-i801 autoloads on one of my machines just fine.  Are you
> > > > sure your pci ids match properly?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > This laptop is running Ubuntu Edgy (6.10) and it doesn't autoload.
> > > Everything works fine if I manually load the module with modprobe.
> > > 
> > > This device should match:
> > > 
> > > 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
> > > 00: 86 80 da 27 01 00 80 02 02 00 05 0c 00 00 00 00
> > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > 20: a1 18 00 00 00 00 00 00 00 00 00 00 cf 10 88 13
> > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
> > > 
> > > This driver modinfo:
> > > 
> > > filename:       /lib/modules/2.6.20-rc3/kernel/drivers/i2c/busses/i2c-i801.ko
> > 
> > What does:
> > 	modprobe --show-depends `cat /sys/bus/pci/0000:00:1f.3/modalias`
> > show? 
> 
> Greg really means:
> 	modprobe --show-depends `cat /sys/bus/pci/devices/0000:00:1f.3/modalias`
> and same for the other commands below.


Ahak
$ modprobe --show-depends `cat /sys/bus/pci/devices/0000:00:1f.3/modalias`
WARNING: Not loading blacklisted module i2c_i801
FATAL: Module pci:v00008086d000027DAsv000010CFsd00001388bc0Csc05i00 not found.

And the blacklist entry is:

# causes failure to suspend on HP compaq nc6000 (Ubuntu: #10306)
blacklist i2c_i801

Looks like Ubuntu decided to wallpaper over a problem rather than fixing it

Return-Path: <linux-kernel-owner+w=401wt.eu-S1750847AbXADBdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXADBdT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXADBdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:33:18 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:38560 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbXADBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:33:18 -0500
Date: Wed, 3 Jan 2007 17:29:16 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: Why to I2c drivers not autoload like other PCI devices?
Message-ID: <20070103172916.7f9ca11a@freekitty>
In-Reply-To: <20070104005600.GA25712@kroah.com>
References: <20070103165020.4b277ebc@freekitty>
	<20070104005600.GA25712@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007 16:56:00 -0800
Greg KH <greg@kroah.com> wrote:

> On Wed, Jan 03, 2007 at 04:50:20PM -0800, Stephen Hemminger wrote:
> > Is there some missing magic (udev rule?) that keeps i2c device modules
> > from loading? For example: the Intel i2c-i801 module ought to get loaded
> > automatically on boot up since it has a set of PCI id's that generate
> > the necessary module aliases. It would be better if I2C device's autoloaded
> > like other PCI devices.
> 
> No, it should autoload, if it has a MODULE_DEVICE_TABLE() in it.  In
> fact, the i2c-i801 autoloads on one of my machines just fine.  Are you
> sure your pci ids match properly?
> 
> thanks,
> 
> greg k-h

This laptop is running Ubuntu Edgy (6.10) and it doesn't autoload.
Everything works fine if I manually load the module with modprobe.

This device should match:

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
00: 86 80 da 27 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 18 00 00 00 00 00 00 00 00 00 00 cf 10 88 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00

This driver modinfo:

filename:       /lib/modules/2.6.20-rc3/kernel/drivers/i2c/busses/i2c-i801.ko
author:         Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>
description:    I801 SMBus driver
license:        GPL
vermagic:       2.6.20-rc3 mod_unload PENTIUMM 4KSTACKS 
depends:        i2c-core
alias:          pci:v00008086d00002413sv*sd*bc*sc*i*
alias:          pci:v00008086d00002423sv*sd*bc*sc*i*
alias:          pci:v00008086d00002443sv*sd*bc*sc*i*
alias:          pci:v00008086d00002483sv*sd*bc*sc*i*
alias:          pci:v00008086d000024C3sv*sd*bc*sc*i*
alias:          pci:v00008086d000024D3sv*sd*bc*sc*i*
alias:          pci:v00008086d000025A4sv*sd*bc*sc*i*
alias:          pci:v00008086d0000266Asv*sd*bc*sc*i*
alias:          pci:v00008086d000027DAsv*sd*bc*sc*i*       <------- should match
alias:          pci:v00008086d0000269Bsv*sd*bc*sc*i*
alias:          pci:v00008086d0000283Esv*sd*bc*sc*i*
alias:          pci:v00008086d00002930sv*sd*bc*sc*i*

Table in drivers/i2c/busses/i2c-i801.c

static struct pci_device_id i801_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_3) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_3) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_2) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_3) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_3) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_3) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_4) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_16) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },                <------ should match
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_6) },
	{ 0, }
};

MODULE_DEVICE_TABLE (pci, i801_ids);




-- 
Stephen Hemminger <shemminger@osdl.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbUKLO4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUKLO4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKLO4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:56:36 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:36999 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262539AbUKLOy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:54:29 -0500
Date: Fri, 12 Nov 2004 14:54:28 +0000
From: Karel Kulhavy <clock@twibright.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/bus/i2c is missing
Message-ID: <20041112145428.GB19924@beton.cybernet.src>
References: <2E314DE03538984BA5634F12115B3A4E01BC4072@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC4072@email1.mitretek.org>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 09:41:47AM -0500, Piszcz, Justin Michael wrote:
> Ah, the documentation is outdated; I no longer have /proc/bus/i2c
> either.  You may need to update the other software that used
> /proc/bus/i2c, as it should now use /sys/bus/i2c.
> 
> You are correct, <*> I2C support should encompass the i2c_core.
> 
> In addition, you may want to install lm_sensors and run the
> sensors-detect script, which will help detect all the required modules
> necessary for your hardware.
> 
> Curious, what are you trying to get working with I2C that involves the
> parallel port?

A free technology hardware i2c <-> parport adaptor powered from the parallel
port featuring optical isolation.

Now I have (hopefully - according to some measurements) working airwire
prototype and a known working other board with pcf8591 chip that measures
temperature.

As soon as the adaptor is verified to run flawlessly, it will be redesigned
into a PCB and the result published under GPL in the same style as Ronja
Twister http://ronja.twibright.com/twister/index.php

I have already written the driver for it (added type=6 into i2c-parport.c and
extended the struct adapter_parm .init entry with .init2 and .init3 because the
hardware requires lines d0-d7, init and /autofd to be set to electrical H
simultaneously for the electronics to work) and now I am trying to make it
find the pcf8591 chip connected to it and read some data.

Cl<
> 
> -----Original Message-----
> From: Karel Kulhavy [mailto:clock@twibright.com] 
> Sent: Friday, November 12, 2004 9:37 AM
> To: Piszcz, Justin Michael
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: /proc/bus/i2c is missing
> 
> On Fri, Nov 12, 2004 at 09:22:46AM -0500, Piszcz, Justin Michael wrote:
> > You need the core i2c modules loaded.
> 
> I have "<*> I2C support" and "<*> I2C device interface" switched on in
> make
> menuconfig (non-modular). I skimmed through the whole I2C support
> submenu
> and didn't find any i2c core. Just i2c core debugging messages, but it
> isn't
> probably what you mean.
> 
> Which option in make menuconfig is i2c_core?
> 
> And btw I found this:
> root@oberon:/usr/src/linux-2.6.8.1-patched/drivers/i2c/busses# find
> /sys/bus/i2c/sys/bus/i2c
> /sys/bus/i2c/drivers
> /sys/bus/i2c/drivers/pcf8591
> /sys/bus/i2c/drivers/lm85
> /sys/bus/i2c/drivers/lm85/0-002e
> /sys/bus/i2c/drivers/eeprom
> /sys/bus/i2c/drivers/eeprom/0-0052
> /sys/bus/i2c/drivers/eeprom/0-0050
> /sys/bus/i2c/drivers/dev_driver
> /sys/bus/i2c/drivers/i2c_adapter
> /sys/bus/i2c/devices
> /sys/bus/i2c/devices/0-002e
> /sys/bus/i2c/devices/0-0052
> /sys/bus/i2c/devices/0-0050
> 
> Isn't it what the documentation talks about as /proc/bus/i2c? Or is it
> something different?
> 
> Cl<
> > 
> > $ lsmod
> > Module                  Size  Used by
> > adm1021                12092  0
> > i2c_piix4               5648  0
> > i2c_sensor              2912  1 adm1021
> > i2c_dev                 7776  0
> > i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev
> > 
> > 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Karel Kulhavy
> > Sent: Friday, November 12, 2004 9:12 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: /proc/bus/i2c is missing
> > 
> > Hello
> > 
> > linux 2.6.8.1
> > 
> > I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my
> /dev
> > (previously, only i2c-0 was there):
> > 
> > 	clock@oberon:~$ ls /dev/i2* 
> > 	/dev/i2c-0  /dev/i2c-1
> > 	
> > 	/dev/i2c:
> > 	0  1
> > 
> > /usr/src/linux/Documentation/i2c says "You can
> > examine /proc/bus/i2c to see what number corresponds to which
> adapter."
> > I don't have any /proc/i2c:
> > 
> > 	clock@oberon:~$ ls /proc/i2c
> > 	ls: /proc/i2c: No such file or directory
> > 
> > However, I have /proc:
> > 	clock@oberon:~$ ls /proc
> > 	             devices      mtrr
> > 	             diskstats    net
> > 	             dma          partitions
> > 	             driver       pci
> > 	             execdomains  scsi
> > 	             filesystems  self
> > 	             fs           slabinfo
> > 	             ide          stat
> > 	             interrupts   swaps
> > 	  [...]      iomem        sys
> > 	             ioports      sysrq-trigger
> > 	             irq          sysvipc
> > 	             kallsyms     tty
> > 	             kcore        uptime
> > 	             kmsg         version
> > 	             loadavg      vmstat
> > 	             locks
> > 	  buddyinfo  mdstat
> > 	  bus        meminfo
> > 	  cmdline    misc
> > 	  config.gz  modules
> > 	  cpuinfo    mounts
> > 
> > How can I make /proc/i2c appear?
> > 
> > Cl<
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

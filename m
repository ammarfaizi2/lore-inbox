Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUKLOnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUKLOnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKLOnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:43:00 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:63891 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262545AbUKLOlu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:41:50 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-7.tower-45.messagelabs.com!1100270509!7297310!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: /proc/bus/i2c is missing
Date: Fri, 12 Nov 2004 09:41:47 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4072@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/bus/i2c is missing
Thread-Index: AcTIxSFZSQ828/HuQ7WIEcvpjrud1gAADdCQ
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Karel Kulhavy" <clock@twibright.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, the documentation is outdated; I no longer have /proc/bus/i2c
either.  You may need to update the other software that used
/proc/bus/i2c, as it should now use /sys/bus/i2c.

You are correct, <*> I2C support should encompass the i2c_core.

In addition, you may want to install lm_sensors and run the
sensors-detect script, which will help detect all the required modules
necessary for your hardware.

Curious, what are you trying to get working with I2C that involves the
parallel port?

-----Original Message-----
From: Karel Kulhavy [mailto:clock@twibright.com] 
Sent: Friday, November 12, 2004 9:37 AM
To: Piszcz, Justin Michael
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/bus/i2c is missing

On Fri, Nov 12, 2004 at 09:22:46AM -0500, Piszcz, Justin Michael wrote:
> You need the core i2c modules loaded.

I have "<*> I2C support" and "<*> I2C device interface" switched on in
make
menuconfig (non-modular). I skimmed through the whole I2C support
submenu
and didn't find any i2c core. Just i2c core debugging messages, but it
isn't
probably what you mean.

Which option in make menuconfig is i2c_core?

And btw I found this:
root@oberon:/usr/src/linux-2.6.8.1-patched/drivers/i2c/busses# find
/sys/bus/i2c/sys/bus/i2c
/sys/bus/i2c/drivers
/sys/bus/i2c/drivers/pcf8591
/sys/bus/i2c/drivers/lm85
/sys/bus/i2c/drivers/lm85/0-002e
/sys/bus/i2c/drivers/eeprom
/sys/bus/i2c/drivers/eeprom/0-0052
/sys/bus/i2c/drivers/eeprom/0-0050
/sys/bus/i2c/drivers/dev_driver
/sys/bus/i2c/drivers/i2c_adapter
/sys/bus/i2c/devices
/sys/bus/i2c/devices/0-002e
/sys/bus/i2c/devices/0-0052
/sys/bus/i2c/devices/0-0050

Isn't it what the documentation talks about as /proc/bus/i2c? Or is it
something different?

Cl<
> 
> $ lsmod
> Module                  Size  Used by
> adm1021                12092  0
> i2c_piix4               5648  0
> i2c_sensor              2912  1 adm1021
> i2c_dev                 7776  0
> i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev
> 
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Karel Kulhavy
> Sent: Friday, November 12, 2004 9:12 AM
> To: linux-kernel@vger.kernel.org
> Subject: /proc/bus/i2c is missing
> 
> Hello
> 
> linux 2.6.8.1
> 
> I insmoded i2c-parport and pcf8591 modules and i2c-1 appeared in my
/dev
> (previously, only i2c-0 was there):
> 
> 	clock@oberon:~$ ls /dev/i2* 
> 	/dev/i2c-0  /dev/i2c-1
> 	
> 	/dev/i2c:
> 	0  1
> 
> /usr/src/linux/Documentation/i2c says "You can
> examine /proc/bus/i2c to see what number corresponds to which
adapter."
> I don't have any /proc/i2c:
> 
> 	clock@oberon:~$ ls /proc/i2c
> 	ls: /proc/i2c: No such file or directory
> 
> However, I have /proc:
> 	clock@oberon:~$ ls /proc
> 	             devices      mtrr
> 	             diskstats    net
> 	             dma          partitions
> 	             driver       pci
> 	             execdomains  scsi
> 	             filesystems  self
> 	             fs           slabinfo
> 	             ide          stat
> 	             interrupts   swaps
> 	  [...]      iomem        sys
> 	             ioports      sysrq-trigger
> 	             irq          sysvipc
> 	             kallsyms     tty
> 	             kcore        uptime
> 	             kmsg         version
> 	             loadavg      vmstat
> 	             locks
> 	  buddyinfo  mdstat
> 	  bus        meminfo
> 	  cmdline    misc
> 	  config.gz  modules
> 	  cpuinfo    mounts
> 
> How can I make /proc/i2c appear?
> 
> Cl<
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbTLIMlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265523AbTLIMll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:41:41 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:38567 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265520AbTLIMld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:41:33 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Sebastian Kaps <seb-keyword-linux.637a6e@toyland.sauerland.de>
Subject: Re: sensors vs 2.6
Date: Tue, 9 Dec 2003 07:41:31 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200312090258.01944.gene.heskett@verizon.net> <m3zne21dsw.fsf@toyland.sauerland.de>
In-Reply-To: <m3zne21dsw.fsf@toyland.sauerland.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312090741.31290.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.57.120] at Tue, 9 Dec 2003 06:41:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 05:33, Sebastian Kaps wrote:
>Hi Gene!
>
>On Tue, 9 Dec 2003 02:58:01 -0500 you wrote:
>> kernel, 2.6.0-test11, and have dilligently searched the /proc and
>> /sys directories, and seem to have come up blank.
>
>I have configured "I2C support", "I2C device interface", "Intel
> PIIX4" and "Winbond ...". I get all sensor readings in
> /sys/bus/i2c/devices/*, e.g.:

I have this:
-----------------------
[root@coyote linux-2.6]# grep I2C .config
# I2C support
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
# I2C Algorithms
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# I2C Hardware Bus support
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set
# I2C Hardware Sensors Chip support
CONFIG_I2C_SENSOR=y
----------------
and this:
-----------------
[root@coyote linux-2.6]# grep SENSORS .config
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_EEPROM=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_W83781D=y
---------------------
set for a Biostar M7VIB mobo.  It all works for 2.4.

No errors were noted during the build other than the advansys 
deprecated "check_region" calls that have been noted here previously.

But:
--------------------
[root@coyote linux-2.6]# tree /sys/bus/i2c/devices/
/sys/bus/i2c/devices/
|-- 0-0050 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0050
|-- 0-0051 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0051
|-- 0-0052 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0052
|-- 0-0053 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0053
|-- 0-0054 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0054
|-- 0-0055 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0055
|-- 0-0056 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0056
|-- 0-0057 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0057
|-- 0-0061 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0061
|-- 1-0050 -> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0050
`-- 1-0051 -> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0051

11 directories, 0 files
-----------------------
And ALL of that is related to the various eeproms in the system.  
Mostly on my bt979 card.

To back out and do a tree on /sys/devices gets me 171 directories and 
583 files, none of which are named 'input_fan1'.

So obviously something didn't get built, and it looks like its the 
winbond stuff.  The question is why?  Is there some method that can 
be used to interrogate the kernel and determine if the stuff is 
actually in there?

>,----
>
>| # cat /sys/bus/i2c/devices/0-002d/fan_input1
>| 5400
>
>`----

No such subdir in the devices dir...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.


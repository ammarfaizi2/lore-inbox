Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWBTBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWBTBLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWBTBLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:11:04 -0500
Received: from mx0.towertech.it ([213.215.222.73]:48078 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932494AbWBTBLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:11:01 -0500
Date: Mon, 20 Feb 2006 02:10:40 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: [PATCH 00/11] RTC subsystem
Message-ID: <20060220021040.094284b6@inspiron>
In-Reply-To: <20060219165845.09eb4183.akpm@osdl.org>
References: <20060219232211.368740000@towertech.it>
	<20060219165845.09eb4183.akpm@osdl.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006 16:58:45 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > 
> 
> This is nowhere near a sufficient explanation for such a patchset.
> 
> What does it all do, how does it do it and, importantly, _why_ does it do
> it?

 Sorry Andrew, it was meant as an update to my original email
 with full description. I've reported here as it is still valid.


 Hello,

  this is a proposal for the implementation of a kernel-wide
 RTC subsystem.

  The current state of RTCs under linux is that each one
 of the current drivers is actually self-contained and
 has a lot of redundant functions [1].
 
  The lack of a kernel-wide subsystem is particulary important
 on embedded devices, where the RTC is usually implemented
 on an I2C chip.

  Of the current I2C RTC drivers, no-one actually interfaces
 with the kernel [2]: the driver is actually useless
 without further patches that are probably provided as part
 of an external project.

  When new driver are to be implemented [3], I've noticed
 authors are often confused on how to do it, resulting
 in drivers that will not work on different architectures
 and that will probably never be merged in the kernel.

  They also happen to use ioctls over (struct i2c_client *)->command,
 which has recently been deprecated [4].

  The architecture is quite simple. Each RTC device should
 register to the RTC class, providing a set of pointers
 to functions. The class will provide access to the RTC
 to the whole kernel and userspace.

  For this purpose, the class supports multiple interfaces,
 like sysfs, proc and dev.

  The user has complete control over which interfaces
 gets added using the standard Kconfig mechanism.

  proc and dev, due to their nature, will only expose
 the first RTC that registers to the subsystem.

  The RTC code is derived from the one of the ARM subsystem.

  This patchset has been verify to properly work under Linux/ARM
 on several NSLU2s (http://www.linux-nslu2.org) and applies
 successfully on the 2.6.15-rc6 kernel . If this is the right
 way to go, I will port the x86 rtc driver in order to get
 broader testing.

  I'd appreciate receiving feedback on this proposal.

  Thanks in advance.

--

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


[1]
	http://lkml.org/lkml/2005/11/17/180

[2]
	drivers/i2c/chips/m41t00.c
	drivers/i2c/chips/rtc8564.c
	drivers/i2c/chips/ds1337.c
	drivers/i2c/chips/ds1374.c

[3]
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014428.html
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014386.html

[4]
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014688.html
	http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014369.html

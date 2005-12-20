Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVLTUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVLTUvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVLTUvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:51:07 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:2284 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932093AbVLTUuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:40 -0500
Date: Tue, 20 Dec 2005 21:43:43 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/6] RTC subsystem
Message-ID: <20051220214343.79d5ee91@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

-- 

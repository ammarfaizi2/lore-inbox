Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbULKSyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbULKSyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbULKSyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 13:54:55 -0500
Received: from mout.alturo.net ([212.227.15.21]:24535 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261991AbULKSyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 13:54:36 -0500
Message-ID: <41BB4268.8020908@datafloater.de>
Date: Sat, 11 Dec 2004 19:54:32 +0100
From: Arne Caspari <arne@datafloater.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/base/driver.c : driver_unregister
Content-Type: multipart/mixed;
 boundary="------------000609050000030007010107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609050000030007010107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I think the meaning of this patch is obvious: In driver_unregister, the 
bus_remove_driver function call was called outside the driver unload 
semaphore which should obviously protect it.

 /Arne


--------------000609050000030007010107
Content-Type: text/x-patch;
 name="driver_unregister.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driver_unregister.patch"

*** linux-2.6.9/drivers/base/driver.c	Mon Oct 18 23:55:06 2004
--- kernel-source-2.6.9/drivers/base/driver.c	Sat Dec 11 10:59:59 2004
***************
*** 106,113 ****
  
  void driver_unregister(struct device_driver * drv)
  {
- 	bus_remove_driver(drv);
  	down(&drv->unload_sem);
  	up(&drv->unload_sem);
  }
  
--- 106,113 ----
  
  void driver_unregister(struct device_driver * drv)
  {
  	down(&drv->unload_sem);
+ 	bus_remove_driver(drv);
  	up(&drv->unload_sem);
  }
  

--------------000609050000030007010107--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUKHONj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUKHONj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUKHONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:13:39 -0500
Received: from lucidpixels.com ([66.45.37.187]:30605 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261841AbUKHONg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:13:36 -0500
Date: Mon, 8 Nov 2004 09:13:34 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: sensors@stimpy.netroedge.com
Subject: Kernel 2.6.9 & adm1021 & i2c_piix4 temperature monitoring
Message-ID: <Pine.LNX.4.61.0411080907500.10502@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know why this happens?

I am monitoring the temperature sensors on my Dell GX1 box, and I get the 
following in dmesg:

i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)
i2c_adapter i2c-0: Failed! (01)

I am using lm-sensors 2.8.7.

Relevant modules include:

$ lsmod
Module                  Size  Used by
adm1021                12092  0
i2c_piix4               5648  0
i2c_sensor              2912  1 adm1021
i2c_dev                 7776  0
i2c_core               19312  4 adm1021,i2c_piix4,i2c_sensor,i2c_dev

Of course the ``secret'' to getting the temperature sensors to work on a 
Dell is two options when loading the i2c driver and the adm1024 driver.

   TYPE="/sbin/modprobe"

   $TYPE i2c_piix4 force=1
   $TYPE adm1021 read_only=1

The force is required to enable it, otherwise I do not believe it even 
loads.

The read_only=1 is so it does not change the temperature range in the 
monitoring chip, if read_only=1 is not set and the machine gets hot, say 
from compiling the kernel, the machine shuts itself off.

My question is, why all the failed transactions?
I graph the temperature without any issues (system and CPU) but I still 
get some of these in dmesg, any ideas?



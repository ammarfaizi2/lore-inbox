Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWJZIDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWJZIDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 04:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWJZIDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 04:03:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:25976 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752054AbWJZIC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 04:02:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q7elc808Eg4/nDn2/Rx6KHDrYWLATJ/Wq3vTgOqjkcmUfvlPlkXLn6HZsBDStwYWpp2aVHwkd+PqHJwXWO2Btdpzsh8OuMPVqIfqCTbkd5WoIXSiyjLYb6cJeRUYDtBOybEedsaJrOyg133FwdVqbZz/dB7PfkdbkNd6Sz5hQoM=
Message-ID: <a59861030610260102i35e86943qaa0425a5996a0ba1@mail.gmail.com>
Date: Thu, 26 Oct 2006 10:02:58 +0200
From: "Ivan Korzakow" <ivan.korzakow@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sysfs architecture question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm writing a driver for a smart card reader integrated in a
processor. The hardware have two interfaces (two "buses") to which you
can connect a number of analog adaptors. Each analog adaptors can have
multiple smartcard slots. I'd like to know if the architecture I've
chosen for the sysfs is good, most of all regarding power management.

I first created a platform device that represents the whole
controller, in which I define all the resources needed by the driver.
I also define a platform device_driver for this device.
Under it are two devices that represent the two interfaces of the
hardware. I also created a new sc_bus type, to which these three
devices are linked.
For each analog adaptor I create a device_driver entry, and the
associated device which is a child of my sc_bus device.
Finally, to each analog adaptor device can be attached a number of
smart card slots, represented by a device structure.
Here is an example of what you can see in /sys/device/platform (only
folders appear):
...
|-- sc_controller
|   |-- sc_bus0
|   |   |-- analog_adaptor0
|   |   |   `-- sc_slot0
|   |   |-- analog_adaptor1
|   |   |   |-- sc_slot1
|   |   |   `-- sc_slot2
|   |-- sc_bus1
...

So, my questions are:
Is the whole architecture correct ? Is it good to have the sc_bus
under the sc_controller ?
I have some difficulties to understand how power management works. I'd
like to be able to suspend/resume every slots (stop transfers, etc)
and every buses (stop clocks) by suspending/resuming the
sc_controller. Is that possible and how ?

Thanks in advance for your remarks and ideas.

Ivan

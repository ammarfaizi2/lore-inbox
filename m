Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSHOCJq>; Wed, 14 Aug 2002 22:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSHOCJq>; Wed, 14 Aug 2002 22:09:46 -0400
Received: from imo-m03.mx.aol.com ([64.12.136.6]:30692 "EHLO
	imo-m03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S316434AbSHOCJo>; Wed, 14 Aug 2002 22:09:44 -0400
Message-ID: <3D5AD6BF.8060609@netscape.net>
Date: Wed, 14 Aug 2002 22:16:31 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: driverfs: [PATCH] remove bus and improve driver management (2.5.30)
Content-Type: multipart/mixed;
 boundary="------------010801000408090003040706"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------010801000408090003040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    This patch removes bus.c from the Driver Model and replaces it with 
a more advanced and scaleable driver subsystem.  

The following diagram illustrates the current Driver Model 
implementation for drivers:
 bus->    pci->    parport_pc
                           agpgart
                           cardbus
              usb->    
                           hid

    Lets say that the usb bus is connected to pci0.  Notice how the usb 
driver has no linkage to the pci driver.  It should in order to take 
full advatage of the power management and other features of the driver 
model.  Of course the usb bus could create another driver and register 
it to pci but that would be wasteful and overly complicated.  Also 
notice that parport_pc could have a printer attached to it.  The lp 
driver would control this device but there is no way to represent the lp 
driver in the current model since only buses can have child drivers.

The following diagram illustrates the driver implementation after this 
patch: (this assumes that the listed driver have been converted to the 
Driver Model)
driver->    pci->    usb->                hid
                              parport_pc->    lp
                              agpgart
                              cardbus

    Notice that this implementation not only solves the problems listed 
earlier but also it is more scalable because it lists the drivers by 
thier true relationship to one another.  These changes actually reduce 
the total amount of code as well as the complexity of the entire system 
resulting in better efficiency and perhaps even less memory consumption.

    `This patch also provides user level driver management support 
through the advanced features of the new interface.  It creates a file 
entry named "driver" for each device.
To attach a driver simply echo the name of the driver you want to 
attach.  For example:
#cd ./root/pci0/00:00.0
#echo "agpgart" > driver

To remove a driver simply echo remove to the driver file while a driver 
is loaded.  For example:
#echo "remove" > driver

If you read the driver file you will get the name of the loaded driver 
if a driver is loaded.  For example:
#cat driver
output: agpgart

This patch is against 2.5.30.  The following still needs to be done:
1.) port to 2.5.31
2.) update bus drivers, currently only pci has been ported and tested, 
use the other buses at your own risk
3.) explore the possibility of linking the driver and root trees.  I 
have included an unused and untested function that will provide at least 
a framework for this.  See the code and comments in fs.c.  The function 
is called "device_driver_link".

Sincerely,

Adam Belay

*because the patch is so large I have gzipped it and attached it.  It is 
available in other formats upon request.

--------------010801000408090003040706
Content-Type: application/octet-stream;
 name="a.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="a.patch.gz"

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
Hez8LxBb9raCfAAA
--------------010801000408090003040706--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUEHDsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUEHDsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 23:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUEHDsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 23:48:54 -0400
Received: from [61.135.145.13] ([61.135.145.13]:42611 "EHLO websmtp03.sohu.com")
	by vger.kernel.org with ESMTP id S264054AbUEHDsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 23:48:51 -0400
Message-ID: <4830745.1083988124818.JavaMail.postfix@mx0.mail.sohu.com>
Date: Sat, 8 May 2004 11:48:44 +0800 (CST)
From: <dongzai007@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: vid&pid problems in usb_probe()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 221.218.37.174
X-Priority: 3
X-SHMOBILE: 0
X-SHBIND: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am writting an usb driver.You know function usb_probe(...) is used to determine whether the usbdevices just pluged in is what the driver is for.

The Vid and Pid of my usb device are 0x1111 and 0x0000 respectively.

the program is :

static void* usb_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
{
    ..............
    ..............
    
    printk("<1>Vid:%x\nPid:%x\n",udev->descriptor.idVendor,udev->descriptor.idProduct);

    if ((udev->descriptor.idVendor!=0x1111)
         ||(udev->descriptor.idProduct!=0x0000)) return NULL;

    ..............
}

when I plug the device whose vid & pid is 0x1111 & 0x0000 respectively.
this Module displayed


Vid:0
Pid:201

usb.c ........ no active driver for this device;

and when I plug another device , I also got wrong vid & pid.

But when I wrote program as below:

__u16 tmp=0x1111;
printk("<1>%x",tmp);

it can print "1111" on the screen. That means my syntax is correct.
I mean, the problem may be at the data transfered into function usb_probe()
Maybe data transfered into function usb_probe() is wrong.

I wonder where is the problem, how can i solve.



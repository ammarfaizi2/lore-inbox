Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUEICEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUEICEN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUEICEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:04:13 -0400
Received: from [61.135.145.20] ([61.135.145.20]:37713 "EHLO sohumx05.sohu.com")
	by vger.kernel.org with ESMTP id S264247AbUEICED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:04:03 -0400
Message-ID: <6918778.1084068239397.JavaMail.postfix@mx0.mail.sohu.com>
Date: Sun, 9 May 2004 10:03:54 +0800 (CST)
From: <dongzai007@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: vid&pid problems in usb_probe()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 218.107.149.1
X-Priority: 3
X-SHMOBILE: 0
X-SHBIND: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to tell you, I have copied all the header files in 
"linux2.4.18/include/linux" to "/usr/include/linux". I am sure that
there is no difference between "linux2.4.18/include/linux" and "/usr/include/linux"

I build this driver like this:

#gcc -c usb.c
#insmod -f usb.o  //due to version dismatch, i should use -f

then plug a usb device.


Could you help me test this program? Do you have an usb device? You can write a program 
like this, and test if it can report the right vid & pid.
I downloaded a new kernel 2.6.5, after i started with the new kernel, lots of modules
can not be loaded, so i changed back to 2.4.18, then I found my X-windows can not
start. Did this error have something to do with this unstablity?


-----  Original Message  -----
From: Randy.Dunlap 
To: dongzai007@sohu.com 
Cc: linux-kernel@vger.kernel.org 
Subject: Re: vid&pid problems in usb_probe()
Sent: Sun May 09 01:25:34 CST 2004

> On Sat, 8 May 2004 17:05:24 +0800 (CST) <dongzai007@sohu.com> wrote:
> 
> | Thank you for replying,but I don't know what you mean,
> | USB descriptor data structure is defined in 
> | "/usr/include/linux/usb.h"
> | 
> | my kernel version is 2.4.18.
> 
> Are you saying that your driver uses /usr/include/linux/usb.h ?
> If so, that's wrong.  It should use linux-2.4.18/include/linux/usb.h
> instead, and it will if you build/make the driver correctly.
> 
> So, how do you build this driver?  Show the Makefile or command
> line that you use.
> 
> Regarding the data structure, I don't know what /usr/include/linux/usb.h
> on your system contains since that is not a kernel header file (and
> drivers shouldn't use those).  I do recall, however, that many moons
> ago, there were some usb structs in usb.h that were not defined
> with __attribute__((packed)), and that could cause field offsets
> to be off a bit, er, byte (or more).
> 
> And what processor arch. are you doing this on?
> 
> Driver source code?
> 
> ~Randy
> 
> 
> | -----  Original Message  -----
> | From: Randy.Dunlap 
> | To: dongzai007@sohu.com 
> | Cc: linux-kernel@vger.kernel.org 
> | Subject: Re: vid&pid problems in usb_probe()
> | Sent: Sat May 08 12:45:54 CST 2004
> | 
> | > On Sat, 8 May 2004 11:48:44 +0800 (CST) <dongzai007@sohu.com> wrote:
> | > 
> | > | 
> | > | 
> | > | I am writting an usb driver.You know function usb_probe(...) is used to determine whether the usbdevices just pluged in is what the driver is for.
> | > 
> | > a.  Please learn to use the Enter/Return key around character position
> | > 70 (or before) on each line.
> | > 
> | > b.  what kernel version?   (*always*)
> | > 
> | > c.  You should ask this on the linux-usb-development mailing list:
> | > linux-usb-devel@lists.sf.net
> | > 
> | > 
> | > | The Vid and Pid of my usb device are 0x1111 and 0x0000 respectively.
> | > | 
> | > | the program is :
> | > | 
> | > | static void* usb_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
> | > | {
> | > |     ..............
> | > |     ..............
> | > |     
> | > |     printk("<1>Vid:%x
> | Pid:%x
> | ",udev->descriptor.idVendor,udev->descriptor.idProduct);
> | > | 
> | > |     if ((udev->descriptor.idVendor!=0x1111)
> | > |          ||(udev->descriptor.idProduct!=0x0000)) return NULL;
> | > | 
> | > |     ..............
> | > | }
> | > | 
> | > | when I plug the device whose vid & pid is 0x1111 & 0x0000 respectively.
> | > | this Module displayed
> | > | 
> | > | 
> | > | Vid:0
> | > | Pid:201
> | > | 
> | > | usb.c ........ no active driver for this device;
> | > | 
> | > | and when I plug another device , I also got wrong vid & pid.
> | > | 
> | > | But when I wrote program as below:
> | > | 
> | > | __u16 tmp=0x1111;
> | > | printk("<1>%x",tmp);
> | > | 
> | > | it can print "1111" on the screen. That means my syntax is correct.
> | > | I mean, the problem may be at the data transfered into function usb_probe()
> | > | Maybe data transfered into function usb_probe() is wrong.
> | > | 
> | > | I wonder where is the problem, how can i solve.
> | > 
> | > Seeing more (or all) of your source code could help.
> | > I'm especially curious (suspicious) about your USB descriptor data
> | > structures.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


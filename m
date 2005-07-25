Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVGYI2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVGYI2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 04:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGYI2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 04:28:24 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:55603 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261755AbVGYI2X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 04:28:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fEnaNHTKLie+SpUQaB5HTPt551c+HC43zskiMS3vLjxHc/XiaSXFtqrZSJugTq04FDPqxEni9MQs5zxmwt/STULJUe/NBwqCFD9v8yczzLqfmqy6KhQc5z4OZttWNbUQw+A4D1KzcP2ujsAh5Cgr7mw3EN/HFB77poFKwUR5n9c=
Message-ID: <958d5cd1050725012845d76286@mail.gmail.com>
Date: Mon, 25 Jul 2005 10:28:21 +0200
From: =?ISO-8859-1?Q?Lo=EFc_MARTIN?= <martinloik@gmail.com>
Reply-To: =?ISO-8859-1?Q?Lo=EFc_MARTIN?= <martinloik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: int pci_register_driver(&pci_driver) and void driver_attach(struct device_driver * drv)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.6.11.10

Currently writting down a pci driver, I notice that
"pci_register_driver(&pci_driver)" don't forward my "probe" function
errors.
Actually errors are noticed in the kernel ring buffer but don't make
pci_register_driver  fail. It returns a zero value in any case.
I traced back to the kernel in order to try to understand this problem
and find the "void driver_attach(struct device_driver * drv)" function
in the "linux-2.6.11.10/drivers/base/bus.c" file which, obviously, can
not returns an error.

So I just wish to know why this function only print this message :

				/* driver matched but the probe failed */
 				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);

but don't return the error.
Actually I don't understand why the module is loaded (because
pci_register_driver, which is called during __init, don't fail) while
my pci card could not have been initialized by "probe" function
because it failed for such reasons.

Thanks

-- 
Loïc Martin

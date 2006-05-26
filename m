Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEZOUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEZOUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEZOU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:20:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:25008 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWEZOU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:20:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kQ66gcfBgfKq3ye0OMr14/gWGS1pC2RoJp934qsOacmGNXeFEMurRCKSSmPS2K79edkpvcbjZWfC2PM9mGsix1MyBtpOAkQuFoQfDSKjMWbSOCQJhqy4acYH+K8bj2ExQscRZ97KzuQ+toSEPOkvQ8a+20yA83EF3je5F7/2k04=
Message-ID: <1afb5e600605260719h7a0f0811j874ab0c05b06a296@mail.gmail.com>
Date: Fri, 26 May 2006 16:19:56 +0200
From: "=?ISO-8859-1?Q?Josep_Ca=F1adell?=" <josepcy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pci driver with char devices
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have written a pci driver for a simple device. It only read and
write from a I/O ports region. (It works)

My structure is: pci_driver and a cdev to create the device file.
And the probe function is: (approximately)

SCLink_probe(struct pci_dev *my_pci_dev, ...)
{
   dev_t dev;
   pci_enable_device(my_pci_dev);

   result = alloc_chrdev_region(&dev, 0, 1, "SCLink");
   SCLink_major = MAJOR(dev);

   cdev_init(&char_dev, &fops);
   char_dev.owner = THIS_MODULE;
   char_dev.ops = &SCLink_fops; //file_operations
   err = cdev_add(&char_dev, dev, 1);

   pci_request_regions(my_pci_dev, "SCLink");

}

//static int __init SCLink_init(void)
//   return pci_register_driver(&SCLink_driver);



Is this structure acceptable?
Can I create a char device for each BAR?
Any suggestion?

Thanks in advance ;-)

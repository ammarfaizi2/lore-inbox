Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTGGRom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTGGRol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:44:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61411 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264197AbTGGRof convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:44:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] libsysfs v0.1.0
Date: Mon, 7 Jul 2003 10:55:08 +0000
User-Agent: KMail/1.4.1
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200307071055.08175.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to announce libsysfs - a small library built over sysfs, the virtual 
filesystem that exports system devices in the Linux 2.5+ kernels. You can 
find the initial version of the library in a small package called sysutils 
at:

	kernel.org/pub/linux/utils/kernel/hotplug/sysutils-0.1.0.tar.gz

The library grew from the requirements of several applications all needing 
access to system device information in sysfs. We felt it was better to 
provide a library of common code rather than having each application create 
their own access. Greg KH's udev application, a User Space replacement for 
devfs, is one of the applications needing sysfs access. You can see Greg's 
original announcement here:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=105003185331553&w=2

The library doesn't implement any device or bus specifics but simply provides 
generic bus, class, and device access as represented in sysfs. Included with 
the library in the sysutils package are two small commands that hopefully 
make viewing sysfs and system device information easier. 

- systool is a command that can list devices by bus, by class, or by device 
root - as represented through sysfs. Here's example output showing all 
devices off root device pci2, children are indented following each device:

[stekloff@... stekloff]$ systool -r pci2
Root Device Tree: pci2
   pci2 Host/PCI Bridge
         02:01.1 Adaptec AIC-7899P U160/m (#2)
               host1 aic7xxx
                     1:0:8:0 SCSI Processor
                           1:0:8:0:gen SCSI Processorgeneric
                     1:0:0:0 SCSI Direct-Access
                           1:0:0:0:gen SCSI Direct-Accessgeneric
         02:01.0 Adaptec AIC-7899P U160/m
               host0 aic7xxx

- lsbus is a small command for simply viewing sysfs bus information. Here's 
example output showing all PCI drivers and their devices:

[stekloff@... stekloff]$ lsbus -D pci
Bus: pci
Drivers:
  aic7xxx
        Devices:
                02:01.0
                02:01.1
  RZ1000 IDE
  PIIX IDE
  eepro100
  pcnet32
        Devices:
                00:05.0
  serial
  agpgart-via
  agpgart-sis
  agpgart-intel
  agpgart-amdk7
  agpgart-ali


All comments, suggestions, and contributions are welcome.

Thanks,

Dan


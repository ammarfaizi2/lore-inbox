Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUKLDli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUKLDli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 22:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUKLDlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 22:41:35 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61582 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261696AbUKLDlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 22:41:31 -0500
Subject: Re: network interface to driver and pci slot mapping
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Anthony Samsung <anthony.samsung@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041112005624.GA12129@kroah.com>
References: <8874763604111113281b1cf9a5@mail.gmail.com>
	 <20041112005624.GA12129@kroah.com>
Content-Type: text/plain
Message-Id: <1100230914.3048.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 19:43:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 16:56, Greg KH wrote:
> On Thu, Nov 11, 2004 at 04:28:35PM -0500, Anthony Samsung wrote:
> > Given an interface name (like eth0), how do I determine:
> > The name of the driver (module) for this interface.
> > The PCI address for this interface, if relevant.
> 
> Use sysfs.  All of this information is there (well, the driver link back
> to the module isn't there for most PCI drivers, but the functionality is
> there if the drivers are modified to support it...)


If you're going to use sysfs, libsysfs can help. It can be found in the
sysfsutils package here:

http://linux-diag.sourceforge.net/Sysfsutils.html

[stekloff@... stekloff]$ systool -c net eth0 -D
Class = "net"
 
  Class Device = "eth0"
    Device = "0000:02:01.0"
    Driver = "e1000"
      Devices using "e1000" are:
        Device = "0000:02:01.0"


And more extended output:

[stekloff@... stekloff]$ systool -c net eth0 -v
Class = "net"
 
  Class Device = "eth0"
  Class Device path = "/sys/class/net/eth0"
    addr_len            = "6"
    address             = "00:0d:60:c9:42:06"
    broadcast           = "ff:ff:ff:ff:ff:ff"
    features            = "0x3a9"
    flags               = "0x1002"
    ifindex             = "6"
    iflink              = "6"
    mtu                 = "1500"
    tx_queue_len        = "1000"
    type                = "1"
 
    Device = "0000:02:01.0"
    Device path = "/sys/devices/pci0000:00/0000:00:1e.0/0000:02:01.0"
      class               = "0x020000"
      config              =  86 80 1e 10 17 01 30 02  03 00 00 02 08 40
00 00
                             00 00 24 c0 00 00 20 c0  01 80 00 00 00 00
00 00
                             00 00 00 00 00 00 00 00  22 00 00 00 14 10
49 05
                             00 00 00 00 dc 00 00 00  00 00 00 00 0b 01
ff 00
      detach_state        = "0"
      device              = "0x101e"
      irq                 = "11"
      resource            = "0x00000000c0240000 0x00000000c025ffff
0x0000000000000200
0x00000000c0200000 0x00000000c020ffff 0x0000000000000200
0x0000000000008000 0x000000000000803f 0x0000000000000101
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x0000000000000000 0x0000000000000000
0x0000000000000000 0x000000000000ffff 0x0000000000007200"
      subsystem_device    = "0x0549"
      subsystem_vendor    = "0x1014"
      vendor              = "0x8086"
 
    Driver = "e1000"
    Driver path = "/sys/bus/pci/drivers/e1000"
      new_id              = <store method only>
 
      Devices using "e1000" are:
        "0000:02:01.0"

Thanks,

Dan



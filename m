Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTG1Qkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTG1Qkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:40:32 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:8722 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270271AbTG1Qk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:40:29 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Mon, 28 Jul 2003 20:44:43 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307262036.13989.arvidjaar@mail.ru> <20030726165056.GA3168@kroah.com>
In-Reply-To: <20030726165056.GA3168@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282044.43131.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 July 2003 20:50, Greg KH wrote:
> On Sat, Jul 26, 2003 at 08:36:13PM +0400, Andrey Borzenkov wrote:
> > So apparently I cannot rely on sysfs to get reliable persistent
> > information about physical location of devices.
>
> That is correct, but you can get pretty close :)
>

sure, I know. The more annoying is how difficult is to step over this "close" 
:)

> > the point is - I want to create aliases that would point to specific
> > slots. I.e. when I plug USB memory stick in upper slot on front panel I'd
> > like to always create the same device alias for it.
>
> Look at the udev announcement I posted to linux-kernel yesterday to see
> how to do this.
>

I know udev.

udev does not answer my question. It operates on logical device (bus) numbers. 
My question was how to name devices based on physical position 
*independently* of logical numbers they get.

It is not strictly speaking udev fault but simply result of kernel exporting 
logical device names instead of true physical paths. I miss Solaris /devices 
filesystem ...

OK I may mot see something obvious. Simple example.

I have SCSI HBA sitting in PCI slot 3. It gets SCSI host number 1. I configure 
udev to name SCSI device 1.0.0.1 "database"

I add one more SCSI HBA in PCI slot 1. Next time system is booted *this* gets 
SCSI host number 1 and my first HBA in slot 3 gets SCSI host 2. Oops.

Question: how to configure udev so that "database" always refers to LUN 0 on 
target 0 on bus 0 on HBA in PCI slot 1.

> thanks,
>

I thank you

-andrey

PS this obviously applies not only to SCSI. It is just it is most simple 
example and you do not open network interfaces by name so there is *no* way 
at all to assign their numbers :(

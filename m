Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTHaKyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTHaKyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:54:24 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:4876 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262574AbTHaKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:54:19 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sun, 31 Aug 2003 14:54:06 +0400
User-Agent: KMail/1.5
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <20030818204218.GA3220@kroah.com>
In-Reply-To: <20030818204218.GA3220@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308311453.00122.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 August 2003 00:42, Greg KH wrote:
> On Mon, Aug 18, 2003 at 10:21:22AM +0400, "Andrey Borzenkov"  wrote:
> > just to show what I expected from sysfs - here is entry from Solaris
> > /devices:
> >
> > brw-r-----   1 root     sys       32,240 Jan 24  2002
> > /devices/pci@16,4000/scsi@5,1/sd@0,0:a
> >
> > this entry identifies disk partition 0 on drive with SCSI ID 0, LUN 0
> > connected to bus 1 of controller in slot 5 of PCI bus identified
> > by 16. Now you can use whatever policy you like to give human
> > meaningful name to this entry. And if you have USB it will continue
> > further giving you exact topology starting from the root of your
> > device tree.
> >
> > and this path does not contain single logical id so it is not subject
> > to change if I add the same controller somewhere else.
> >
> > hopefully it clarifies what I mean ...
>
> Hm, a bit.  First, have you looked at what sysfs provides?  Here's one
> of my machines and tell me if it has all the info you are looking for:
>
> $ tree /sys/bus/scsi/
> /sys/bus/scsi/
>
> |-- devices
> |   `-- 0:0:0:0 ->
> | ../../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0
                                                              ^ ^unstable         
[...]
>
> Now, from that you can see exactly where my scsi device is in the pci
> tree, and you can see in the block directory, what block device is
> assigned to what physical device in the device tree.  Then there are 4
> partitions on this disk, all what those specific paramaters.
>
> So, when sda shows up, udev can determine that it lives on a specific
> scsi device, located in a specific place in the pci space, and that it
> has some number of partitions, all of specific sizes, wich specific
> major/minor numbers.  It can then create all of the /dev links based on
> this.
>
> Please, take a few minutes looking at the existing sysfs tree on Linux.
> If you then have any specific questions, I would be glad to answer
> them.
>

Now I have to ask - do we discuss udev-0.2 (what I currently have) or 
udev-as-it-can-be-in-fututure?

In udev-0.2 I cannot do it. I can say I want

TOPOLOGY, BUS="scsi", place="0.0.0.0", NAME="jaz"

but the next time I plug in SCSI card the host number changes. Even after I 
unplug USB stick and plug it again it gets new host number.

And the same applies to USB, PCI and whatever. Sysfs exports entity numbers as 
kernel enumerates them; while Solaris exports persistent device tree leaving 
enumeration to user-level tools. Which means that if hardware changes for 
whatever reason enumeration changes as well and your config becomes invalid. 

> Hope this helps,
>

Well, we did not move a tiny bit since the beginning of this thread :) You 
still did not show me namedev configuration that implements persistent name 
for a device based on its physical location :)))

-andrey

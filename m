Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUACJAp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUACJAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:00:45 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:64016 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262784AbUACJAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:00:43 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Sat, 3 Jan 2004 11:51:33 +0300
User-Agent: KMail/1.5.3
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com>
In-Reply-To: <20040103055847.GC5306@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401031151.02001.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 January 2004 08:58, Greg KH wrote:
> On Thu, Jan 01, 2004 at 11:33:04PM +0300, Andrey Borzenkov wrote:
> > udev names are created when kernel detects corr. device. Unfortunately
> > for removable media kernel rescans for partitions only when I try to
> > access device. Meaning - because kernel does not know partition table it
> > did not send hotplug event so udev did not create device nodes. But
> > without device nodes I have no way to access device in Unix :(
> >
> > specifically I have now my Jaz and I have no (reasonable) way to access
> > partition 4 assuming device nodes are managed by udev.
> >
> > devfs solved this problem by
> >
> > - always exporting at least handle to the whole disk (sda as example)
>
> Doesn't the kernel always create the main block device for this device?

yes

> If so, udev will catch that.

yes. So what - how does it help? User needs /dev/sda4. User has /dev/sda only. 
Any attempt to refer to /dev/sda4 simply returns "No such file or directory"

> If not, there's no way udev will work for 
> this kind of device, sorry.

this worked seamlessly using static /dev. This worked seamlessly using devfs. 
If it won't work with udev - it means regression. And believe me - it is 
serious regression for end-users (I still remember similar problems we had 
when transitioning to devfs and users' reaction to this).

> You could make a script that just creates 
> the device node in /tmp, runs dd on it, and then cleans it all up to
> force partition scanning.
>

You miss the point. When should this script be run? There is no event when you 
just insert Jaz disk; nor is there any way to trigger revalidation on access 
to non-existing device like is the case without udev.

what I aim at - udev needs to provide some extension mechanism to allow 
arbitrarily scripts to be run. Such script could then create all block nodes 
(hmm ... how can script know the number of possible nodes and their names?)

in hope somebody gets an idea ...

regards

-andrey


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264551AbTCZBxW>; Tue, 25 Mar 2003 20:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264552AbTCZBxW>; Tue, 25 Mar 2003 20:53:22 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:16553 "EHLO
	imf45bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264551AbTCZBxU>; Tue, 25 Mar 2003 20:53:20 -0500
Subject: Re: 2.5 and modules ?
From: Louis Garcia <louisg00@bellsouth.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048638632.1176.4.camel@teapot>
References: <1048564993.2994.13.camel@tiger>
	 <Pine.LNX.4.51.0303251219250.9373@dns.toxicfilms.tv>
	 <1048636973.1569.20.camel@tiger>  <1048638632.1176.4.camel@teapot>
Content-Type: text/plain
Organization: 
Message-Id: <1048644294.2449.25.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 25 Mar 2003 21:04:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you mean this? If so what do I change it to?

if [ -f /proc/sys/kernel/modprobe ]; then
   if [ -n "$USEMODULES" ]; then
       sysctl -w kernel.modprobe="/sbin/modprobe" >/dev/null 2>&1
       sysctl -w kernel.hotplug="/sbin/hotplug" >/dev/null 2>&1
   else
       # We used to set this to NULL, but that causes 'failed to exec'
messages"
       sysctl -w kernel.modprobe="/bin/true" >/dev/null 2>&1
       sysctl -w kernel.hotplug="/bin/true" >/dev/null 2>&1
   fi
fi


By the way, Thanks for all your help.

--Lou


On Tue, 2003-03-25 at 19:30, Felipe Alfaro Solana wrote:
> On Wed, 2003-03-26 at 01:02, Louis Garcia wrote:
> > Setting hostname tiger:                              [  OK  ]
> > Initializing USB controller (usb-uhci): FATAL: Module usb_uhci
> 
> The USB UHCI module has been renamed. Now it's called uhci-hcd.ko. Make
> sure the following line is present in "/etc/modprobe.conf":
> 
> alias usb-controller uhci-hcd
> 
> >  not found.                                          [ FAILED ]
> > Mounting USB filesystem:                             [  OK  ]
> > grep: /proc/bus/usb/drivers:  No such file or directory.
> 
> No more drivers in /proc/bus/usb.
> 
> > Mounting local filesystems:  mount: fs type ntfs not supported by
> > kernel.  mount: fs type vfat not supported by kernel.
> >                                                      [ FAILED ]
> > 
> > 
> > I have built all required modules:
> 
> "cat /proc/sys/kernel/modprobe" should spit:
> 
>    /sbin/modprobe
> 
> Double check this... I found that rc.sysinit from RH8 and RH9 do
> configure this to /sbin/true, thus invalidating dynamic kernel module
> loading.
> 
> ________________________________________________________________________
>         Felipe Alfaro Solana
>    Linux Registered User #287198
> http://counter.li.org
> 


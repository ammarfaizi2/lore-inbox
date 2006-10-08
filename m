Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWJHADa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWJHADa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWJHADa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:03:30 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:16008 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932898AbWJHAD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:03:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=u+kOTlsoa2NvQPLy1CGhTY6Tn4OqkqIdaHIQuM1lanWzsFeTW5hi8yFyNJ03v6khMG4/kqG3Yv1beqzxMthk0+WN8Y5hUW+tx6NJ8SbDIVLXtXK6AOmS7upuuEi4P29uHxMAqQTA9RCkmIhtVKE9Yj37r0xBhh9URra8u5h/HEI=  ;
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Sat, 7 Oct 2006 17:03:23 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <20061007110824.GA4277@ucw.cz> <200610071916.27315.oliver@neukum.org>
In-Reply-To: <200610071916.27315.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610071703.24599.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 October 2006 10:16 am, Oliver Neukum wrote:

> > > I dare say that the commonest scenario involving USB is a laptop with
> > > an input device attached. Input devices are for practical purposes always
> > > opened. A simple resume upon open and suspend upon close is useless.

That is, the standard model is useless?  I think you've made
a few strange leaps of logic there ... care to fill in those
gaps and explain just _why_ that standard model is "useless"???

Recall by the way that the autosuspend stuff kicked off with
discussions about exactly how to make sure that Linux could
get the power savings inherent in suspending USB root hubs,
with remote wakeup enabling use of the mouse on that keyboard.
(I remember Len Brown talking to me a few years back about how
that was the "last" 2W per controller easily available to save
power on Centrino laptops ... now we're almost ready to claim
that savings.)


> > Okay, but you can simply do autosuspend with remote wakeup completely
> > inside input driver. You do ot need it to be controlled from X... at
> > most you need one variable ('autosuspend_inactivity_timeout')
> > controlled from userland.
> > 
> > That's what we already do for hdd spindown... you simply tell disk to
> > aitospindown after X seconds of inactivity.
> 
> The firmware in the drive supplies this function. It's hardly by choice
> that it is made available.

Sure it is.  Nobody had to write that code.  Of course, Pavel was
skipping some details too ... "laptop_mode" kicks some other system
controls so that the disk drive isn't accessed so much.


> The power management functions without 
> timeout are also exported. For other power control features like
> cpu frequency considerable effort has been made to export them to
> user space.

Yes, and many of us use the much lighter weight kernel based control
models by preference.   Why waste hundreds of Kbytes of userspace for
a daemon when a few hundred bytes of kernel code can implement a
better and more reactive kernel policy for cpufreq?


> A simple timeout solution has drawbacks.

Plus lots of advantages, including the not-to-be-underrated simplicity.

> - there's no guarantee the user wants wakeup (think laptop on crowded table)

In which case the /sys/devices/.../power/wakeup flag can be
marked as disabled.  No wakeup ... but of course, no power
savings either.  (One can still unplug the mouse...)

> - you want to suspend immediately when you blank the screen (or switch to
> a text console)

Unrelated to USB or any other specific subsystem; the system
suspends by "echo mem > /sys/power/state" regardless.  (That is,
once the bugs in ACPI, and sometimes drivers, get fixed.)

> - you want to consider all devices' activity. I am not pleased if my mouse
> becomes less responsive just because I used only the keyboard for a
> few minutes. Coordinating this inside the driver is hard as some input
> devices might well be not usb (eg. bluetooth mouse, usb tablet)

The reasons X11 becomes unresponsive have very little to do with USB
or autosuspend; happens all the time with PS2 mice, trackpads, etc.
Again, those issues are unrelated to USB, or to the API you said you
wanted to see.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUFCHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUFCHjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUFCHjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:39:47 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:8802 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261582AbUFCHjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:39:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
Date: Thu, 3 Jun 2004 02:39:40 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
References: <20040602190927.79289.qmail@web81306.mail.yahoo.com> <200406030158.42703.dtor_core@ameritech.net> <xb7d64h3y2k.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7d64h3y2k.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030239.40046.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 02:22 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     >> Unfortunately, the connection between devices and drivers
>     >> (either in the serio.c interface or in the input.c interface)
>     >> is a graph.  It is more complicated than an array.  Yes, you
>     >> can represent a graph with a matrix or an adjacency list, both
>     >> representable as arrays in one way or another.  Nothing in a
>     >> digital computer cannot be represented by an array of bits
>     >> anyway!  But useability of the interface must not be ignored.
>     >> 
> 
>     Dmitry> I am not sure where you see the problem - consider a PCI
>     Dmitry> bus and all PCI devices and all drivers tyhat currently
>     Dmitry> present in kernel. They are using the new driver model and
>     Dmitry> sysfs and they come together quite nicely.
> 
> # ls -l /sys/bus/pci/devices/0000:01:00.0
> 
>         -r--r--r--    1 root     root          class
>         -rw-r--r--    1 root     root          config
>         -rw-r--r--    1 root     root          detach_state
>         -r--r--r--    1 root     root          device
>         -r--r--r--    1 root     root          irq
>         drwxr-xr-x    2 root     root          power
>         -r--r--r--    1 root     root          resource
>         -r--r--r--    1 root     root          subsystem_device
>         -r--r--r--    1 root     root          subsystem_vendor
>         -r--r--r--    1 root     root          vendor
> 
> # ls -l /sys/bus/pci/drivers/PIIX\ IDE
> 
>         lrwxrwxrwx    1 root     root          17:20 0000:00:07.1 ->
>                       ../../../../devices/pci0000:00/0000:00:07.1
>         --w-------    1 root     root          17:20 new_id
> 
> 
> The  info  are  binary  (shown  in 0x????  notation).   Each  reflects
> directly the binary value of the corresponding 'attribute'.
> 
> 1) None of these are arrays.  But in the input system, each device can
>    be  attached to _multiple_  handlers, and  each handler  can handle
>    _multiple_ devices.  That's an n-to-n relation.

And when they join together they form a new entity, a new device. And that's
input system, not serio.  

> 
> 2) I can't  find out  how to  dynamically change the  driver of  a PCI
>    device.

No need really. PCI devices are easily identifiable.

> 
> 3) PCI device<-->handler is a  many-to-one relation.  The input system
>    is many-to-many.
> 
> 4) How to  display/parse a device<-->handler connection?   You want to
>    show and accept a pointer value?

Strings are perfectly valid:

[dtor@core dtor]$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
acpi-cpufreq
[dtor@core dtor]$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
powersave userspace performance

It just depends on implementation.

> 
> The sysfs interface looks very confusing to me.
> 
Yes, I haven't wrapped my mind around it completely either. But we have
Greg K-H and others who will make sure we chose the right path ;)

-- 
Dmitry

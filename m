Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbUKKEc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbUKKEc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUKKEc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:32:57 -0500
Received: from [61.48.53.74] ([61.48.53.74]:52220 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262168AbUKKEcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:32:54 -0500
Date: Thu, 11 Nov 2004 12:24:10 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411112024.iABKOAD04383@freya.yggdrasil.com>
To: gene.haskett@verizon.net
Subject: Re: DEVFS_FS
Cc: alebyte@gmail.com, linux-kernel@vger.kernel.org,
       linux-os@chaos.analogic.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2004-11-11 0:06:37, Gene Heskett wrote:
>On Wednesday 10 November 2004 16:03, Alexandre Costa wrote:
>>On Wed, 10 Nov 2004 15:46:06 -0500 (EST), linux-os
>>
>><linux-os@chaos.analogic.com> wrote:
>>> What is the approved substitute for DEVFS_FS that is marked
>>> obsolete?
>>
>>udev
>>http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html
>
>Humm, I'm not sure I'm entirely happy with that choice.  I have an 
>FC3RC5 install on an old P-II running at 233mhz, and the udev start 
>in the bootup is the slowest single thing to get started by an order 
>of magnitude.
>
>Can someone tell me a good reason udev wastes as much time as the post 
>does checking 383 megs of memory, which is very nearly a minute even 
>just for udev?
>
>If its to be used, its got to speed itself up, a LOT!.

Gene,

	I do not know what kind of device you are using or what kind
of inialization it really needs, but your situation _might_ be a good
example of the benefits of being able configure devices on demand with
devfs if this is a device that you do not use every time you boot
your system and that initialization process is not something that
can easily be deferred to the first device open() call.

	As you may know, in the recent releases of my devfs rewrite,
I split the demand loading for missing device files into a separate
a separate facility (tmpfs "lookup traps").  That way, even if you
do not want to run the rest of devfs, you could avoid that
initilization and perhaps some kernel memory usage from the device
driver in the sessions that never use that device.

	On the other hand, initialization on demand would make your
first access of the session to that device spend the same amount of
time that you are now spending at boot, whereas, you might instead
want to have that device driver loaded at boot time and stay in
kernel memory so that you can do the initialization in the background
if you can somehow ensure that access to the device will block until
the initialization completes if necessary.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

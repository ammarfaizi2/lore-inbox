Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVJaAwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVJaAwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVJaAwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:52:36 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:26887 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932386AbVJaAwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:52:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200510290410.48454.rob@landley.net>
References: <43625208.60703@cc.umanitoba.ca> <200510290410.48454.rob@landley.net>
X-OriginalArrivalTime: 31 Oct 2005 00:52:34.0274 (UTC) FILETIME=[6164C420:01C5DDB5]
Content-class: urn:content-classes:message
Subject: Re: Is sharpzdc_cs.o not a derivitive work of Linux?
Date: Sun, 30 Oct 2005 19:52:33 -0500
Message-ID: <Pine.LNX.4.61.0510301938430.24495@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is sharpzdc_cs.o not a derivitive work of Linux?
Thread-Index: AcXdtWFudYG5nP8ySVCVbK1Ne1u7Gw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Rob Landley" <rob@landley.net>
Cc: "Mark Jenkins" <umjenki5@cc.umanitoba.ca>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Oct 2005, Rob Landley wrote:

> On Friday 28 October 2005 11:30, Mark Jenkins wrote:
>> I have read, http://people.redhat.com/arjanv/COPYING.modules
>> Summary: A Linux module is a derivative work unless a strong case is
>> made otherwise.
>>
>> I would like to know if this is one of those exception cases. That is
>> why I used the word 'not' in the subject line.
>>
>> Is sharpzdc_cs.o *not* a derivative work of Linux?
>
> I suspect that right now the Linux developers are trying an end-run around the
> whole mess.  At a wild guess, binary-only modules will probably be obsolete
> in a few years.  I could easily be wrong, but here's why I think this:
>
> 2.6 introduced sysfs and udev.  When /dev is maintained by udev, then udev
> gets the list of devices and each device's major/minor numbers from the dev
> entry for the device in sysfs.  At boot time, udev starts with an empty /dev
> directory (generally tmpfs) and populates it from /sys, and hotplug events
> tell udev to take another look at sysfs.  I.E. if devices don't show up
> in /sys, then udev doesn't create device nodes for them in /dev.
>
> Of course you can work around this by running a supplemental script at boot
> time to manually create extra devices (using the static major/minor numbers
> from the lanana.org list), or by simply not using udev at all (and thus not
> having modern features like good hotplug and persistent naming of things that
> move around on USB hubs and such).  The ability to use something other than
> udev depends on the existence of static major and minor numbers.
>
> But static major and minor numbers are not required for udev.  Any system that
> has udev recreates the contents of /dev from scratch on each reboot, and does
> so based on major/minor pairs handed to it by sysfs.  Those numbers can be
> dynamically allocated by the kernel as each new device is hotplugged in,
> there's no need for them to be preassigned.
>
> At some point in the future, a config option will probably show up to make all
> device numbers dynamically assigned.  (This used to be a plan for 2.7, back
> when we were going to have a 2.7.)  For purely technical reasons, it's a
> great simplifiation, making a lot of hardcoded magic numbers in the kernel
> simply go away, eliminating the need to manage the hugely complex lanana.org
> device number list, increasing scalability because now there's no real limit
> on how many devices of a given type you can plug in since you won't run out
> of major/minor pairs from the preallocated range to represent the new type.
> It's been discussed before, and is a to-do item.
>
> Of course under a dynamic major/minor scheme, udev would no longer be optional
> but a requirement, and any device that wants a dev node _must_ show up in
> sysfs or there's no major/minor pair to assign to it.  And the really
> interesting bit is that all the kernel-side sysfs bindings are
> EXPORT_GPL_ONLY.  A non-gpl module _cannot_ show up in sysfs.  Thus under a
> dynamic major/minor scheme, binary only modules couldn't have device nodes.

Well no. Unless you modify the tools so it's impossible to show
a symbol map, nobody gives a hoot about EXPORT_GPL_ONLY. One doesn't
need to "export" any symbols at all. In fact, "export" seems to have
been created by somebody who didn't have a clue. It's not needed
at all. Even though it's currently used, it doesn't need to be.

>
> Interesting, isn't it?  The normal churn in the kernel naturally renders old
> interfaces obsolete, but the new interfaces are GPL_ONLY.  Even if this isn't
> the specific way they get rendered obsolete, the window for binary only
> modules is slowly closing...
>
> Rob
> -

It's not, as you say, the "normal churn". It is absurd that so
much effort is put into doing such destructive work as the
GPL_ONLY crap. And, in case you haven't noticed, /dev is the
place where device-names are normally placed. The special
device-files don't have to be there, either. They can be
anywhere. Any attempt to "force" the use of the "sys"
directory for "dev" files will fail. The Unix variant will
get forked off and the "modify-just-to-change" variant
will disappear.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

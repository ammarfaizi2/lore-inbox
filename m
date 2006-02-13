Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWBMUJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWBMUJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWBMUJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:09:06 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:34357 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964818AbWBMUJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:09:05 -0500
Message-ID: <43F0E724.6000807@cfl.rr.com>
Date: Mon, 13 Feb 2006 15:08:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net>
In-Reply-To: <200602131116.41964.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 20:09:57.0167 (UTC) FILETIME=[75F513F0:01C630D9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14266.000
X-TM-AS-Result: No--16.900000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> What ide drive?  Oh, you're talking about PC-ish systems, not
> embedded ones that don't _have_ rotating media to power off.
>   

Yes, that's exactly what the discussion is about; disk drives with 
mounted filesystems and what happens to them when you suspend/resume. 
> Your experience is very different from mine; I've observed that
> most PC hardware keeps USB powered in suspend-to-ram states, so
> a keyboard or mouse action may wake the system up, just as it can
> with many PS2 style keyboards and mice.  Same thing for Ethernet,
> using various types of wakeup event including "magic packet".
> See /proc/acpi/wakeup, and the related parts of the ACPI specs.
> (And USB specs, and lots more ... this info is widespread.)
>   

As I have said before, some systems can keep the USB bus in a low power 
mode where it can wake the system, but AFAIK, waking the system is all 
they can do in this state; they can not tell the kernel that device x 
has been connected and device y has been disconnected, the kernel must 
figure that out by probing the hardware and comparing the list with what 
it knew to be connected prior to suspending.  Even if some hardware can 
provide that information, kernel can not rely on it. 

<snip>

> You should also remember a useful point from the ACPI spec:
> if you're taking the system apart with a screwdriver, then
> you've gone out-of-spec.  So swapping IDE drives is strongly
> in the "user error" category ... unlike swapping USB drives,
> which is equally strongly in the "normal operation" category.
> (So it would be an error if Linux didn't properly detect when
> users unplug all usb devices after putting their laptops into
> STR and before carrying them someplace else...)
>
>   
Yes, it would be an error if the kernel did not notice that you actually 
did unplug a usb disk while it was suspended.  It is just as much an 
error however, if the kernel erroneously decides that you disconnected 
the drive, and thus breaks the mount on it, when you in fact, did no 
such thing. 
>
> Read about the #PME signal status in the PCI PM capabilities.
>
> And the USB remote wakeup reporting done by USB hubs; you can
> even look at the drivers/usb/core/hub.c code and see how usb
> wakeup events (of various types) are handled.
>
> You don't seem to know what you're talking about here.
>
>   

Which is why I qualified my statements with "AFAIK".  Maybe you could 
enlighten me.  Does the #PME signal carry enough information to inform 
the kernel that the reason the system is being woken up is because you 
unplugged the mouse from the usb hub?  I was under the impression that 
this was not the case, instead the kernel at best knows it is being 
woken up because the USB host controller generated a wake event.  
Because of this and the fact that SCSI busses that I have seen do no 
such thing, I assumed the kernel would handle USB in the same way, 
specifically, that it would reenumerate and provided the same hardware 
is still there that it expects to be there, then it would continue 
operation as normal rather than deciding the drive was unplugged. 
> You were wrong then too... both about probing "all hardware" and about not
> being able to distinguish wakeup event sources.  
>   

Are you quite certain about that?  This is not the case for SCSI disks, 
but for USB, maybe it can provide sufficient information to the kernel 
about state changes without having to do a full rescan.  If that is the 
case, and the hardware is erroneously reporting that all devices were 
disconnected and reconnected after an ACPI suspend to disk, then such 
hardware is broken and the kernel should be patched to work around it. 


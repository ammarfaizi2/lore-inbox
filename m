Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272535AbTGZQoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272537AbTGZQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:44:00 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:50608 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S272535AbTGZQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:43:52 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Date: Sat, 26 Jul 2003 12:59:03 -0400
User-Agent: KMail/1.5.2
References: <200307262036.13989.arvidjaar@mail.ru>
In-Reply-To: <200307262036.13989.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261259.03517.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Specifically using your example of USB memories, I have seen devices move 
around just because of rebooting.  I have a Sandisk SDDR-31 (MMC) and a 
SDDR-33 (CF) that remain plugged into the same USB ports all the time.  
Occasionally, they come up swapped (normally the MMC reader is /dev/sda), 
which is really infuriating, since my scripts for building MMC and CF cards 
then exhibit much breakage.

	And whether it's something unique to this motherboard, those devices, or 
what, but I've seen any number of times the kernel/modules get into a state 
where the module cannot be unloaded because the in-use counter is set, yet 
nothing appears to be using it.  When it gets into this state, the device is 
unusable, and my only recourse is to reboot (just like Windows!)

	I haven't had an opportunity to further characterize the problem, but it's 
been persistent across 2.4 and 2.5 kernels.

	--John


On Saturday 26 July 2003 12:36 pm, Andrey Borzenkov wrote:
> As far as I can tell sysfs device names include logical bus numbers which
> means, if hardware is added or removed it is possible names do change.
>
> Example:
>
> /sys/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:0/host1/1:0:0:0
>
> PCI part reflects bus number. Now this example is trivial in that it is
> integrated USB controller so it is unlikely to ever change its number - but
> if it were external controller (and even worse with PCI-to-PCI bridge) it
> is likely that adding extra card would shift all numbers.
>
> And USB part of name starts with logical USB bus number i.e. it is obvious
> that adding one more USB adapter will definitely change it.
>
> So apparently I cannot rely on sysfs to get reliable persistent information
> about physical location of devices.
>
> the point is - I want to create aliases that would point to specific slots.
> I.e. when I plug USB memory stick in upper slot on front panel I'd like to
> always create the same device alias for it.
>
> TIA
>
> -andrey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270388AbTGZQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270189AbTGZQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:30:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:40905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270429AbTGZQaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:30:52 -0400
Date: Sat, 26 Jul 2003 09:43:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-Id: <20030726094317.7976a350.rddunlap@osdl.org>
In-Reply-To: <200307262036.13989.arvidjaar@mail.ru>
References: <200307262036.13989.arvidjaar@mail.ru>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 20:36:13 +0400 Andrey Borzenkov <arvidjaar@mail.ru> wrote:

| 
| As far as I can tell sysfs device names include logical bus numbers which 
| means, if hardware is added or removed it is possible names do change.
|  
| Example:
| 
| /sys/devices/pci0000:00/0000:00:1f.4/usb2/2-2/2-2.1/2-2.1:0/host1/1:0:0:0
| 
| PCI part reflects bus number. Now this example is trivial in that it is 
| integrated USB controller so it is unlikely to ever change its number - but 
| if it were external controller (and even worse with PCI-to-PCI bridge) it is 
| likely that adding extra card would shift all numbers.
| 
| And USB part of name starts with logical USB bus number i.e. it is obvious 
| that adding one more USB adapter will definitely change it.
| 
| So apparently I cannot rely on sysfs to get reliable persistent information 
| about physical location of devices.
| 
| the point is - I want to create aliases that would point to specific slots. 
| I.e. when I plug USB memory stick in upper slot on front panel I'd like to 
| always create the same device alias for it.

You'll probably get a barrage of replies...

You want udev + namedev, userspace naming policy.  See the recent
udev announcements from Greg Kroah-Hartman.

udev/namedev use sysfs device tree info to apply device naming policy.

>From Greg's version 0.2 announcement:
<quotes>
kernel.org/pub/linux/utils/kernel/hotplug/udev-0.2.tar.gz

There's a BitKeeper tree of the latest stuff available at:
	bk://kernel.bkbits.net/gregkh/udev/

I've also placed the slides from my OLS talk up at:
	http://www.kroah.com/linux/talks/ols_2003_udev_talk/

The paper which attempts to explain the background of udev, what it
does, and where it is going is at:
	http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Kroah-Hartman-OLS2003.pdf
</selected quotes>

There's more in the announcment email.  This is still early code,
so there's much more to be done on it, but the demo yesterday looked
very good.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

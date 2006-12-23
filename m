Return-Path: <linux-kernel-owner+w=401wt.eu-S1752356AbWLWNkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbWLWNkb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 08:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbWLWNka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 08:40:30 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34306 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbWLWNka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 08:40:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: bcm43xx from 2.6.20-rc1-mm1 on HPC nx6325 (x86_64)
Date: Sat, 23 Dec 2006 14:41:49 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       bcm43xx devel <Bcm43xx-dev@lists.berlios.de>,
       netdev <netdev@vger.kernel.org>
References: <458C1633.1040606@lwfinger.net>
In-Reply-To: <458C1633.1040606@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612231441.49949.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 22 December 2006 18:30, Larry Finger wrote:
> I'm trying to make the bcm43xx driver out of the 2.6.20-rc1-mm1 kernel work on
> an HPC nx6325, with no luck, so far, although I'm using a firmware that has
> been reported to work with these boxes
> (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325#Onboard_Wireless_.28802.11.29).
> 
> The driver loads and seems to operate the hardware to some extent, but there
> seems to be a problem with interrupts. Namely, the chip doesn't seem to
> generate any.
> Raphael J. Wysocki wrote:
> 
>  > Right after a fresh 'modprobe bcm43xx' I get the following messages in dmesg:
> 
>  > bcm43xx driver
>  > ACPI: PCI Interrupt 0000:30:00.0[A] -> GSI 18 (level, low) -> IRQ 18
>  > PCI: Setting latency timer of device 0000:30:00.0 to 64
>  > bcm43xx: Chip ID 0x4311, rev 0x1
>  > bcm43xx: Number of cores: 4
>  > bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
>  > bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
>  > bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
>  > bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
>  > bcm43xx: PHY connected
>  > bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
>  > bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
>  > bcm43xx: Radio turned off
>  > bcm43xx: Radio turned off
>  > PM: Adding info for No Bus:eth1
>  > printk: 3 messages suppressed.
>  > SoftMAC: ASSERTION FAILED (0) at: > 
> net/ieee80211/softmac/ieee80211softmac_wx.c:306:ieee80211softmac_wx_get_rate()
>  >
>  > but, strangely enough, eth1 does not appear, but eth2 appears instead:
>  >
> 
> Usually the problem generates an oops, but I think your problem is due to the changes in the work 
> struct in 2.6.20-rc1. There is a fix in the pipeline, but it has not propagated through the system.
> 
> You should apply the work_struct2 patch attached. If your computer has a switch to kill the RF, you 
> may also wish to apply the radio_hwenable patch, which should cause the radio LED to be turned on.
> 
> The selection of eth2 rather than eth1 is probably due to the rules in 
> /etc/udev/rules.d/30-net_persistent_names.rules.

Ah, I'll check that, thanks.  It used to be eth1, though, and I haven't changed
the  udev configuration myself.

> When I boot a softmac version, my bcm43xx device is  
> wlan0, but when I boot the d80211 version, it is eth1. I have a second bcm43xx card, which becomes 
> eth2 under softmac.

Thanks for the patch.  In the meantime I've browsed the bcm43xx-dev archives
and found some other interesting patches for me to try. ;-)

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

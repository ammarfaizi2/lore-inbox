Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUITEYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUITEYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUITEWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:22:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:16579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265996AbUITEWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:22:22 -0400
Date: Sun, 19 Sep 2004 21:11:02 -0700
From: Greg KH <greg@kroah.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040920041101.GB5344@kroah.com>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <cijrui$g9s$1@sea.gmane.org> <20040919173221.GB2345@kroah.com> <Pine.LNX.4.60.0409192004020.30139@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0409192004020.30139@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 08:43:50PM +0200, Grzegorz Kulewski wrote:
> I have Gentoo with udev (with 100% modular kernel). And I have speedtouch 
> USB ADSL modem. I am using paralell startup scripts feature. And 
> speedtouch tries to initialize itself (load firmware and so on) before USB 
> bus (or how to call it) is discovered.

That's not good.

> I can imagine moving firmware loader to udev.d scripts but where
> should I place pppd launching (for example I might have pppd or
> ifconfig binary on nfs mounted /usr from my LAN...).

The firmware downloader should be in the usb hotplug agent notifier
location.  See the linux-hotplug documentation for how to do this
properly (I thought the speedtouch driver package already did this
properly for some reason...)

Use the network scripts to start up the connection when it is seen by
the system.  Gentoo currently does this already today.

> And how udev, hotlpug and the rest of the system should hadle SATA disk 
> unpluggged in the middle of writing? And what if it will be plugged back?

udev will delete the device node.  As for your data the user is screwed
as they did something very stupid :)

Plug the device back in, and it gets discovered, device node gets
created, and then mounted.  That is if your SATA kernel driver supports
hotpluggable disks.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbUCTNZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263405AbUCTNZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:25:11 -0500
Received: from barclay.balt.net ([195.14.162.78]:1441 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S263402AbUCTNZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:25:06 -0500
Date: Sat, 20 Mar 2004 15:23:35 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
Message-ID: <20040320132334.GB13028@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> <405C1B14.6000206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405C1B14.6000206@gmx.de>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Exactly the same here on Debian/Unstable 2.6.5-rc2.

Though I can't say it locks up on. Remove modules manually
rmmod ehci_hcd
rmmod ohci_hcd

Usually it takes some time and eventually rmmod returns successfully
removing modules !

In my case when system boots up - USB mouse is not working. 
If I remove and reinstaer ehci_hcd and ohci_hcd - everything seems fine.

$ ps -C rmmod -o pid,uid,state,wchan=WIDE-WCHAN-COLUMN
  PID   UID S WIDE-WCHAN-COLUMN
 1844     0 D usb_disable_device
 2209     0 D rwsem_down_write_failed


Perhaps that will help ...

On Sat, Mar 20, 2004 at 11:21:08AM +0100, Prakash K. Cheemplavam wrote:
> Hi,
> 
> it already started with 2.6.5-rc1: On shutdown/reboot when hotplug 
> service stops, it hangs. I found out that hotplug has trouble in 
> removing ohci-hcd module, ie, it doesn't seem to work. killall -9 rmmod 
> doesn't remove that process, neither. (Module unloading is in the kernel).
> 
> Which infos are needed furthermore?
> 
> Cheers,
> 
> Prakash
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

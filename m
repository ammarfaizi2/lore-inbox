Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbRFBT2b>; Sat, 2 Jun 2001 15:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbRFBT2V>; Sat, 2 Jun 2001 15:28:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262681AbRFBT2H>; Sat, 2 Jun 2001 15:28:07 -0400
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
To: bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu)
Date: Sat, 2 Jun 2001 20:25:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mark@somanetworks.com (Mark Frazer),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0106022016020.22912-100000@kenzo.iwr.uni-heidelberg.de> from "Bogdan Costescu" at Jun 02, 2001 09:10:44 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156H20-00023o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One application needs to poll link status with 1 second resolution. On a

Then it needs to be privileged

> for how long this situation lasts. If you have a proc/ioctl interface for
> setting cache expiring time, this same interface can then be used for
> reading back this info. This application can then check that this value is
> lower than 1 second and if not, notify the user that it cannot run.

And if the approach is to block until the time for the next read occurs is
done then the program get stuck for 30 seconds, misses its deadline and kills
the cluster - how is this better ??

> Usually, the transceivers return garbage if you read from locations you
> are not supposed to (overwritting phy_ad).  But if you begin overwritting
> the READ command (0xf6 above)... Something like this should do:

Some of them just hang.

> Too tired to think straight yesterday... You're right. And if you alloc
> 32*sizeof(int) (you want to keep jiffies, right ?) per netdevice, I think
> that it could even be done outside the driver. Hmm, most of my
> previous arguments are no longer valid 8-(

Doing the MII monitoring somewhere centralised like the routing daemons would
certainly let more inteillgent management and reporting get done


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTCOBwc>; Fri, 14 Mar 2003 20:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbTCOBwb>; Fri, 14 Mar 2003 20:52:31 -0500
Received: from palrel11.hp.com ([156.153.255.246]:50405 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S261294AbTCOBwa>;
	Fri, 14 Mar 2003 20:52:30 -0500
Date: Fri, 14 Mar 2003 18:03:09 -0800
To: Patrick Mochel <mochel@osdl.org>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       mika.penttila@kolumbus.fi
Subject: Re: [PATCH] driver model: fix platform_match [Was: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]]
Message-ID: <20030315020309.GA1372@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030305063912.GA2520@brodo.de> <Pine.LNX.4.33.0303051016230.994-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303051016230.994-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 10:16:46AM -0600, Patrick Mochel wrote:
> 
> > Unfortunately, this won't work: digits are perfectly valid entries of
> > strings. However, we have the name without the appending instance still
> > saved in platform_device pdev->name... so what about this?
> 
> D'oh. You're completely right. 
> 
> Thanks,
> 
> 
> 	-pat

	Hi,

	I tried 2.5.64-bk9, and it doesn't work !

	You simply forgot to apply the patch I sent you at the
very beggining of this discussion :
----------------------------------------------------
diff -u -p linux/drivers/base/platform.c.original linux/drivers/base/platform.c
--- linux/drivers/base/platform.c.original      Fri Mar 14 17:47:16 2003
+++ linux/drivers/base/platform.c       Fri Mar 14 17:47:40 2003
@@ -75,5 +75,6 @@ int __init platform_bus_init(void)
        return bus_register(&platform_bus_type);
 }
 
+EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
----------------------------------------------------
	
	On the other hand, with the above patch, now everything is
working properly and my Pcmcia card work wonderfully.

	Thanks a lot for the great work, and have fun...

	Jean


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWBRQAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWBRQAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWBRQAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:00:21 -0500
Received: from methan.in-berlin.de ([130.133.8.34]:58340 "EHLO
	methan.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751417AbWBRQAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:00:20 -0500
X-Envelope-From: calle@calle.in-berlin.de
Date: Sat, 18 Feb 2006 16:46:58 +0100
From: Carsten Paeth <calle@calle.in-berlin.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Armin Schindler <armin@melware.de>, Adrian Bunk <bunk@stusta.de>,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, kkeil@suse.de
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
Message-ID: <20060218154658.GF9062@calle.in-berlin.de>
References: <20060131213306.GG3986@stusta.de> <1138743844.3968.14.camel@localhost.localdomain> <20060202214059.GB14097@stusta.de> <1138924621.3788.2.camel@localhost.localdomain> <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de> <1138956828.3731.2.camel@localhost.localdomain> <Pine.LNX.4.61.0602031110280.15581@phoenix.one.melware.de> <1138996640.3830.5.camel@localhost.localdomain> <20060212110903.GD17864@calle.in-berlin.de> <1139744175.5070.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139744175.5070.6.camel@localhost>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Feb 12, 2006 at 12:36:15PM +0100, Marcel Holtmann schrieb:
> Hi Calle,
> 
> > I have no problems, when capifs is removed, but the pppdcapiplugin
> > has to work without it.
> > So if you want to remove capifs make sure pppdcapiplugin is
> > working without problems together with udev ...
> > 
> > I'm too busy to check pppdcapiplugin together with udev ....
> 
> I posted this patch some time ago (actually April 2004) which made pppd
> wait for the device node to be created before failing. I used it since
> then and it still works fine for me.

Oh, I missed that patch. So check it in und remove capifs :-)

calle

> 
> Regards
> 
> Marcel
> 

> Index: capiplugin.c
> ===================================================================
> RCS file: /i4ldev/isdn4k-utils/pppdcapiplugin/capiplugin.c,v
> retrieving revision 1.33
> diff -u -r1.33 capiplugin.c
> --- capiplugin.c	16 Jan 2004 15:27:13 -0000	1.33
> +++ capiplugin.c	12 Apr 2004 13:20:50 -0000
> @@ -1413,6 +1413,11 @@
>  	   fatal("capiplugin: failed to get tty devname - %s (%d)",
>  			strerror(serrno), serrno);
>  	}
> +	retry = 0;
> +	while (access(tty, 0) != 0 && (retry++ < 4)) {
> +	   dbglog("capiplugin: capitty not available, waiting for device ...");
> +	   sleep(1);
> +	}
>  	if (access(tty, 0) != 0 && errno == ENOENT) {
>  	      fatal("capiplugin: tty %s doesn't exist - CAPI Filesystem Support not enabled in kernel or not mounted ?", tty);
>  	}


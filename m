Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313025AbSDCDCL>; Tue, 2 Apr 2002 22:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSDCDCB>; Tue, 2 Apr 2002 22:02:01 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:57349 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313025AbSDCDBr>;
	Tue, 2 Apr 2002 22:01:47 -0500
Date: Tue, 2 Apr 2002 19:00:38 -0800
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir257_usb_disconnect_atomic-2.diff
Message-ID: <20020403030038.GA6366@kroah.com>
In-Reply-To: <20020402182413.G24912@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 06 Mar 2002 00:55:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 06:24:13PM -0800, Jean Tourrilhes wrote:
> @@ -1519,33 +1544,47 @@ static void *irda_usb_probe(struct usb_d
>  /*
>   * The current irda-usb device is removed, the USB layer tell us
>   * to shut it down...
> + * One of the constraints is that when we exit this function,
> + * we cannot use the usb_device no more. Gone. Destroyed. kfree().
> + * Most other subsystem allow you to destroy the instance at a time
> + * when it's convenient to you, to postpone it to a later date, but
> + * not the USB subsystem.
> + * So, we must make bloody sure that everything gets deactivated.
> + * Jean II

That's one of the next things I'm going to be working on fixing :)

The patch looks good.  Thanks for setting the proper GFP_* flag.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUAAUAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAAUAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:00:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:24212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264563AbUAAUAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:00:14 -0500
Date: Wed, 31 Dec 2003 15:03:54 -0800
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Message-ID: <20031231230354.GA10245@kroah.com>
References: <200312210137.41343.dtor_core@ameritech.net> <20031222093759.GB30235@kroah.com> <200312222229.17991.dtor_core@ameritech.net> <1072169289.2876.57.camel@pegasus> <20031231223244.GO24577@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231223244.GO24577@ranty.pantax.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 11:32:44PM +0100, Manuel Estrada Sainz wrote:
> 
>  Maybe some generic mechanism could be implemented to make the hotplug
>  event wait for the files.

No.

>  The least intrusive solution, although it doesn't sound quite clean could be:
> 
>  - Kernel side:
>  	- sysfs_hotplug_frezze()
>  		- Creates a dummy file /sys/.hotplug_frozen
>  	- sysfs_hotplug_thaw()
>  		- Removes /sys/.hotplug_frozen
>  - Userspace:
> 	- Main hotplug script waits "while [ -f /sys/.hotplug_frozen ]".

Ick.  You realize how many hotplug events we spit out already today?
This would be a huge bottleneck.

It's not that tough to just see if the file you are looking is there,
and if not sleep.  If after an ammount of time the file still isn't
there, just give up.

Also, not all hotplug scripts care about sysfs files being present :)

thanks,

greg k-h

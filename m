Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUISRnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUISRnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUISRno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:43:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:33000 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261239AbUISRnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:43:42 -0400
Date: Sun, 19 Sep 2004 10:30:35 -0700
From: Greg KH <greg@kroah.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040919173035.GA2345@kroah.com>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <cikaf1$e60$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cikaf1$e60$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 10:00:52PM +0600, Alexander E. Patrakov wrote:
> 
> OK. The fact is that, when mounting the root filesystem, the kernel can 
> (?) definitely say "there is no such device, and it's useless to wait 
> for it--so I panic". Is it possible to duplicate this logic in the case 
> with udev and modprobe? If so, it should be built into a common place 
> (either the kernel or into modprobe), but not into all apps.

No, we need to just change the kernel to sit and spin for a while if the
root partition is not found.  This is the main problem right now for
booting off of a USB device (or any other "slow" to discover device.)
It's a known kernel issue, and there are patches for 2.4 for this, but
no one has taken the time to update them for 2.6.

> Then the "char-major" aliases were always broken, do I understand 
> correctly?

Yes, for most drivers they are broken.  Like sound, usb, and others.

> Once we realize that, isn't it the time to mark the 
> "Automatic kernel module loading" in the kernel configuration as BROKEN 
> or OBSOLETE?

Fine with me, I've been wanting to do that for years.  Are you willing
to handle the fallout of such a patch though?  :)

> >With hotplug/udev you *know* that the device node is available when your
> >script in dev.d is called with the appropriate environment variables.
> 
> Yes. Now we have a lot of short scriptlets under /etc/dev.d. But I don't 
> yet see how these scriptlets interact with each other.

What do you mean?  What kind of relationship do you need explained about
them?

thanks,

greg k-h

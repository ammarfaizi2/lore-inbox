Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966907AbWKUDB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966907AbWKUDB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 22:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966908AbWKUDB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 22:01:56 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34696 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965885AbWKUDBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 22:01:55 -0500
X-Sasl-enc: nB3CQAUgqYcuvH5keljxbQakE9Nf74v+buta5vV4vW3W 1164078114
Date: Tue, 21 Nov 2006 01:01:46 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: James Simmons <jsimmons@infradead.org>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
       Lennart Poettering <mzxreary@0pointer.de>,
       Andriy Skulysh <askulysh@image.kiev.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
       Holger Macht <hmacht@suse.de>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Message-ID: <20061121030146.GA31304@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net> <1162773394.5473.18.camel@localhost.localdomain> <20061110000829.GA9021@khazad-dum.debian.net> <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, James Simmons wrote:
> > The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
> > devices and likely do not want the "dim and power off backlight on
> > backlight_device_unregister" behavior:
> > 
> > drivers/video/aty/*
> > drivers/video/riva/fbdev.c
> > drivers/video/nvidia/nv_backlight.c
> > drivers/misc/msi-laptop.c
> 
> ...
>  
> > I have CC'ed the relevant people (please forgive me any ommissions) for the
> > drivers listed above, so they can chime in if their driver should retain the
> > "dim and power off backlight on backlight_device_unregister" behaviour.
> 
> Hm. In the case of some drivers the hardware state on x86 is set back to 
> text mode in some cases. So do we in that case dim the backlight?

I would very much *hate* that happening on any x86 box of mine.  I won't
presume I understand enough of the usage pattern on weird devices, and it
would make some sense to power off the display if you are removing the
*only* way to talk to the video device (but I still think this is naively
assuming the local admin don't want to just leave the display as-is).

But as you said yourself, in regular desktop/laptops (at least x86 ones)
textmode is there, and works just fine, so killing the display on module
removal is wrong IMO.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

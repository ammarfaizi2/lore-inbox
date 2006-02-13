Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWBMUiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWBMUiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBMUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:38:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:53414
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964877AbWBMUiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:38:21 -0500
Date: Mon, 13 Feb 2006 12:38:00 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060213203800.GC22441@kroah.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 07:05:20PM -0800, Andrew Morton wrote:
> 
> We still have some serious bugs, several of which are in 2.6.15 as well:
> 
> - Nathan's "sysfs-related oops during module unload", which Greg seems to
>   have under control.

Yes, this isn't a "regression" but has been there for a while.  It can
also only be triggered by a root user, so it's severity is much lower.

> - Various reports similar to
>   http://bugzilla.kernel.org/show_bug.cgi?id=6011, seemingly related to USB
>   PCI quirk handling.

I have a patch for this, which will be going to Linus later tonight.

> - Nasty warnings from scsi about kobject-layer things being called from
>   irq context.  James has a push-it-to-process-context patch which sadly
>   assumes kmalloc() is immortal, but no other fix seems to have offered
>   itself.

This has been the case for a long time.  I don't really think there is a
rush to get this fixed, but I really like James's proposed patch.  It's
up to him if he feels it is ready for 2.6.16 or not.

> - Helge Hafting reports a usb printer regression - I don't know if that's
>   still live?

He never reported back, and one other person who reported this, figured
out that it was bad ram in the system.  Replacing that fixed the issue.
I've also printed a lot of stuff here (tax time...) and had no problems.

> - "Carlo E.  Prelz" <fluido@fluido.as> has another USB/ehci regression
>   ("ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15
>   rc1").

Fixed by the previously mentioned EHCI quirk/handoff patch that will be
going to Linus.

So, that's it for the USB stuff, thankfully.

thanks,

greg k-h

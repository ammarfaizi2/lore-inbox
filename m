Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUFGOTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUFGOTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUFGOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:19:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59664 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264659AbUFGOSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:18:14 -0400
Date: Mon, 7 Jun 2004 15:18:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz,
       torvalds@osdl.org
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
Message-ID: <20040607151806.C28526@flint.arm.linux.org.uk>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz,
	torvalds@osdl.org
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk> <40C107D2.9030301@pobox.com> <s5hekor4i2c.wl@alsa2.suse.de> <40C471FC.3000802@pobox.com> <s5h7juj4gio.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s5h7juj4gio.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 07, 2004 at 03:57:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 03:57:51PM +0200, Takashi Iwai wrote:
> They're nice but they don't provide "cast checking", no?
> The main purpose of the magic_* stuffs in ALSA is to check the cast of
> the void pointer back to the original data type, which the compiler
> can't check.
> 
> Maybe we can implement only this "magic" check separetly and get rid
> of allocation checks, but I'm not sure whether it's worthy to do
> that.

I must ask the question: why is ALSA such a special case that it
needs this level of "magic" checking, when the rest of the kernel
has happily used void pointers to carry driver specific data around
for the last 10 years without serious incident or any major debugging
problems?

As long as objects are cleanly defined, and it is obvious what these
private driver specific pointers are for, then this "magic" become
unnecessary.  Take a look at the driver model for instance.

For instance, dev_set_drvdata() and dev_get_drvdata() provide access
to a clearly defined void pointer for drivers to use.  It is clear
that a device driver uses it to place its private data structure
there, and it is the only code which should be accessing that.

I guess though that the problem area for ALSA is the way the snd_pcm_t
private_data member magically appears in the snd_pcm_substream_t
private_data member behind the drivers back, so it's unclear who
actually owns the data in the private_data members.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVHUVpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVHUVpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVHUVpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:45:17 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:32699 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751169AbVHUVo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:44:57 -0400
Date: Sun, 21 Aug 2005 23:44:36 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050821214436.GA6935@ens-lyon.fr>
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <40f323d005082109303c0865a3@mail.gmail.com> <9e47339105082110405b2a48c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105082110405b2a48c8@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 01:40:31PM -0400, Jon Smirl wrote:
> On 8/21/05, Benoit Boissinot <bboissin@gmail.com> wrote:
> > On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> > >
> > > - Lots of fixes, updates and cleanups all over the place.
> > >
> > > - If you have the right debugging options set, this kernel will generate
> > >   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> > >   It is being worked on.
> > >
> > >
> > > Changes since 2.6.13-rc5-mm1:
> > > [...]
> > > +gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch
> > > [...]
> > 
> > 
> > it broke loading of firmware for me.(dmesg was flooded with
> > "firmware_loading_store:  unexpected value (0)")
> > 
> > firmware.agent uses echo so there is a trailing newline. If i changes
> > firmware.agent to uses echo -n it works correctly.
> > 
> > Is this a bug or the correct behaviour ?
> 
> Somewhere there is a mistake in the white space processing code of the
> firmware driver. Before this patch we had inconsistent handling of
> whitespace and sysfs attributes. This patch forces it to be consistent
> and will shake out all of the places in the drivers where it is
> handled wrong. Sysfs attributes are now stripped of leading and
> trailing white space before being handed to the device driver.

ok, i found it. If i do echo 1, it will read '1\n', will
remove the '\n' and send '1' to ops->store.
Then it will re-read '\n' and send '' to ops->store.
And it will loop...

Maybe sysfs should return the old count instead of ops->store ?
> 
> Fbdev sysfs attributes are also broken for white space handling and
> need to be fixed. Overall the patch should be correct and it is the
> drivers that are broken.
> 
Regards,

Benoit Boissinot

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS

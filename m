Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992683AbWJTSIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992683AbWJTSIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992684AbWJTSIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:08:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992683AbWJTSIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:08:15 -0400
Date: Fri, 20 Oct 2006 11:07:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: teunis <teunis@wintersgift.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: various laptop nagles - any suggestions?   (note:
 2.6.19-rc2-mm1 but applies to multiple kernels)
Message-Id: <20061020110746.0db17489.akpm@osdl.org>
In-Reply-To: <4538F9AD.8000806@wintersgift.com>
References: <4537A25D.6070205@wintersgift.com>
	<20061019194157.1ed094b9.akpm@osdl.org>
	<4538F9AD.8000806@wintersgift.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 09:30:37 -0700
teunis <teunis@wintersgift.com> wrote:

> 

Please don't play with the Cc:s!  Just do reply-to-all, thanks.

> Andrew Morton wrote:
> > On Thu, 19 Oct 2006 09:05:49 -0700
> > teunis <teunis@wintersgift.com> wrote:
> > 
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Setting the internal clock to 100 Hz stablizes the laptop - and the
> >> synaptics touchpad stops "crashing"  (when "crashed" the pad reads out
> >> all kinds of seemingly random values).   I would suspect the driver
> >> needs adjusting for the variable clock.   Also - it's definitely nicer
> >> on the laptop power use as far as I can tell - should this be in the
> >> documentation?
> > 
> > So you're saying that CONFIG_NO_HZ breaks the touchpad?
> 
> yes.  At least for Acer Travelmate 8000 and HP nx6310 and HP nx7400.
> Other than the touchpad - there is not a lot of common hardware between
> these units.   The readout becomes highly unreliable.   (in X it starts
> jumping around - it SORT OF resembles the output)
> 
> My suspicion is a timing problem in the synaptic USB driver

OK, that's going to be hard to fix and it'd be awkward (and unpopular) to
make inclusion of the dynamic-ticks feature dependent on fixing this. 
(Then again, it'd get Ingo into device drivers ;))

However I would suggest that NO_HZ (at least) be dependent upon
CONFIG_EXPERIMENTAL, no?

Also, NO_HZ breaks my laptop (and presumably quite a few others) quite
horridly, which means nobody can ship the feature.  Some runtime
turn-it-off work needs to be done there.


> - but I'm
> not familiar with timing on kernels these days.  It's been a few years
> since I last really did any kernel work.
> 
> > 
> >> I'm very grateful that compact flash-based booting on a SATA system
> >> works well.   It hasn't been so reliable in 2.6.19-rc2-mm1 for IDE/CF
> >> adaptors but I haven't yet solved why.   (tested with various laptops)
> > 
> > hm.  What goes wrong?
> 
> Fails to boot some of the time on SanDisk ultraII 8.0GB and SanDisk
> Extreme IV 8.0GB.   The latter is less stable.   It crashes during GRUB
> read actually so I haven't been entirely sure it's a kernel problem...

Don't know, sorry.

> > 
> >> resume from "suspend to ram" (ACPI S3 mode) - the keyboard and mouse do
> >> not recover on 945G chipset.   Note that otherwise the chipset works
> >> well in 2.6.19-rc2-mm1 - and this is the first kernel that does work well).
> > 
> > So this might not be a new bug?
> 
> A regression.   2.6.19-rc1-git6 seemed to work actually.   I couldn't
> get any other kernel to work though...   mind you, 2.6.18 worked as well
> although the intel 945G driver did not - so X was operating under VESA only.

So you're saying that there is some patch in the -mm lineup which causes
the keyboard and mouse to die after resume-from-RAM?

What makes you think this is related to the 945G support?

> >> LVM2 - when adding and removing physical volumes (again, on Compact
> >> Flash cards via USB and Firewire adaptors) - it doesn't always remove
> >> the volume properly (pvremove /dev/sda or equiv) from the device-mapper.
> >>  This leaves me unable to plug in another.   I suspect this to be an
> >> LVM2 problem (no hotplug?) rather than a compact flash or SCSI problem.
> > 
> > Can you identify an earlier kernel in which this worked OK?
> 
> As far as I can it never has.
> 
> I've only tested it with:
> 2.6.16-debian, 2.6.17-debian, 2.6.18, 2.6.19, 2.6.19-rc1,
> 2.6.19-rc1-git4, 2.6.19-rc1-git6, 2.6.19-rc2, 2.6.19-rc2-mm1 (which
> otherwise works quite nicely)

Please try 2.6.19-rc2-mm2: it has a blockdev refcounting fix (well - a
change, at least) which could conceivable help here.

Also, if you're keen,
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt will
allow us to identify the problematic -mm patches.  It would be super-useful
is you could do that.

Thanks.


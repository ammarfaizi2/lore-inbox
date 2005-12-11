Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbVLKFdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbVLKFdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVLKFdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:33:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:29589
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161090AbVLKFdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:33:35 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Date: Sat, 10 Dec 2005 23:30:30 -0600
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512071214.26574.rob@landley.net> <20051210083503.GA2833@ucw.cz>
In-Reply-To: <20051210083503.GA2833@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512102330.31572.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 December 2005 02:35, Pavel Machek wrote:
> On Wed 07-12-05 12:14:25, Rob Landley wrote:
> > On Tuesday 06 December 2005 12:51, Bill Davidsen wrote:
> > > Just so we're all on the same page, I think there are two sets of
> > > unhappy people here... one is the group who want new stuff fast and
> > > stable. For the most part that's not me, although I was in the "if
> > > you're going to add ipw2200 support, why not something that works?"
> > > group. But new stuff is going in faster than most people can assimilate
> > > it if they have a real job, so I don't see too much problem there.
> >
> > My laptop has an ipw2200 but I can't get it to work in any kernel I built
> > because the kernels I build aren't modular.  I hope to be able to work
> > around this someday with a clever enough initramfs (if necessary, moving
> > the initramfs initialization earlier in the boot sequence), but it hasn't
> > made it far enough up my todo list yet.
>
> Well, building modular kernel for a test is not *that* much work.
> Anyway, if you are going to fix it, fix it properly (by
> delayed firmware loading) -- initrd hacks are good for you
> but unusable for anyone else.

I don't see why that's any less usable than using udev from initramfs to find 
your root partition.

There is an interesting licensing issue, creating a linux kernel image that 
contains an initramfs that contains binary only firmware.  I can happily 
generate one here and not care, but does distributing such a kernel violate 
the GPL?

It's probable that the "early userspace" mechanism is a clearly defined API.  
We documented the heck out of the format, it cpio was already a standard 
anyway.  The binaries that are in there call the normal userspace API 
(syscall/ioctl/procfs etc) that is an established strong barrier to being a 
derived work.  So it's possible that putting those binaries in initramfs 
counts as "mere aggregation".  (If you had the kernel and the firmware in an 
ISO image, that's the same as being different files on the same CD, and 
definitely mere aggregation.  As separate files in the same tarball, it's 
closer but functionally equivalent and probably still just aggregation.  
Probably.  Different elf sections in the same binary is one more step, but 
depending on the intent the analogy could still hold...)

I can see distributors shying the heck away from it anyway, and wanting to 
keep things in _seperate_files_.  And I can entirely understand that.  This 
means if initramfs is going to contain firmware, the option of having it be a 
separate file like initrd for legal reasons is a darn good idea.

Query: if you tell lilo or grub that it has an initrd but feed it a gzipped 
cpio image, will the kernel figure everything out and initialize initramfs 
from that appropriately?

>         Pavel

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

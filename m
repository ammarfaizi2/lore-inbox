Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTLaWBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbTLaWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:01:11 -0500
Received: from rrcs-se-24-123-187-193.biz.rr.com ([24.123.187.193]:18075 "EHLO
	max.bungled.net") by vger.kernel.org with ESMTP id S265229AbTLaWBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:01:08 -0500
Date: Wed, 31 Dec 2003 17:01:07 -0500
From: Nathan Conrad <lk@bungled.net>
To: Rob Love <rml@ximian.com>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20031231220107.GC11032@bungled.net>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072901961.11003.14.camel@fur>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing that I'm confused about with respect to device files is how
kernel arguments are supposed to work. Now, we _seem_ to have a
mish-mash of different ways to tell the kernel which device to open as
a console, which device to use as a suspend device, etc.... Now, all
of the device names are being migrated to userland. How is the kernel
supposed to determine which device to use when it is told use
/dev/hda3 or /dev/ide/host0/something/part3 as the suspend partition?
The kernel no longer knows to which device this string this device is
connected.

(I have not looked into how these parameters are parsed; this is pure
speculation)

One solution that I see if the device names are totally removed from
the kernel is specifying these parameters as sysfs paths. Would this
work? Or is there a better way?

-Nathan

On Wed, Dec 31, 2003 at 03:19:22PM -0500, Rob Love wrote:
> On Wed, 2003-12-31 at 14:23, Greg KH wrote:
> 
> > What benefit would there be in "random" numbers? More compressed number
> > space by giving out numbers sequentially?
> 
> That is one advantage.
> 
> > Or less having to work with the numbers because they become just
> > cookies and never need to be inspected except in very small parts of
> > the kernel?
> 
> Yup, especially this one.  It is not so much "let's make the device
> numbers random" but "let's just not care what they are."
> 
> We can get to the point where we don't even need the explicit concept of
> device numbers, but just "any old unique value" to use as a cookie.  The
> kernel can pull that number from anywhere, and notify user-space via
> udev ala hotplug.
> 
> 	Rob Love
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Nathan J. Conrad                     Campus phone #5930
301 Scott hall, UNC Charlotte        http://bungled.net
GPG: F4FC 7E25 9308 ECE1 735C  0798 CE86 DA45 9170 3112

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263525AbUJ2W3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbUJ2W3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbUJ2W0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:26:23 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:56193 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263606AbUJ2WGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:06:44 -0400
Date: Sat, 30 Oct 2004 00:06:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041029220621.GB21522@vana.vc.cvut.cz>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com> <200410272012.44361.dtor_core@ameritech.net> <20041029205505.GB30638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029205505.GB30638@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:55:05PM -0500, Greg KH wrote:
> 
> You are right, class_simple is merely a wrapper around the core class
> and class_device functions.  It makes it easier for a driver subsystem
> to implement a very common feature.
> 
> See, "wrapper" is the point here.  If we were to have someone try to
> submit the class_simple code today, after the driver core had the GPL
> function exports on them, we would laugh them out of the room on the
> grounds that they were wrapping GPL interfaces with a looser one.  So,
> because of that, I'm going to mark these functions this way.

It is not correct argument.  That you turned them to GPL-only just
week before you sent change for class_simple does not negate that they
existed since 2.6.0 as non-GPL exports.

I had code for vmnet which were better than one using class_simple
(class_simple has problem that when you create 256 devices at once,
udevd spawns 256 subprocesses, each wanting ~1MB memory, and all
in runable state; it takes ~10sec until 1GHz 512MB K7 box comes
back to life), but since you changed GPL-ness of driver core, when
you sent first patches I just thought that it is intentional that
you left class_simple untouched in first round and did not complain
immediately when I saw your first GPLization patch.

> As to people saying it's futile to try to get companies to change, I
> don't buy that.  Go look up the history of the EXPORT_SYMBOL_GPL marker
> and see who used it first.  I know for a fact that because of this
> marking on some kernel functions a very large company totally switched
> directions and rethought their policies about Linux kernel
> drivers/modules.  Now that company has plays very nicely with the Linux
> kernel community, and contributes a lot of very good, useful, and needed
> code, all under the GPL.

And it was API which was accessible by non-GPL modules before?  Your
way looks more like GIF patent to me - first leave API open for 9 months so
every distribution and all external providers jump on udev, and then
close API and require everybody to relicense code under license of your
choice.

> So we can change things, little things like this can help everyone out,
> even if I'm going to get a ton of nvidia user hate mail directed to me
> after the next kernel comes out...
> 
> Remember, binary kernel modules are a leach on our community.

I cannot speak for NVidia, but VMware's modules are opensource.  Their
license is just not compatible with GPL, so your argument about binary kernel
modules fall short here.
				Thanks,
					Petr Vandrovec

P.S.: mknod solution in initscript saves ~60 bytes on disk and 220 bytes
of kernel memory, plus mp3 player does not stop for 10 sec after loading 
vmnet ;-)  I must thank you for changing availability of your API, it
allowed me to see how to do things more efficiently.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWBTBC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWBTBC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWBTBC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:02:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32225
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932489AbWBTBCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:02:55 -0500
Date: Sun, 19 Feb 2006 17:02:05 -0800
From: Greg KH <gregkh@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060220010205.GB22738@suse.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140383653.11403.8.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 11:14:13PM +0200, Pekka Enberg wrote:
> On 2/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > > Subject    : gnome-volume-manager broken on powerpc since 2.6.16-rc1
> > > > References : http://bugzilla.kernel.org/show_bug.cgi?id=6021
> > > > Submitter  : John Stultz <johnstul@us.ibm.com>
> > > > Status     : still present in -git two days ago
> 
> On Sun, Feb 19, 2006 at 01:06:45PM +0200, Pekka Enberg wrote:
> > > This is not ppc only. I have the exact same problem on Gentoo
> > > Linux/x86. No ipod events on 2.6.16-rc1, whereas 2.6.15 works fine.
> > > Haven't had the time to investigate further yet, sorry.
> 
> Here's the result of git bisect:
> 
> ba9dc657af86d05d2971633e57d1f6f94ed60472 is first bad commit
> diff-tree ba9dc657af86d05d2971633e57d1f6f94ed60472 (from 733260ff9c45bd4db60f45d17e8560a4a68dff4d)
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Date:   Wed Nov 16 13:41:28 2005 -0800
> 
>     [PATCH] USB: allow usb drivers to disable dynamic ids
> 
>     This lets drivers, like the usb-serial ones, disable the ability to add
>     ids from sysfs.
> 
>     The usb-serial drivers are "odd" in that they are really usb-serial bus
>     drivers, not usb bus drivers, so the dynamic id logic will have to go
>     into the usb-serial bus core for those drivers to get that ability.
> 
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> :040000 040000 ed98c56f9d575c69ff8d590f336ab259be360230 1ffa39f0d0afdf7deda0cf4270f29fa6af1a5d5c M      drivers
> :040000 040000 cae5649115b1ea49c732bc940009161f222042af c6bb3c2357a4bfe3dab8bc900a38b4ea344207cd M      include
> 
> Please note that with the above changeset, hal and udev daemons refuse
> to start up during boot so I don't even have /dev/sda2 when plugging in
> ipod.

That's _really_ odd, as hal, udev and dbus all work just fine on my
machines with the above changeset (actually with 2.6.16-rc4).  And that
changeset should not have caused anything to change with regards to the
core uevent code, as it's a usb-serial change only.

And you don't even have CONFIG_USB_SERIAL enabled...  Very odd.

If you revert this one patch, on top of a clean 2.6.16-rc4, do things
start working for you again?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUAGROW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUAGROW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:14:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:49862 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265598AbUAGROP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:14:15 -0500
Date: Wed, 7 Jan 2004 09:14:03 -0800
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040107171403.GB31177@kroah.com>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl> <20040106000014.GL30464@kroah.com> <20040106024115.B1153@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106024115.B1153@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 02:41:15AM +0100, Andries Brouwer wrote:
> On Mon, Jan 05, 2004 at 04:00:15PM -0800, Greg KH wrote:
> 
> > > > Have you even _tried_ udev?
> > > 
> > > Yes, and it works reasonably well. I have version 012 here.
> > > Some flaws will be fixed in 013 or so.
> > 
> > What flaws would that be?  The short time delay for partitions?  Or
> > something else?
> 
> Yes, partitions are not handled very well.
> So far I have never seen udev discover partitions on its own.

That is because it can not.  Please see the current thread "removable
media revalidation - udev vs. devfs or static /dev" on lkml for a
solution to this.

> > > Some difficulties are of a more fundamental type, not so easy to fix.
> > 
> > Such as?
> 
> Udev cannot do anything when there are no events.
> And media insertion or removal does not always give events.

Exactly.  That's why userspace needs to poll for this.

> [By the way, a compilation warning for every C file:
> % make
> gcc  -pipe -Wall -Wmore.. -Os -fomit-frame-pointer -D_GNU_SOURCE \
>   -I/usr/lib/gcc-lib/i486-suse-linux/3.2/include -I.../udev-012/libsysfs
>   -c -o udev.o udev.c
> cc1: warning: changing search order for system directory
>      "/usr/lib/gcc-lib/i486-suse-linux/3.2/include"
> cc1: warning: as it has already been specified as a non-system directory]

Odd, it works here just fine on a number of different Red Hat boxes :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUAFAtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAFAqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:46:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:46262 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266035AbUAFAn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:43:59 -0500
Date: Mon, 5 Jan 2004 16:43:43 -0800
From: Greg KH <greg@kroah.com>
To: Shawn <core@enodev.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, Linus Torvalds <torvalds@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106004343.GB1043@kroah.com>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <1073341077.21797.17.camel@localhost> <20040105222559.GA3513@mark.mielke.cc> <1073343916.21797.21.camel@www.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073343916.21797.21.camel@www.enodev.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:05:16PM -0600, Shawn wrote:
> On Mon, 2004-01-05 at 16:25, Mark Mielke wrote:
> > On Mon, Jan 05, 2004 at 04:17:57PM -0600, Shawn wrote:
> > > ...
> > > As an admin, would I at least theoretically have /some/ consistency if
> > > merely for my own sanity when dealing with block devices by hand (I do
> > > need to setup LVM stuff from time to time)??
> > 
> > If all you care about is that /dev names remain consistent, you need
> > not fear. udev and devfs are two different ways of providing this
> > consistency. They abstract the device numbers from the /dev names,
> > meaning that you don't have to care if the numbers change. The names
> > don't.
> I'm obviously confused if this is true, as then I do not know how the
> great and powerful udev derives the names if not from the numbers, or
> some other sysfs info.

udev can derive the names for the /dev entries from just about anything
you can think of:
	- sysfs files
	- bus topology
	- bus ids
	- any script/program that you might want to run
	- the kernel name

It will default back to the "kernel name" that shows up in sysfs, and is
what we currently use, if it can not match up any other name to it.  The
method of creating these rules that udev uses, are contained in the
udev.rules file.  See the udev man page for the syntax and some example
rules.  Also see the example udev.rules and udev.rules.devfs files for
lots more example rules that you might want to come up with.

The strength in this is that udev can poke around and try to find a
unique "tag" that a specific device exports (be it UUID, or a CDDB
entry) and use that to match up a name to.  That enables your cdrom to
always be called /dev/cdrom no matter where in the scsi chain it happens
to be.

In summary, udev doesn't care squat about the major/minor that the
kernel has used for a device.  It merely uses those numbers and creates
a /dev entry with them, assigned to a name that it comes up with.

Does that help out?  The udev OLS paper might also help explain some of
this.

thanks,

greg k-h

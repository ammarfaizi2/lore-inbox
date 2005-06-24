Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbVFXTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVFXTIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVFXTIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:08:45 -0400
Received: from nome.ca ([65.61.200.81]:11918 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S263170AbVFXTFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:05:07 -0400
Date: Fri, 24 Jun 2005 12:05:15 -0700
From: Mike Bell <mike@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624190513.GA1046@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624081808.GA26174@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 01:18:08AM -0700, Greg KH wrote:
> Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> tiny:
...
> replacement for devfs for those embedded users who just can't live
> without the damm thing.  It doesn't allow subdirectories, and only uses
> LSB compliant names.  But it works, and should be enough for people to
> use, if they just can't wean themselves off of the idea of an in-kernel
> fs to provide device nodes.

As far as ideas go, this is pretty much all I asked for. A simple kernel
filesystem to export device nodes with names, rather than just the
numbers as sysfs does. The "detecting non-existant device names" thing
never meant anything to me personally, and if anyone does care this
gives them a simple place to add such a hook - unlike device names I
don't see why such a thing would be difficult to maintain as a patch.

It'll obviously need support for symlinks, directories and mknod. And
I'm not sure you can change the mode/owner of those devices yet. Also, I
have no idea what the device support is like yet (am currently in the
middle of nowhere, getting the latest bk to test this patch with over
my handphone would not be fun) but looking at the bit where it's getting
the names from the device model I can see it encountering problems with
oddly named devices. And any devices which aren't dynamic in udev
obviously aren't going to work with this patch either.

What's the method for bootstrapping this filesystem onto a system? Is
a mount from early userspace the only way you'd accept, or would a
kernel parameter to automount over /dev as devfs does be tolerable?

> Now, with this, is there still anyone out there who just can't live
> without devfs in their kernel?

If devfs could be left alone (disabled, if necessary) until something
like this was working, I would be completely mollified.

> For embedded people to use since they seem to hate userspace.

Userspace killed my father.

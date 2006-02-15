Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945940AbWBONm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945940AbWBONm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945942AbWBONm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:42:59 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:10703 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945940AbWBONm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:42:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=j5r2tJs96LgoN5EdkpT4py1en/7bBOHIMRgZKMvpR1RI3vKdiO97NSy73NZ4U7RA2ABtj3Z6dcNfmnhApIaFSh8dSqeRUjAKGcQwoGuy7VRWfMhXzh5lyJsoMhvO3fmC/2OLXy9oIUxmounkct75ckG/JQBmijVD8NA6/swyoH4=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Wed, 15 Feb 2006 08:42:41 -0500
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org>
In-Reply-To: <20060214104003.GA97714@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602150842.41975.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 05:40, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 12:23:15AM -0500, Andrew James Wade wrote:

> > The difficulty is the mapping between sysfs and /dev.
> 
> Which is what I say each time.

Yes, sorry, you do do that.

> > That mapping should not live in sysfs,
> > /dev is none of the kernel's business and sysfs is the kernel's playground.
> 
> Why not have udev and whatever comes after tell the kernel so that a
> symlink is done in sysfs?  The kernel not deciding policy do not
> prevent it from storing and giving back userland-provided information.
> You get the best of both worlds, complete device information including
> how to talk with it in sysfs, and complete naming and policy setting
> in userspace.

Well, as Rob Landley pointed out, /dev is not necessarily the same across
the entire system. I don't know if this is a problem (is sysfs going to be
visible in a chrooted environment anyway?), but I take it as an indication
that /dev shouldn't be any of the kernel's business.

> > 
> >      The mapping could be provided via symlinks, like so:
> > 
> > /dev/rdev/block/hdb/hdb1 -> /dev/hdb1
> > /dev/rdev/block/hdb -> /dev/hdb
> > /dev/rdev/block/hda/hda2 -> /dev/hda2
> > /dev/rdev/block/hda/hda1 -> /dev/hda1
> > /dev/rdev/block/hda -> /dev/hda
> 
> Why manage a directory tree in udev when you have a perfectly good one
> in sysfs already. We're talking about a friggin' userland-provided 
> string here, nothing more.

It is rather ugly to duplicate the directory tree. But it is better
than mission-creep of sysfs. And userspace has to maintain its own view
(or views) of devices anyway: GUIs may want to allow users to assign icons
to devices, or descriptive strings, or who knows what else. That
definitely shouldn't live in sysfs.

> > But I don't know if there is much point in doing so as udev already
> > provides that information.
> 
> I guess you didn't bother to read the "answer 3" paragraph of my
> email.  Do you trust udev to still exist two years from now, given
> that hotplug died in less than that?  Do you trust udevinfo to have
> the same interface two years from now given that the current interface
> is already incompatible with a not even two-years old one (udev 039,
> 15-Oct-2004 according to kernel.org) which is widely deployed as part
> of fedora core 3?

No I don't trust udevinfo to have a stable interface. And that would be
a useful thing to have even if HAL is the only consumer. I suspect it would
be nice for all udev-like solutions to share the same interface. I'm just
hesitant to put forward my suggestion as the right interface.

I'd suggest answer 2 for the problem -- Hal knows it, ask him -- though
that's easy enough to say when I'm not writing the hypothetical program.
Hal can then worry about finding and integrating information about devices
in disparate places. If Hal doesn't provide a suitable interface, that
should be fixed.

Andrew Wade

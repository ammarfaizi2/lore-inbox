Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWIVL0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWIVL0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWIVL0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:26:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:16567 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750883AbWIVL0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:26:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH -mm 0/6] swsusp: Add support for swap files
Date: Fri, 22 Sep 2006 13:28:58 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <1158886913.15894.31.camel@nigel.suspend2.net> <20060922052324.GG2357@elf.ucw.cz>
In-Reply-To: <20060922052324.GG2357@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221328.58504.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22 September 2006 07:23, Pavel Machek wrote:
> On Fri 2006-09-22 11:01:53, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2006-09-20 at 21:20 +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > The following series of patches makes swsusp support swap files.
> > > 
> > > For now, it is only possible to suspend to a swap file using the in-kernel
> > > swsusp and the resume cannot be initiated from an initrd.
> > 
> > I'm trying to understand 'resume cannot be initiated from an initrd'.
> > Does that mean if you want to use this functionality, you have to have
> > everything needed compiled in to the kernel, and it's not compatible
> > with LVM and so on?
> 
> Not in this version of patch; for resume from initrd, ioctl()
> interface needs to be added (*).

Yup.  This is not technically impossible, but the patches don't add an
interface needed for this purpose.

Initially I thought of a sysfs-based one, but it didn't seem to be a good
solution.  I'm going to add an ioctl() to /dev/snapshot that will allow us
to set the "resume offset" from an application.

> 									Pavel
> (*) Actually.. of course resume from file from initrd is possible
> *now*, probably without this patch series, but that would be bmap and
> doing it by hand from userland.

Well, not from a swap file.  To use a swap file for suspending we need a
kernel to tell us which page "slots" are available to us (otherwise we could
overwrite some swapped-out pages).

We could use a regular (non-swap) file like this but that would require us to
use some dangerous code (ie. one that writes directly to blocks belonging to
certain file bypassing the filesystem).  IMHO this isn't worth it, provided
the kernel's swap-handling code can do this for us and is known to work. ;-)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

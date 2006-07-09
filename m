Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWGIXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWGIXhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGIXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:37:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:5563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161219AbWGIXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:37:14 -0400
Date: Sun, 9 Jul 2006 16:36:01 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>, Kay Sievers <kay.sievers@vrfy.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
Message-ID: <20060709233601.GA4646@kroah.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <p73irm8nolj.fsf@verdi.suse.de> <20060708160233.GA4923@kroah.com> <200607100117.30052.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607100117.30052.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 01:17:30AM +0200, Andi Kleen wrote:
> On Saturday 08 July 2006 18:02, Greg KH wrote:
> > On Sat, Jul 08, 2006 at 04:44:08PM +0200, Andi Kleen wrote:
> > > Greg KH <greg@kroah.com> writes:
> > > > 
> > > > Perhaps, that is odd.  The scanner should default to the logged in user,
> > > > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> > > > work on it there.
> > > 
> > > I have a similar problem with my printer. But /dev/usblp0,
> > > /dev/usb/lp0 don't even appear, no matter what the permissions are.
> > 
> > What version of udev are you using?  It works fine for me here with a
> > USB printer (that's what I tested the changes with.)
> 
> udev-068git20050831-9 (from SUSE 10.0 I think) 

That's the issue, look in Documentation/Changes for the proper version
of udev for the past few kernel versions to handle this kind of issue
(again, it was a stupid libsysfs problem, which caused us to finally
drop that piece of crud from udev...)  This has been documented as such
since last October, see commit ad7e14a55ed7648d02a4df8e460e291d80a18c98.

It was necessary to do this for the input drivers to get them to all
work properly, please see the old archives for details as to the
necessity of it.

Also, that change caused the creation of Documentation/ABI/ which
describes the rules that programs that look at sysfs class stuff, must
be able to handle a symlink there.

That older version of udev in 10.0 can't handle the symlink, but I think
that Kay had a version somewhere that was patched to handle it.  I'd
just recommend upgrading to 10.1 :)

thanks,

greg k-h

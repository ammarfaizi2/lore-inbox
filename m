Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWCIWnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWCIWnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCIWnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:43:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3533 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751814AbWCIWnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:43:31 -0500
Date: Thu, 9 Mar 2006 14:42:53 -0800
From: Greg KH <gregkh@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com, tilman@imap.cc,
       rdunlap@xenotime.net, linux-usb-devel@lists.sourceforge.net,
       hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-ID: <20060309224253.GA18899@suse.de>
References: <440F609F.8090604@imap.cc> <20060309030257.5c1e0f30.akpm@osdl.org> <20060309083412.95e145ea.rdunlap@xenotime.net> <44107739.9070204@imap.cc> <9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com> <20060309130327.32ef68de.akpm@osdl.org> <20060309131847.44e1ab79.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309131847.44e1ab79.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:18:47PM -0800, Pete Zaitcev wrote:
> On Thu, 9 Mar 2006 13:03:27 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> > >
> > > > Feb 21 00:12:13 gx110 kernel: gigaset: ISDN_CMD_SETL3: invalid protocol 42
> > >  >
> > >  > do not provide any useful information for that clientele. They just push
> > > 
> > >  The filename may not be useful to the user, but the instant the user decides to
> > >  submit a bugreport to LKML or elsewhere it becomes useful.
> > 
> > But OTOH, there's a difference between messages-to-developers (usually "the
> > code went wrong") and messages-to-users (hopefully usually "the hardware
> > went wrong" or "you went wrong").
> 
> Symbol names are generally unique. As a USB stack developer, I never saw
> the file name being useful for anything in the error message, let alone
> the full path! Always hated them, but never bothered to break spears
> over the issue. We have better things to do. I just quietly remove
> debugging printouts from the code I touch.

There's a bit of history here.  The dbg(), err(), info() macros came
from the USB core, back in 2.2 days.  Then the whole path of the file
was not part of __FILE__, but only the single .c file.

With 2.5, __FILE__ changed as part of the build process changes, and we
added dev_dbg(), dev_info(), and dev_err(), which are a _much_ better
way to output information from a driver.  It provides the exact driver
and device that is being talked about, and not just a file.

So, ideally I'd like to get rid of the USB macros completly, and use the
dev_* forms instead.  But there are a few places in the USB code that do
not have a valid device and so they can't be dropped entirely.

Either way, I don't think we need to be making them "prettier" at this
point in time, but fixing the real problem of using them in the first
place...

I'll drop this patch for now, and only take the part that adds the new
dev_* macro.  Is that ok for everyone?

And if anyone wants to notify the kernel-janitors that this would be a
good thing to do for the USB subsytem, feel free, I'll gladly accept
those patches.

thanks,

greg k-h

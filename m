Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVHEUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVHEUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVHEUd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:33:57 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:53468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262814AbVHEUdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:33:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DhNK0WhwKNvx9lhol6562ocMmLgcEFJc5sOgLrO4sDyd6/l8Mq07we71dFh/0pKSkpGFnSLD5Znje25UDXtwPsUm3MkvSTL8GJSLXb8PIOMbJWUbdxeuVsPwFGgPSgIBYYc2ILMnUaZqIwrvYgIf5hfRHBbD/KpX+f1ZZHmi2jI=
Message-ID: <9e47339105080513335e2674fa@mail.gmail.com>
Date: Fri, 5 Aug 2005 16:33:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200508052207.49270.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <200508052020.13568.oliver@neukum.org>
	 <9e47339105080511474d89ee8a@mail.gmail.com>
	 <200508052207.49270.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 5. August 2005 20:47 schrieb Jon Smirl:
> > On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > > Am Freitag, 5. August 2005 20:14 schrieb Jon Smirl:
> > > > On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > > > > Am Freitag, 5. August 2005 15:32 schrieb Jon Smirl:
> > > > > > On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > > > Hi!
> > > > > > >
> > > > > > > > > > New, simplified version of the sysfs whitespace strip patch...
> > > > > > > > >
> > > > > > > > > Could you tell me why you don't just fail the operation if malformed
> > > > > > > > > input is supplied?
> > > > > > > >
> > > > > > > > Leading/trailing white space should be allowed. For example echo
> > > > > > > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > > > > > > than to teach everyone to use -n.
> > > > > > >
> > > > > > > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > > > > > > We are not going to add such workarounds all over the kernel...
> > > > > >
> > > > > > It is not a work around. These are text attributes meant for human
> > > > > > use.  Humans have a hard time cleaning up things they can't see. And
> > > > > > the failure mode for this is awful, your attribute won't set but
> > > > > > everything on the screen looks fine.
> > > > >
> > > > > The average user has no place poking sysfs. Root should know when
> > > > > to use -n, as should shell scripts.
> > > >
> > > > So the average user never needs to change their console mode? Check
> > > > out /sys/class/graphics/fb/modes and mode.
> > >
> > > That is what we have helper scripts for.
> >
> > If we are going back to needing helper scripts then I should just
> > remove the entire sysfs graphics interface and switch back to using
> > ioctls and a helper app. Of could no one can ever find the helper app
> > or remember how it works. I thought one of the main reasons behind the
> > sysfs interface was to eliminate these helper apps.
> 
> The point is that you _can_ do it with echo, not that it is _easy_.
> Nor is sysfs a solution in any case.
> 
> > Without doing whitespace cleanup there is a 100% probability that this
> > will generate bug reports. I know this for a fact because I am already
> > getting them.
> 
> Stupid users are not a reason for kernel bloat.

You have a very wrapped sense of kernel bloat. This is nine lines of
code whose absence is guaranteed to generate a bunch of bug reports.
Not having it is also causing various implementers to implement
attribute processing differently. Some are stripping white space in
their implementations and some are not. If you want to attack kernel
bloat there are much more productive areas.

If whitespace cleanup is rejected I believe we should eliminate text
based sysfs attributes in general and make them all binary. I'll
probably remove the fbdev sysfs interface because I don't want to deal
with the bug reports reporting the same problem over and over.

-- 
Jon Smirl
jonsmirl@gmail.com

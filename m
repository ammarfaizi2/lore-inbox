Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUILHMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUILHMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268504AbUILHMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:12:15 -0400
Received: from smtp.easystreet.com ([69.30.22.10]:36292 "EHLO
	smtp.easystreet.com") by vger.kernel.org with ESMTP id S268502AbUILHML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:12:11 -0400
Subject: Re: radeon-pre-2
From: Eric Anholt <eta@lclark.edu>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091114374b9545f5@mail.gmail.com>
References: <9e47339104091010221f03ec06@mail.gmail.com>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911105448c3f089@mail.gmail.com>
	 <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
	 <9e4733910409111402138737aa@mail.gmail.com>
	 <20040911220614.A5023@infradead.org>
	 <9e47339104091114374b9545f5@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1094973129.884.98.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 00:12:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 14:37, Jon Smirl wrote: 
> On Sat, 11 Sep 2004 22:06:14 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> > On Sat, Sep 11, 2004 at 05:02:36PM -0400, Jon Smirl wrote:
> > > Alan, if you will commit Redhat to implementing all of the features
> > > referenced in this message:
> > 
> > You definitly start sounding like Hans ;-)
> 
> Getting the Linux display subsystem to a point where it can compete
> with Longhorn/Mac is a very complicated problem. It is going to take
> several years of work and the cooperation of a lot of people. It's a
> pyramid problem with lot's of layers.
> 
> Of course Linux can choose not to build a display system based on 3D
> hardware. But I've seen the
> current Longhorn/Mac implementations and they are way, way better than
> X. If Linux ignores 3D mode it is going to be very visible on the
> desktop.
> 
> I've tried to follow the Linux model for proposing the changes. The
> plan has been circulated to all relevant lists: fbdev, dri, xorg, lkml
> for over six months. Three sessions at OLS talked about various parts
> of the plan. Nothing has been kept secret, there must be 5,000
> messages in the archive on this subject.
> 
> But since I've written most of the code so far I get to pick the
> details of the implementation. If Alan would instead like to pick the
> details I've offered to withdraw if he'll write the code needed to
> implement the major points of the plan. Of course if Redhat wants to
> send me a check for a couple of hundred thousand dollars I'll write
> whatever they want, but they haven't done that.

I don't see what longhorn and quartz have to do with the question at
hand (this plan to cram FB and DRM together).

If we want to do the pretty graphics things that these improvements to
graphics on other OSes have done, we don't need to touch FB at all.  We
already have X Servers with the composite extension.  We've got a vector
graphics library.  Now we need to make those go fast.  We can do the
go-faster part within the X Server and the vector graphics library
without touching the DRM, FB, or anyone else.  I'm spending far too much
of my free time currently working on this.

Now, another good project is to get our 3d drivers to the point that we
could write our X Server on top of that.  Basically, we need pbuffer
support for that.  That'll touch the DRM and client drivers (and our
current X Servers, though that part wouldn't be used in the X-on-GL
model).  Again, not FB.

A completely separate issue is how to arrange for synchronization
between the multiple users of the graphics hardware on linux.  I think a
pretty decent model has been proposed by the Linux kernel people, and it
seems rather simple.  FreeBSD is happy with it because it doesn't affect
us in any way.  (When we get around to dealing with the issue (if ever),
i.e. when we've got accelerated graphics layers for console, I'm quite
sure we'll follow the same model of a relatively generic lock in the
kernel which all graphics clients will use to arbitrate hardware
access).

Please, stop trotting out Longhorn and Quartz to justify whatever you're
trying to push into the kernel.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVC2XVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVC2XVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVC2XVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:21:41 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10932 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261628AbVC2XVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:21:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dtor_core@ameritech.net
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Tue, 29 Mar 2005 23:49:26 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20050323184919.GA23486@hexapodia.org> <20050325142414.GF23602@elf.ucw.cz> <d120d50005032506526f6b9304@mail.gmail.com>
In-Reply-To: <d120d50005032506526f6b9304@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503292349.26940.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 25 of March 2005 15:52, Dmitry Torokhov wrote:
> On Fri, 25 Mar 2005 15:24:15 +0100, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> > 
> > > > > > OK, anything else I should try?
> > > > >
> > > > > not really, i just wait for Vojtech and Pavel :-)
> > > >
> > > > Try commenting out "call_usermodehelper". If that helps, Stefan's
> > > > theory is confirmed, and this waits for Vojtech to fix it.
> > > >
> > >
> > > This is more of a general swsusp problem I believe - the second phase
> > > when it blindly resumes entire system. Resume of a device can fail
> > > (any reason whatsoever) and it will attempt to clean up after itself,
> > > but userspace is dead and hotplug never completes. While I am
> > > interested to know why ALPS does not want to resume on ANdy's laptop
> > > the issue will never be completely resolved from within the input
> > > system.
> > 
> > When device fails to resume, what should I do? I think I could
> > 
> >        if (error)
> >                panic("Device resume failed\n");
> > 
> > , but... that does not look like what you want.
> 
> Oh, always panic-happy Pavel ;). It really depends on what kind of
> device has faled to resume. If the device is really needed for writing
> image then panic is the only recourse, but if it some other device you
> resuming just ignore it, who cares...

Moreover, if we panic() here, we potentially lose data.  IMO we should not
do this for a device that is not needed for saving the image and/or
contains the root filesystem.

> Btw, I dont think that doing selective resume (as opposed to selective
> suspend and Nigel's partial device trees) would be so much
> complicated. You'd always resume sysdevs and then, when iterating over
> "normal" devices, just skip ones not in resume path. It can all be
> contained in driver core I believe (sorry but no patch, for now at
> least).

In fact, the only devices that we really need to resume-during-suspend are
those necessary for saving the image.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


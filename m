Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWCNLq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWCNLq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWCNLq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:46:56 -0500
Received: from cindy.kollegienet.dk ([130.226.80.138]:32488 "EHLO
	mail.odense.kollegienet.dk") by vger.kernel.org with ESMTP
	id S1751815AbWCNLq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:46:56 -0500
From: Elias Naur <elias@oddlabs.com>
Organization: Oddlabs ApS
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Expose input device usages to userspace
Date: Tue, 14 Mar 2006 12:46:52 +0100
User-Agent: KMail/1.8.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
References: <200603132154.38876.elias@oddlabs.com> <200603141146.04270.elias@oddlabs.com> <1142333947.3027.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1142333947.3027.31.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141246.53167.elias@oddlabs.com>
X-FKO-MailScanner: No virus found
X-FKO-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.524,
	required 5, autolearn=not spam, BAYES_01 -1.52)
X-MailScanner-From: elias@oddlabs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 11:59, Arjan van de Ven wrote:
> On Tue, 2006-03-14 at 11:46 +0100, Elias Naur wrote:
> > On Tuesday 14 March 2006 09:22, Arjan van de Ven wrote:
> > > > > No, I don't think this is needed at all - users should be
> > > > > interested in what capabilities a particular device has, not what
> > > > > type it was assigned by soneone.
> > > >
> > > > I see your point that an application should not rely too much on
> > > > device usages. However, the main reason I want device usages is to
> > > > help applications and users identify and (visually) represent
> > > > devices. For example, games could show an appropriate icon graphic
> > > > representing each active device. The event interface already has a
> > > > few other ioctls for this kind of information:
> > >
> > > ok then you should consider to do it the other way around: make a way
> > > of asking
> > > "are you matching THIS profile".
> > > rather than
> > > "what profile are you"
> > >
> > > that way devices can present multiple faces etc; which is going to be
> > > needed as more and more weird devices come into existence.
> >
> > If by profile you mean a device usage like Mouse, Keyboard, Joystick etc.
> > is your proposal covered by the bit field ioctl exposed by my patch? For
> > example, a device can already expose itself as both a joystick and a
> > mouse (see the hid-input.c changes from the patch).
>
> no that's not what I meant; I really mean asking "can you do THIS
> profile". Example would be a device that could be either a joystick and
> a mouse, or a touchpad and a mouse, but not both a touchpad and a
> joystick. So the app should ask "can you do THESE", and the driver can
> then do anything complex it wants to come to an answer. (Of course a
> generic helper for the simple case is fine)

I think I'm beginning to understand what you mean, but it still seems way too 
complicated for my taste. Devices with multiple profiles seems like a static 
property more than a dynamic one, so simply splitting up these weirdo devices 
into multiple logical devices at registration time seems like a better idea. 
Each logical device would then have a separate set of axes, keys and, with my 
patch, usages.

 - elias

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWFKCFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWFKCFz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWFKCFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:05:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:21274 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751198AbWFKCFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:05:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8Pf71JhrmMvC6VHmlXe0VrgGscYAOw7gcdocJQA+7lcpQL0jdseWLx6C4+3yGmIIpdc0fML0kcVAabeaVjKzNDeUT9pg4u/oPs/QfouqbDWK5sxS4ra11OPUgUmvxL53r9vqLX4doB/X/m946IqigjQYMrromff9ahj+3aO6sg=
Message-ID: <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>
Date: Sat, 10 Jun 2006 22:05:54 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <448B6ED3.5060408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	 <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	 <448B38F8.2000402@gmail.com>
	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	 <448B61F9.4060507@gmail.com>
	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
	 <448B6ED3.5060408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> > I see now that you can have tty0-7 assigned to a different console
> >> > driver than tty8-63.
> >> > Why do I want to do this?
> >>
> >> Multi-head.  I can have vgacon on the primary card for tty0-7,
> >> fbcon on the secondary card for tty8-16.
> >
> > That's what I thought, I couldn't see any other reason. The kernel
> > doesn't support input from multiple users so multihead can only be
> > used by a single user.
> >
> > Does anyone use single user multihead on current systems? The kernel
> > doesn't have code in it to initialize secondary VGA cards. What modern
> > non-VGA hardware does this work on?
>
> matroxfb supports multihead and fbcon already has this feature for a
> long time, ie you can bind /dev/fb0 to tty0-3 and /dev/fb1 to tty4-6.
> And there are definite users because I happen to break this feature once
> and I got rained with complaints :-)

Were those people using this: http://linuxconsole.sourceforge.net/
Does that work anymore?

This is single a single driver bound to the vt layer. Support for both
fb0 and fb1 are provided by that single driver. So there may be some
way to make this work.

> > If this feature doesn't work on current hardware, could it be dropped?
> > It would make binding to the vt system much simpler if only one driver
> > could be bound at a time. Anything we do to make that system simpler
> > would benefit everyone.
>
> You can't drop something that's already in the kernel and has users, well,
> the binding part at least. What we don't currently have is the fine-grained
> control and because of the reason's you mentioned, I said that it's for the
> future.

There are variations on 'drop' is it dropping if we provide an
alternate way to achieve the same thing?

Does matroxfb know which VC number it is drawing too? If so, we could
move the mapping between head and VC down to an attribute on the
matroxfb driver. That would allow the general case of the VC layer
binding to be simplified to opening a single driver.

That is not an attribute you want long term on the matroxfb driver,
but all of this would get more cleanly sorted out when a user space
implementation happens.

> (Note1: fbcon already has support to selectively bind/unbind drivers
> to specific tty's, using the con2fbmap utility.)

Could a variation on this be used to bind the matrox heads to a
specific tty? Is that binding happening inside fbcon or the vt layer?

>
> So what we have is control for wholescale binding and unbinding of
> drivers, which essentially results in only 1 driver loaded at one time.
>
> (Note2: fbcon already has an option to determine what range of vc's to
> control, as a kernel boot parameter, so we can't just drop something
> that's already supported by one driver at least.  Though I know of no one,
> including myself, who uses this feature.)
>
> >
> > At some future point I would like to explore pushing the VT system out
> > to user space where it becomes much easier to make it multi-user and
> > multi-head. If you do that, something like a single user, in-kernel
> > system management console makes more sense.
>
> Yes.
>
> Tony
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com

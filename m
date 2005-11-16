Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVKPVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVKPVKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKPVKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:10:07 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:51132 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932608AbVKPVKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:10:05 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Greg KH <greg@kroah.com>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20051116165023.GB5630@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz>
	 <1132115730.2499.37.camel@localhost> <20051116061459.GA31181@kroah.com>
	 <1132120845.25230.13.camel@localhost>  <20051116165023.GB5630@kroah.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132171051.25230.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Nov 2005 06:57:31 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg.

On Thu, 2005-11-17 at 03:50, Greg KH wrote:
> On Wed, Nov 16, 2005 at 05:00:45PM +1100, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2005-11-16 at 17:14, Greg KH wrote:
> > > On Wed, Nov 16, 2005 at 06:35:30AM +0200, Dumitru Ciobarcianu wrote:
> > > > ??n data de Mi, 16-11-2005 la 00:32 +0100, Pavel Machek a scris:
> > > > > ...but how do you provide nice, graphical progress bar for swsusp
> > > > > without this? People want that, and "esc to abort", compression,
> > > > > encryption. Too much to be done in kernel space, IMNSHO.
> > > > 
> > > > Pavel, you really should _listen_ when someone else is talking about the
> > > > same things in different implementations. suspend2 has this feature
> > > > (nice graphical progress bars in userspace) for a long time now and it's
> > > > compatible with the fedora kernels.
> > > 
> > > It's also implemented in the kernel, which is exactly the wrong place
> > > for this.  Pavel is doing this properly, why do you doubt him?
> > 
> > You yourself called it a hack not long ago.
> 
> I did, in the proud tradition of neat hacks.  It's a very nice
> accomplishment that this even works, and I'm impressed.
> 
> > I'm not sure why you think the userspace is the right place for
> > suspending.
> 
> If he can come up with an implementation that works, and puts stuff like
> the pretty spinning wheels and progress bars and encryption in
> userspace, that's great.  That stuff doesn't belong in the kerenel if we
> can possibly help it.

I can agree with putting splash screens and userspace stuff in
userspace. Suspend2 has had that too, since March. But the guts of the
code is a different thing. Encryption - well, I think we're both using
cryptoapi now, so that's more easily done in the kernel.

> > It seems to me that the very fact that it requires access to
> > structures that are normally only visible to the kernel is pretty
> > telling.
> 
> So it needs some work :)

rm :)

> > To be fair, it is true at the same time that graphical interfaces
> > don't belong in the kernel - but the vast majority of it - calculating
> > what to write and doing the writing does. It's only by hamstringing
> > himself and the user - limiting the image to half of memory that Pavel
> > (and dropping support for writing to swap) that Pavel can make this
> > work.
> 
> Then propose a better way to do this, if you can see one.

We've done the user interface in userspace using netlink to
communication.

We've done storing a full image of memory by storing the page cache
separately to the rest of the image, so that it doesn't need to have an
atomic copy made. (Nothing that uses the page cache is running anyway).
Having done this, we can use the memory occupied by the page cache for
our atomic copy, and just reread the overwritten page cache pages if we
need to cancel the suspend. Suspend2 has done this since... beta18 I
think.

> > > > Why don't you and Nigel (of suspend2) can just work together on this ?
> > > > It's a shame that much work is wasted in duplicated effort.
> > > 
> > > It's not duplicated, Nigel knows what need to be done to work together,
> > > if he so desires.
> > 
> > I know that Pavel and I have such different ideas about what should be
> > done that it's not worth the effort.
> 
> I'm sorry that you feel this way.  I thought that after our meeting in
> July that things were different.

I'm sorry you came away with that impression. I want to work together,
but I'm not willing to settle for a minimalist implementation. Pavel, on
the other hand, wanted a minimalist implementation at first. He seems to
be changing his mind a bit now, but I'm not sure how far that will go.

Regards,

Nigel

> thanks,
> 
> greg k-h
-- 



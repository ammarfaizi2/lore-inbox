Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbVKPVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVKPVfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVKPVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:35:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43906 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030496AbVKPVfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:35:33 -0500
Date: Wed, 16 Nov 2005 22:35:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Greg KH <greg@kroah.com>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116213517.GD12505@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz> <1132115730.2499.37.camel@localhost> <20051116061459.GA31181@kroah.com> <1132120845.25230.13.camel@localhost> <20051116165023.GB5630@kroah.com> <1132171051.25230.53.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132171051.25230.53.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

> > > > It's also implemented in the kernel, which is exactly the wrong place
> > > > for this.  Pavel is doing this properly, why do you doubt him?
> > > 
> > > You yourself called it a hack not long ago.
> > 
> > I did, in the proud tradition of neat hacks.  It's a very nice
> > accomplishment that this even works, and I'm impressed.
> > 
> > > I'm not sure why you think the userspace is the right place for
> > > suspending.
> > 
> > If he can come up with an implementation that works, and puts stuff like
> > the pretty spinning wheels and progress bars and encryption in
> > userspace, that's great.  That stuff doesn't belong in the kerenel if we
> > can possibly help it.
> 
> I can agree with putting splash screens and userspace stuff in
> userspace. Suspend2 has had that too, since March. But the guts of
> the

Well, I'd say that having to resort to netlink is ... not quite
nice. You get all the complexity of having userspace running during
suspend, and get very little benefit.

> code is a different thing. Encryption - well, I think we're both using
> cryptoapi now, so that's more easily done in the kernel.

Its not only encryption. It is encryption, compression, support for
suspend over network, support for suspend into file. That's quite a
lot of stuff.

> > Then propose a better way to do this, if you can see one.
> 
> We've done the user interface in userspace using netlink to
> communication.
> 
> We've done storing a full image of memory by storing the page cache
> separately to the rest of the image, so that it doesn't need to have an
> atomic copy made. (Nothing that uses the page cache is running anyway).
> Having done this, we can use the memory occupied by the page cache for
> our atomic copy, and just reread the overwritten page cache pages if we
> need to cancel the suspend. Suspend2 has done this since... beta18 I
> think.

...at expense of complexity, and hooks all over the kernel. Yes, if
you modify kernel a bit, nothing will use the page cache.

Anyway, I believe we have solution for that one. See Rafael's recent
patches -- "only free as much memory as neccessary" should do the
trick, without excessive complexity.

> > > I know that Pavel and I have such different ideas about what should be
> > > done that it's not worth the effort.
> > 
> > I'm sorry that you feel this way.  I thought that after our meeting in
> > July that things were different.
> 
> I'm sorry you came away with that impression. I want to work together,
> but I'm not willing to settle for a minimalist implementation. Pavel, on
> the other hand, wanted a minimalist implementation at first. He seems to
> be changing his mind a bit now, but I'm not sure how far that will go.

Well, I do not want the complexity of two page sets. I think Rafael's
patches will provide almost equivalent functionality. Other than that,
all your features should be doable. I'm not saying I'm going to write
those patches myself, but I'll certainly not reject them just because
they are too big.
								Pavel
-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWDRPOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWDRPOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWDRPOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:14:16 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:38093 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932269AbWDRPOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:14:15 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Jon Masters" <jonathan@jonmasters.org>
Subject: Re: [RFC] binary firmware and modules
Date: Tue, 18 Apr 2006 17:14:11 +0200
User-Agent: KMail/1.9.1
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <1145088656.23134.54.camel@localhost.localdomain> <200604181537.47183.duncan.sands@math.u-psud.fr> <35fb2e590604180714u9bdad58j6c15760404eff330@mail.gmail.com>
In-Reply-To: <35fb2e590604180714u9bdad58j6c15760404eff330@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181714.12293.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > Hi Jon, this approach seems mistaken to me.  If I understand it right,
> > your mental model is that the driver has a list of file names for firmware
> > files, and calls user-space with the right file-name for the device in
> > question.
> 
> Yes, as is the way it is done right now. There's room for userspace to
> massage the request a little but right now it /really shouldn't/
> because that's not co-ordinated with the driver.
> 
> > Given that model, having drivers tell the world about their
> > firmware file list is reasonable; but I think the model is a bad one.
> 
> Yes, perhaps it is, but that's how it is now. The point of my mail was
> that right now we have zero way to package up a kernel when the
> firmware is out-of-tree and this is rapidly becoming reality so we
> need a solution right away.

This is a problem for speedtouch users too - I get regular reports from users
that their modem failed to find the firmware, usually because it wasn't in the
initrd.

> > Much better would be to have drivers work at a higher level of abstraction
> 
> Yes, but remember that you then have to embed lots of driver logic in
> userspace. Since it's unlikely that driver writers are going to be
> able to invest lots of time in keeping what they're doing in sync with
> special handling in udev, I think that approach is also a mistake. Do
> you really expect to push updated logic into udev every time you
> update your driver for a quick hardware change? really?

I don't understand what you're saying here - what kind of situation are
you thinking of when you talk about "update your driver for a quick hardware
change"?

> > I gave the example of the speedtouch driver to show how complicated
> > things can be.  I didn't mean to suggest that the scheme it uses is
> > a good one - it is a bad one, in that the real solution is to make
> > userspace smarter.
> 
> I think it's a mistake to take that logic out of the driver proper. To
> say "we'll just have userspace figure it out" is asking for weird
> undebugable situations. I'm not in favor of bloat, but this is hardly
> bloating the kernel - most drivers are going to request firmware by
> filename right now, so let's just have a way to export that filename
> for the moment at least.

You're creating a new kernel API here, so it needs to be good from the
word go: "for the moment at least" could easily become "needs to be
supported forever".  It's a pity if the scheme can't handle even mildly
complicated situations.

> 
> > In any case, I don't see how your suggested patch
> > could reasonably work with the speedtouch driver
> 
> I own a speedtouch here myself. I had to extract the firmware by hand
> and install it. Unless something has changed, this means that we're
> not going to get into a situation where that firmware is being shipped
> out due to the licensing on it. 

There's no reason to think that Thomson is dead set against having
distributions distribute firmware.  I bet the problem is simply that
no distribution has yet tried to sort the licensing problem out.
Maybe one day distributions will ship with speedtouch firmware.  If
so, it would be sad to then discover that the kernel+tools are too
unsophisticated to handle the situation.

> I get your point (sort of) but I think 
> you're overcomplicating this for the sake of drivers like speedtouch
> where none of this logic works anyway.
> 
> I'm not saying this is a perfect approach. It's /an/ approach, it's
> simple and it works right now for many possible drivers. Packagers can
> trivially rip out info from modinfo and use it as a list of files to
> look for in a package (for example). It's also hardly difficult to
> switch to a grand magical solution sometime in the future.

Putting in infrastructure that is adequate for most drivers but not all,
will simply make it much harder to move one day to an infrastructure that
can handle the requirements of all drivers, because most people won't be
motivated.

As I remarked in another email, MODULE_FIRMWARE could be made to work
with the speedtouch driver as long as it is possible to specify patterns,
or at least initial parts of filenames.

Ciao,

Duncan.

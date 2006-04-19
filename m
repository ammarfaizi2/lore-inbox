Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWDSPpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWDSPpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDSPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:45:12 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:21466 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750916AbWDSPpK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:45:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GhuuKUrF+Us1jIlIUSjRVhOIjhCysAD3vmN0a8p0OtEK3L1goXu9S+2TsF0w5999kGwm0ND8VZdjU7r8xCJOD1eVpUUhKUY47r6L/Y+zp1GsoFJ+tt9o+azeZu+Ft5KslF1UK6eVyj0qkddJBk5K7C5DbRI1RIfF1eYRaMOe11g=
Message-ID: <35fb2e590604190845o309f8075t1d419d625906646b@mail.gmail.com>
Date: Wed, 19 Apr 2006 16:45:10 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Duncan Sands" <duncan.sands@math.u-psud.fr>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200604191732.08640.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
	 <200604191107.10562.duncan.sands@math.u-psud.fr>
	 <35fb2e590604190541v714d3604w544a83876e5db14a@mail.gmail.com>
	 <200604191732.08640.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> > > I haven't really understood what problem this solves.  Is this just a
> > > standardised form of documentation, or are you imagining that an automatic
> > > tool will use this to auto include a minimal set of firmware files in an
> > > initrd?
> >
> > I'm imagining that the resultant modinfo output can be used by a tool
> > for anyone to package up the correct firmware to go with a given
> > driver.

> If a tool is to do the packaging, then this means that the firmware must
> already be present on the machine, for example in /lib/firmware.

Yes. Although, potentially more clever things could happen in
userspace in the future.

> that means the role of any tool is to select a subset of the files
> in /lib/firmware, for example a minimal set for inclusion in an initrd.

For example.

> Is there really any reason not to simply throw everything in
> /lib/firmware into any initrd that is created?

You /could/ just build every driver into the initrd too, and every
firmware, and... but it might be nice if it was possible to know what
should be where. Right now, we've lost that because decoupling
firmware from the kernel means that tools outside of the kernel can't
tell what firmware files should be around.

> > Right now, there's no way to do that - i.e. we've gone
> > backwards from a standpoint of coupling a kernel with firmware. I
> > completely understand why firmware doesn't really belong in the
> > kernel, so let's add this :-)
>
> I guess a big difference between the speedtouch and the kinds of drivers
> you seem to be thinking of, is that in your case there is a fairly tight
> coupling between firmware and driver versions: a given driver version will
> only work with a certain version of the firmware and vice-versa.  In the case
> of the speedtouch, we have no control over (and not much knowledge about)
> which firmware gets given to people along with their modems, so there is really
> no coupling at all between firmware versions and driver versions.

I've also repeatedly said that I don't think this really helps with
things like speedtouch since you can't distribute that firmware
anyway. This patch does help people who play nicely with the kernel
who are migrating away from shoving blobs into the kernel (quite
rightly) and who supply redistributable firmware. One example might be
the QLogic driver in my RFC.

> > That kind of thing. It's not just Red Hat who benefit - anyone who
> > wants to package up a kernel and do something with it will want to
> > know about firmware they might need.
>
> For this they could just read the documentation.  They'll need to anyway
> just to find out where they are supposed to get the firmware from.

You're assuming firmware is always on some random vendor website under
a questionable license and can't be redistributed. That wasn't my
first consideration - this doesn't really help much there, except you
get to know what you don't have :-)

Jon.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWDSABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDSABq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWDSABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:01:46 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:3296 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750877AbWDSABp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:01:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lB6rnvDH7EF8MiKjWs+9g1wYKvXV1i+XRkU8usU8ki/JK3bVX6YAQZz4nluHCGIICFJwwmBi5LttibNUmbVyyZWomsv7a4p1xCyDmDmCs5VwKr9xizQ04G39QaWgVse015ia3KwIpQbstuEhpM1S6ZTiz9aTiu/oMCwGzy6BGss=
Message-ID: <35fb2e590604181701x3ec461dap9887e3a7ce83e29a@mail.gmail.com>
Date: Wed, 19 Apr 2006 01:01:43 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Duncan Sands" <duncan.sands@math.u-psud.fr>
Subject: Re: [RFC] binary firmware and modules
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200604181714.12293.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604181537.47183.duncan.sands@math.u-psud.fr>
	 <35fb2e590604180714u9bdad58j6c15760404eff330@mail.gmail.com>
	 <200604181714.12293.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/06, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> > > Given that model, having drivers tell the world about their
> > > firmware file list is reasonable; but I think the model is a bad one.

jcm>> Yes, perhaps it is, but that's how it is now. The point of my mail was
jcm>> that right now we have zero way to package up a kernel when the
jcm>> firmware is out-of-tree and this is rapidly becoming reality so we
jcm>> need a solution right away.

> This is a problem for speedtouch users too - I get regular reports from users
> that their modem failed to find the firmware, usually because it wasn't in the
> initrd.

Yes. As we've already said, it's unlikely that's going to change any
time soon for those shipping kernels - licensing on the speedtouch
firmware isn't conducive AFAIK.

> > > Much better would be to have drivers work at a higher level of abstraction

jcm>> Do you really expect to push updated logic into udev every time you
jcm>> update your driver for a quick hardware change? really?

> I don't understand what you're saying here - what kind of situation are
> you thinking of when you talk about "update your driver for a quick hardware
> change"?

Piece of hardware you always thought worked one way, but doesn't.
Quick hacks for new devices/fixes for old ones, etc. etc. There are
lots of reasons you might want to change firmware logic and the idea
of doing it in two places seems a bad one to me.

jcm>> so let's just have a way to export that filename
jcm>> for the moment at least.

> You're creating a new kernel API here, so it needs to be good from the
> word go: "for the moment at least" could easily become "needs to be
> supported forever".  It's a pity if the scheme can't handle even mildly
> complicated situations.

I'm creating a new internal API, yes. One that I think solves the
problem for most drivers and can stick around for a while - when I say
"for the moment at least" I mean that in the same sense that any part
of the kernel stays around until someone comes along with something
new that everyone jumps at. But I think it's a useful one line patch
:-)

> > > In any case, I don't see how your suggested patch
> > > could reasonably work with the speedtouch driver

jcm>> I own a speedtouch here myself. I had to extract the firmware by hand
jcm>> and install it. Unless something has changed, this means that we're
jcm>> not going to get into a situation where that firmware is being shipped
jcm>> out due to the licensing on it.

> There's no reason to think that Thomson is dead set against having
> distributions distribute firmware.

But there's no reason to think any different either - and I don't
think it's likely vendors are going to go out of their way for every
driver to have lengthy legal debates over licensing. If these folks
want their firmware to be distributed, then they need to facilitate
that. To be fair to QLogic, their firmware has a specific license on
it and they seem to be a player.

> Maybe one day distributions will ship with speedtouch firmware.  If
> so, it would be sad to then discover that the kernel+tools are too
> unsophisticated to handle the situation.

What's the problem? Really? It's just a file list of firmwares - if
you really can't have a list then you just have to special case the
speedtouch driver. Meanwhile, other folks are able to happily use
MODULE_FIRMWARE to advertise their firmware requirements :-)

> As I remarked in another email, MODULE_FIRMWARE could be made to work
> with the speedtouch driver as long as it is possible to specify patterns,
> or at least initial parts of filenames.

You can specify whatever filename you like - it's down to whatever
parses the modinfo sections to rip this out in the right way at
packaging time. I strongly prefer file names.

Jon.

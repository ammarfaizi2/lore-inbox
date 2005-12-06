Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbVLFPZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbVLFPZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbVLFPZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:25:31 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:4511 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751707AbVLFPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:25:30 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Tim Bird <tim.bird@am.sony.com>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051206145025.GY28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
	 <1133817888.9356.78.camel@laptopd505.fenrus.org>
	 <1133819684.11280.38.camel@localhost.localdomain>
	 <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random>
	 <4394E750.8020205@am.sony.com> <1133861208.10158.34.camel@tara.firmix.at>
	 <1133863003.4136.42.camel@baythorne.infradead.org>
	 <20051206145025.GY28539@opteron.random>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 15:25:15 +0000
Message-Id: <1133882715.4136.156.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 15:50 +0100, Andrea Arcangeli wrote:
> On Tue, Dec 06, 2005 at 09:56:43AM +0000, David Woodhouse wrote:
> > [..] we might as well be using it for all symbols [..]
> 
> Cool, so if we use it for all symbols it will add zero information to
> the kernel. Which means it's exactly the same as if we nuke _GPL tag
> completely and we remove it from all symbols.
> 
> I always thought the _GPL tag isn't needed and can be removed, your
> suggestion to add it to all symbols confirms it. 

In terms of information, you're right -- there's no point in having both
of them.

However, the _GPL tag does mean that someone who wants to violate the
licence has to deliberately circumvent the protection, and cannot plead
ignorance. That does have an effect in court, albeit after the basic
question of guilt or innocence has been decided.

> Furthermore its existence is a sort of proof that you can legally link
> the kernel with non-GPL modules (which Greg disagrees with, I don't
> have an opinion, I only know Linus said binary only drivers are ok as
> long as they don't create a derivative of the kernel).

I happen to agree with Greg's opinion, and not with Linus'. But
obviously there is no 'right' answer until/unless it comes to court.

But yes -- its existence is indeed a 'sort of proof' that non-GPL
modules are at least _considered_ to be OK in some situations. I wish
we'd never invented EXPORT_SYMBOL_GPL() in the first place -- it appears
to legitimise something which was never really OK in the first place,
and weakens our position when we take it to court.

> I don't think the GPL tag can make somebody more or less illegal, it's
> just irrelevant. This is just a favour we make to those companies, and
> that they may also not trust in the first place because we're not
> lawyers in the first place.

True -- that's what I've said many times. The point, however, is that
the GPL tag provides a measure of protection which the violator would
have to _deliberately_ circumvent. That doesn't directly affect the
licensing question, but it does change the _penalties_ which a court
would impose if a vendor of non-GPL'd modules who is found to be
violating the GPL.

Maybe a vendor will have deep pockets and a penchant for risk, and will
still be happy to bypass the protection afforded by EXPORT_SYMBOL_GPL --
maybe with MODULE_LICENSE("GPL\0not really") or by other means. But the
_default_ would be that non-GPL modules  would not work, and having to
circumvent the protection would make them stop and think _very_ hard
before doing it.

> > By switching in the opposite direction, Linus is actively weakening our
> > position, and I object very strongly to that.
> 
> I think Linus is doing the right thing here, and he is avoiding what I
> described in the previous email:

He's also doing what you described in the email to which I'm reply --
reinforcing a 'sort of proof' that what they're doing is OK, by going
out of his way to accommodate them.

>  that is breaking drivers gratuitously is what could make linux
> hostile and too costly to support IMHO. 

Supporting Linux with binary-only drivers _is_ hostile and costly.

And it wouldn't be _broken_ -- they could still rebuild the kernel
without the checks, or make their module pretend to be licensed under
the GPL to bypass the EXPORT_SYMBOL_GPL() protection. Of course, they'd
have to be _very_ sure of their lawyers' interpretation of the GPL if
they were going to do that.

By switching to EXPORT_SYMBOL_GPL for everything, we put the onus upon
the vendors of such modules to be _very_ sure of themselves and the risk
they're taking before continuing to release such modules. I don't think
that's a bad thing.

> We want to be parnters with all hardware companies, but we want them
> to support linux properly (not with binary only drivers), in a way
> that we can fix it, port it to other archs, and so that we don't lose
> support for the hardware while improving internal APIs.

Allowing binary-only drivers only harms that goal, in the long term.

> Also note, that if we lose control on the development (the doomsday
> scenario) everybody else loses control too, it's not like somebody can
> bank on it and steal the control and profit from it and pay lots of
> taxes to the US governament. Everybody will lose and wealth will be
> destroyed globally and less taxes will be paid in all countries
> worldwide. All those hardware companies compete against each other, so
> each one will have control on a little tiny piece of the OS, so when a
> bug triggers in the doomsday secnario, the thing will become
> undebuggable for everyone (at best everyone can blame on each other when
> there's random memory corruption). That again may be acceptable for a
> desktop, but I doubt it's acceptable for servers.

I think we're digressing somewhat, but you seem to be agreeing that
binary-only modules are generally a bad thing. We have a tool available
to us to discourage their proliferation -- the licence under which the
kernel is released. That's the whole _point_ of the GPL, in fact.

So what's wrong with the suggestion that we make _use_ of that rather
than continuing to not only tolerate violations, but go out of our way
to aid and abet the violators?

-- 
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264800AbSKELeM>; Tue, 5 Nov 2002 06:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSKELeM>; Tue, 5 Nov 2002 06:34:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41409 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264800AbSKELeK>;
	Tue, 5 Nov 2002 06:34:10 -0500
Date: Tue, 5 Nov 2002 17:12:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021105171230.A11443@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com> <3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031193705.C2599@almesberger.net>; from wa@almesberger.net on Thu, Oct 31, 2002 at 07:37:05PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:37:05PM -0300, Werner Almesberger wrote:
> Jeff Garzik wrote:
> > That said, I used to be an LKCD cheerleader until a couple people made 
> > some good points to me:  it is not nearly low-level enough to truly be 
> > of use in crash situations.
> 
> I'm not so convinced about this. I like the Mission Critical
> approach: save the dump to memory, then either boot through the
> firmware or through bootimg (nowadays, that would be kexec),
> then retrieve the dump from memory, and do whatever you like
> with it.
> 
> The huge advantage here is that you don't need a ton of
> specialized dump drivers and/or have much of the original kernel
> infrastructure to be in a usable state. The rebooted system will
> typically be stable enough to offer the full range of utilities,
> including up to date drivers for all possible devices, so you
> can safely write to disk, scp all the mess to your support
> critter, or post an automatic flame to linux-kernel :-)
> 
> The weak points of the Mission Critical design are that early
> memory allocation in the kernel needs to be tightly controlled,
> that architectures that wipe CPU caches on reboot need to
> commit them to memory before the firmware restart, and that
> drivers need to be able to recover from an "unclean" hardware
> state. (I think we'll see much of the latter happen as kexec
> advances. The other two issues aren't really special.)
> 
> Actually, at the RAS BOF I thought that IBM were developing LKCD
> in this direction, and had also eliminated a few not so elegant
> choices of Mission Critical's original design. I haven't looked

Yes, we are putting that in as one of the alternative dump targets
available. I have done quite a bit of work on that implementing the
ideas we talked about at OLS, and that's what I've been referring
to as the memory dump target.  Its not quite ready yet and we
need something like kexec to be available which we can use on Intel 
systems to achieve the softboot (the acceptance status of that still
doesn't seem to be clear), so I was looking at this as a
follow-on thing once the core infrastructure is there. More so 
because we probably need to give it some time to stabilize and try 
it on different environments and look at the issues you mention.

Why do we even consider the other options when we are doing 
this already ? Well, as we discussed earlier there's non-disruptive dumps 
for one, where this wouldn't work. The other is that before overwriting 
memory we need to be able to stop all activity in the system for certain
(system may appear hung/locked up) and I'm not fully certain about
how to do this for all environments. Maybe an answer lies in 
rethinking some parts of the algorithm a bit.

Also having the interface allows people to develop more specific/
reliable solutions for their environment. So we do not necessiate 
code duplication, but if something exists, then the infrastructure 
can use it. 

The general feeling here is that a one solution fits all thing 
may not work best right now ... and hence the focus on an interface 
based approach that gives us the needed flexibility. 

> at the LKCD code, but the descriptions sound as if all the
> special-case cruft seems to be back again, which I would find a
> little disappointing.

Hope that helps a bit.

Regards
Suparna

> 
> There might be a case for specialized low-overhead dump handlers
> for small embedded systems and such, but they're probably better
> maintained outside of the mainstream kernel. (They're more like
> firmware anyway.)
> 
> - Werner
> 
> -- 
>   _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
> /_http://www.almesberger.net/____________________________________________/
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Influence the future 
> of Java(TM) technology. Join the Java Community 
> Process(SM) (JCP(SM)) program now. 
> http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
> _______________________________________________
> lkcd-devel mailing list
> lkcd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lkcd-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


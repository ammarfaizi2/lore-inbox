Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267929AbTBLXPX>; Wed, 12 Feb 2003 18:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbTBLXPX>; Wed, 12 Feb 2003 18:15:23 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:31632 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267929AbTBLXPT> convert rfc822-to-8bit; Wed, 12 Feb 2003 18:15:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       Crispin Cowan <crispin@wirex.com>
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for 2.5.59
Date: Wed, 12 Feb 2003 17:24:54 -0600
User-Agent: KMail/1.4.1
Cc: magniett <Frederic.Magniette@lri.fr>, torvalds@transmeta.com,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se> <3E4AC92A.4020705@wirex.com> <20030212230550.A19831@infradead.org>
In-Reply-To: <20030212230550.A19831@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302121724.54694.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 05:05 pm, 'Christoph Hellwig' wrote:
> On Wed, Feb 12, 2003 at 02:22:34PM -0800, Crispin Cowan wrote:
> > WRT "taking away LSM patches": HCH wants to remove hooks that "no one
> > uses" and also complains about LSM being a big ugly undesigned hack
> > lacking abstraction.
> >
> > LSM does have an abstract design: it mediates
> > access to major internal kernel objects (processes, inodes, etc.) by
> > user-space processes, throwing access requests out to the LSM module.
>
> We seem to use the term design differently.  And maybe my english
> wording wasn't perfect (I'm no native speaker..).  My objection is that
> LSM by itself does not enforce the tightest bit of security policy
> design.  Your "design" is putting in hooks before object accesses
> without making them tied to enforcing some security policy.
>
> Now I hear people scream "but we want $BIGNUM totally different security
> policies", but that;'s not what I want to take away.  Look at the Linux
> VFS, it enforces quite a lot of stuff, and still we have tons of entirely
> different filesystems.  Of course that could also have worked by putting
> a function vector directly below the syscall level, similar to say the SVR3
> filesystem switch.  But that means a) we duplicate tons of code because
> filesystems are filesystem and there's stuff they will have to duplicate
> anyway.  and b) there's stuff we just can't handle that way properly.
> (see the cross-directory rename issue still present in most non-linux
> unices).
>
> Now getting a LSM-replacement in place that is as well-designed,
> feature-rich and still rather slick as the Linux VFS won't happen
> over night.  But if you see how we got that code is that we had
> example filesystems that showed would should go into common code.

Actually - one of the requirements was to be able to REMOVE all hooks to
create a system with NO added overhead. The VFS does add overhead, but the 
flexibility dictated that it be accepted.

> That's one of the reason why I think merging LSM-like hooks without
> examples (three or four general purpose policies best) doesn't make
> much sense.  We need to see what we can abstract out and how.
>
> And here we see _the_ problem with the LSM process.  LSM wasn't
> developed as part of the broad kernel community (lkml) but on
> a rather small, almost private list.  People added hooks not because
> they generally make sense but because their module needed it.
> When reading this thread some people (e.g. David [*]) still seem that
> changes should be done for LSM's sake - but that's entirely wrong.
> The point of getting LSM or something similar in is for the sake
> of the _linux_ _kernel_ getting usefull features, not for enabling
> some small community writing out of tree modules.

That wasn't true either - as I recall, the group that started working on LSM
was strongly suggested to take it off the list until "show me the code" could
be done.

> > If
> > you remove some of these hooks because they don't have a *present*
> > module using them, then you break the abstraction.
>
> An abstraction that isn't used is worthless.

Ummmm. Not all of the SCSI options are used either. Does that make the SCSI 
layer worthless?

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

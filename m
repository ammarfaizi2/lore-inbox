Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbTBLW4J>; Wed, 12 Feb 2003 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267922AbTBLW4J>; Wed, 12 Feb 2003 17:56:09 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:40452 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267917AbTBLW4H>; Wed, 12 Feb 2003 17:56:07 -0500
Date: Wed, 12 Feb 2003 23:05:50 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: magniett <Frederic.Magniette@lri.fr>, torvalds@transmeta.com,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
Subject: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030212230550.A19831@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>,
	magniett <Frederic.Magniette@lri.fr>, torvalds@transmeta.com,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
	"Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se> <3E4A9C4D.F580576E@lri.fr> <20030212183812.A14810@infradead.org> <3E4AC92A.4020705@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E4AC92A.4020705@wirex.com>; from crispin@wirex.com on Wed, Feb 12, 2003 at 02:22:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 02:22:34PM -0800, Crispin Cowan wrote:
> WRT "taking away LSM patches": HCH wants to remove hooks that "no one 
> uses" and also complains about LSM being a big ugly undesigned hack 
> lacking abstraction.

> LSM does have an abstract design: it mediates 
> access to major internal kernel objects (processes, inodes, etc.) by 
> user-space processes, throwing access requests out to the LSM module.

We seem to use the term design differently.  And maybe my english
wording wasn't perfect (I'm no native speaker..).  My objection is that
LSM by itself does not enforce the tightest bit of security policy
design.  Your "design" is putting in hooks before object accesses
without making them tied to enforcing some security policy.

Now I hear people scream "but we want $BIGNUM totally different security
policies", but that;'s not what I want to take away.  Look at the Linux
VFS, it enforces quite a lot of stuff, and still we have tons of entirely
different filesystems.  Of course that could also have worked by putting
a function vector directly below the syscall level, similar to say the SVR3
filesystem switch.  But that means a) we duplicate tons of code because
filesystems are filesystem and there's stuff they will have to duplicate
anyway.  and b) there's stuff we just can't handle that way properly.
(see the cross-directory rename issue still present in most non-linux
unices).

Now getting a LSM-replacement in place that is as well-designed,
feature-rich and still rather slick as the Linux VFS won't happen
over night.  But if you see how we got that code is that we had
example filesystems that showed would should go into common code.

That's one of the reason why I think merging LSM-like hooks without
examples (three or four general purpose policies best) doesn't make
much sense.  We need to see what we can abstract out and how.

And here we see _the_ problem with the LSM process.  LSM wasn't
developed as part of the broad kernel community (lkml) but on
a rather small, almost private list.  People added hooks not because
they generally make sense but because their module needed it.
When reading this thread some people (e.g. David [*]) still seem that
changes should be done for LSM's sake - but that's entirely wrong.
The point of getting LSM or something similar in is for the sake
of the _linux_ _kernel_ getting usefull features, not for enabling
some small community writing out of tree modules.

> If 
> you remove some of these hooks because they don't have a *present* 
> module using them, then you break the abstraction.

An abstraction that isn't used is worthless.

	Christoph

[*] and btw, question in mails sent to a list I'm not subscribed to in
    reply to mails from me won't get answered, sorry.

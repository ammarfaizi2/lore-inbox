Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbTBJQib>; Mon, 10 Feb 2003 11:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTBJQib>; Mon, 10 Feb 2003 11:38:31 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:55468 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S264986AbTBJQi3>;
	Mon, 10 Feb 2003 11:38:29 -0500
Message-Id: <200302101655.LAA08303@moss-shockers.ncsc.mil>
Date: Mon, 10 Feb 2003 11:55:41 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hch@infradead.org
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: FAy9NoRr1oaMeH55MrcR1Q==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> Well, selinux is still far from a mergeable shape and even needed additional
> patches to the LSM tree last time I checked.  This think of submitting hooks
> for code that obviously isn't even intende to be merged in mainline is what
> I really dislike, and it's the root for many problems with LSM.

It is true that SELinux is not yet in mergeable shape, but we do intend
to address those issues.  With regard to additional patches, SELinux
has at times diverged slightly from the main LSM patch, but we do feed
back changes.  At present, the only significant change in the
additional patch has to do with early initialization of SELinux so that
we can properly set up the security state of kernel objects when they
are created rather than needing to retroactively set up the state of
objects created before module initialization.  That issue has come up
in general for security modules on the LSM list, and we would need to
submit a general solution for it along with the submission of SELinux
for mainline.  Hence, you are correct that there is work to be done
before SELinux can be merged, but you are wrong to assume that we do
not intend to do that work or to submit SELinux.

> There has been a history in Linux to only implement what actually needed
> now instead of "clever" overdesigns that intend to look into the future,
> LSM is a gross voilation of that principle.  Just look at the modules in
> the LSM source tree:  the only full featured security policy in addition
> to the traditional Linux model is LSM, all the other stuff is just some
> additionl checks here and there.

I assume that you mean "SELinux" above.  It is true that SELinux is the
dominant user of the LSM hooks at present.  We would have been happy to
submit SELinux as a direct kernel patch rather than adding a further
level of indirection via LSM, but that wasn't the guidance we were
given.

> I'm very serious about submitting a patch to Linus to remove all hooks not
> used by any intree module once 2.6.0-test.

Any idea on how much time that gives us (to rework SELinux and submit
it)?  Some of the necessary changes are simply engineering issues, but
others require further dialogue, e.g. getting the API into an
acceptable form, revisiting the approaches used to label and control
access to pseudo filesystems.

> Life would be a lot simpler if you got the core flask engine in a mergeable
> shapre earlier and we could have merged the hooks for actually using it
> incrementally during 2.5, discussing the pros and contras for each hook
> given an actual example - but the current way of adding extremly generic
> hooks (despite the naming they are in no ways tied to enforcing security
> models at all) without showing and discussing the code behind them simply
> makes that impossible.

We would have preferred this route as well, but again it wasn't the
guidance that we were given.  We were told to work on something
LSM-like, then told to wait to initially submit it until after certain
other changes went into 2.5.

> So yes, my suggestion is to backout the whole LSM mess for 2.6, merge
> a sample policy core (i.e. a cleaned up flask/selinux) in 2.7.<early> and
> then add one hook after another and discussing the architecture openly
> where it belongs (here on lkml!).

Leaving 2.6 with no infrastructure for access control extensions at all?
Is this really preferable to keeping LSM in 2.5/2.6, and then migrating
to a more directly integrated architecture in 2.7?
 
--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbTBKH4A>; Tue, 11 Feb 2003 02:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTBKH4A>; Tue, 11 Feb 2003 02:56:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:50449 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267007AbTBKHz6>; Tue, 11 Feb 2003 02:55:58 -0500
Date: Tue, 11 Feb 2003 08:05:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030211080538.A5876@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302101655.LAA08303@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302101655.LAA08303@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Feb 10, 2003 at 11:55:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:55:41AM -0500, Stephen D. Smalley wrote:
> 
> Christoph Hellwig wrote:
> > Well, selinux is still far from a mergeable shape and even needed additional
> > patches to the LSM tree last time I checked.  This think of submitting hooks
> > for code that obviously isn't even intende to be merged in mainline is what
> > I really dislike, and it's the root for many problems with LSM.
> 
> back changes.  At present, the only significant change in the
> additional patch has to do with early initialization of SELinux so that
> we can properly set up the security state of kernel objects when they
> are created rather than needing to retroactively set up the state of
> objects created before module initialization.

And that for examples is a very important and needed change.  Security
modules as loadable modules are a bad idea as you don't have a consistand
labelling state - just look at the older selinux versions with all the
precondition mess.  But it should be generalized to a new initcall level
instead of the current explicit call to the selinux routine..

> > There has been a history in Linux to only implement what actually needed
> > now instead of "clever" overdesigns that intend to look into the future,
> > LSM is a gross voilation of that principle.  Just look at the modules in
> > the LSM source tree:  the only full featured security policy in addition
> > to the traditional Linux model is LSM, all the other stuff is just some
> > additionl checks here and there.
> 
> I assume that you mean "SELinux" above.

Yes, sorry.

> It is true that SELinux is the
> dominant user of the LSM hooks at present.  We would have been happy to
> submit SELinux as a direct kernel patch rather than adding a further
> level of indirection via LSM, but that wasn't the guidance we were
> given.

The problem is not really the indirection but the submission of the
indirection without it's users.

> > I'm very serious about submitting a patch to Linus to remove all hooks not
> > used by any intree module once 2.6.0-test.
> 
> Any idea on how much time that gives us (to rework SELinux and submit
> it)?

Unfortunately I don't decide about the linux 2.6 freeze - ask Linus.

> Some of the necessary changes are simply engineering issues, but
> others require further dialogue, e.g. getting the API into an
> acceptable form, revisiting the approaches used to label and control
> access to pseudo filesystems.

+ moving to extended attributes instead of magic files for storing the
  labels on filesystems
+ getting the patent issue sorted out

> Leaving 2.6 with no infrastructure for access control extensions at all?
> Is this really preferable to keeping LSM in 2.5/2.6, and then migrating
> to a more directly integrated architecture in 2.7?

Personally I prefer to not have infrastructure in over having broken
infrastructure.  Looks at what the devfs mess caused in 2.4 and how much
was removed or is beeing removed/rewritten again in 2.5.  Life would have
been a lot simpler if it never got in during 2.4.  Similarly I don't see the
problem why the current lsm users can't keep using patches during 2.6.


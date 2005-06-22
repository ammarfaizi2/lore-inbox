Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVFVRM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVFVRM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFVRJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:09:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20148 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261688AbVFVRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:01:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       <fastboot@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com> <20050621132204.1b57b6ba.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Jun 2005 10:53:13 -0600
In-Reply-To: <20050621132204.1b57b6ba.akpm@osdl.org>
Message-ID: <m1fyvamiyu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > > sparsemem
> > > 
> > >     OK by me for a merge.  Need to poke arch maintainers first, check that
> > >     they've looked at it sufficiently closely.
> > 
> > seems sane, though there are some whitespace niggles that should be 
> > cleaned up
> > 
> 
> There are?  I thought I fixed most of them.
> 
> *general sigh*.  I wish people would absorb CodingStyle.  It's not hard,
> and fixing the style post-facto creates a real mess.  I now have a great
> string of kexec patches followed by a "kexec-code-cleanup.patch" which
> totally buggers up the patch sequencing and really needs to be split into
> 18 parts and sprinkled back over the entire series.

It looks like I have another hole in my schedule where I can put some
work into kexec so I will see what I can do.

If you want people to absorb CodingStyle it needs to be more explicit.
Of the things that patch fixes you almost have to read between
the lines of CodingStyle to see.  If there is anything backing
it up at all.  Until the problems were pointed out to me I simply
could not see them, and reading CodingStyle was not enlightening.
I point this out not to complain but more so people know which
part of the process needs fixing.

> > > kexec and kdump
> > > 
> > >     I guess we should merge these.
> > > 
> > >     I'm still concerned that the various device shutdown problems will
> > >     mean that the success rate for crashing kernels is not high enough for
> > > kdump to be considered a success.  In which case in six months time we'll
> 
> > >     hear rumours about vendors shipping wholly different crashdump
> > >     implementations, which would be quite bad.
> > > 
> > >     But I think this has gone as far as it can go in -mm, so it's a bit of
> > >     a punt.
> > 
> > I'm not particularly pleased with these,
> 
> How come?

Please tell.

With respect to users of crashdumps there are at least two groups
converging on kexec based crashdumps.  Is there active development
on any of the rest of the tools.

On to the practical response.  The kexec has effectively zero
impact on the kernel, except when it is invoked, and the
code is small.  Kexec is also useful for a lot more than 
just crash dumps.  It happens that crashdumps seem to be the only
case where the other alternatives are noticeably less sane.

There is also another important piece about kexec based crashdumps
that is not usually envisioned.  The kexec based solution is much more
flexible.  For example on a cluster the worst case scenario for
a network based crashdump is all 1000+ nodes will output a crashdump
simultaneously.  Poor crashdump server.  Where with the kexec based
approach it is possible to have the machines send an SNMP alert
and then you can come in and have the machine dump only when you are
ready.  Or you might even start a gdb-stubs server and interact
with a live core dump. :)  And all of this happens to fall out
naturally from using a kernel after the crash.

There are a few associated bug fixes that are problematic but I think
they are fixable.   For the crashdump case the work really is going
into getting hardening linux so it can run on imperfectly behaving hardware.
I.e.  things that are bugs in any event but that using the kernel to
take a crashdump exacerbates.

Andrew the good news is unless something comes up I will have time
starting about Monday to help with the 2.6.13 merge.  It looks like
the first thing I should do is split up the indent patch so it pairs
well with the rest.  And then I have a few pending patches for the user
space and I think I can fix a number of the device_shutdown problems,
for at least the normal kexec path.

Eric

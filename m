Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279746AbRJ3KjX>; Tue, 30 Oct 2001 05:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279910AbRJ3KjN>; Tue, 30 Oct 2001 05:39:13 -0500
Received: from ns.caldera.de ([212.34.180.1]:45192 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S279746AbRJ3KjC>;
	Tue, 30 Oct 2001 05:39:02 -0500
Date: Tue, 30 Oct 2001 11:37:31 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Mike Jagdis <jaggy@purplet.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [PATCH] syscall exports - against 2.4.14-pre3
Message-ID: <20011030113731.A14808@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Mike Jagdis <jaggy@purplet.demon.co.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <20011029173711.B24272@caldera.de> <3BDE7D22.8000006@purplet.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDE7D22.8000006@purplet.demon.co.uk>; from jaggy@purplet.demon.co.uk on Tue, Oct 30, 2001 at 10:12:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 10:12:50AM +0000, Mike Jagdis wrote:
> Christoph Hellwig wrote:
> > Hi Linus,
> > 
> > once again the syscall export patch - back to EXPORT_SYMBOL
> > vs EXPORT_SYMBOL_GPL due to some complaints, more syscalls
> > as I dropped sys_call_table abuse in linux-abi.
> 
> The whole *point* of the sys_call_table "abuse" was to avoid having
> the whole damn lot in the export list!

It is not only ugly over belief but also unportable.

For example the mips port does not have a sys_call_table array at all,
on IA64 funktion pointer do _NOT_ fit into an unsigned long so at least
the prototype is wrong if it works at all.

> As a side effect it meant that any module that patched the
> sys_call_table (funky tracers, security hot-fixes, whatever)
> would work seamlessly with non-Linux binaries.

This is not only racy (no locking!) but also a loophole for binary
modules to do all kinds of crap (see http://www.sysinternals.com/linux/
utilities/filemon.shtml for details).  In early 2.5 I will submit a patch
to remove the export, let's see wether it will be accepted.

> 
> > Could you _please_ apply it - it is badly needed for foreign
> > personalities compiled as modules.
> 
> I can't see why? iBCS always was a module for years before
> linux-abi dumped it back in a humungous kernel patch.

"Because we did it all the time it's right".

Of course it worked - that doesn't mean it's a good idea.
Arjan might want to comment on how gcc 2.96+ liked the old concept..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

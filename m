Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbTDGGzi (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTDGGzi (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:55:38 -0400
Received: from dp.samba.org ([66.70.73.150]:12505 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262764AbTDGGzh (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 02:55:37 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.5444.941131.275543@argo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2003 16:05:56 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
In-Reply-To: <20030407072144.A28096@infradead.org>
References: <20030407024858.C32422C014@lists.samba.org>
	<20030407065813.A27933@infradead.org>
	<16017.2065.635724.992168@argo.ozlabs.ibm.com>
	<20030407072144.A28096@infradead.org>
X-Mailer: VM 7.14 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> On Mon, Apr 07, 2003 at 03:09:37PM +1000, Paul Mackerras wrote:
> > sys_personality will fail if there isn't an exec_domain registered for
> > the personality you want.
> 
> But there already is one registered :)  Okay, you\re right.
> 
> > Why?  It's a well-contained patch that affects very little outside its
> > own area, and is quite similar to other things that have been there
> > for ages.
> 
> Because stuff should go into 2.5 first.    And even if it looks trivial
> there's an important policy decision here:  do we want to clutter up
> our personality system for userspace emulators?   If you look at the
> current list of personalities they all have kernel implementations, even
> if not all of them are currently merged, qemu OTOH is a purely userspace
> thing (and still very new!).  Personally I'd rather prefer qemu doing
> pathname translation in userspace instead of bloating the kernel.  This
> gets even more important when we get qemu-style emulators for other
> architectures - the number of personalities needed just for this ugly
> pathname-translation scheme will get very high.

Well, all we really want is a way to set emul_prefix.  Which I could
do with a PPC-specific syscall if I had to, I guess.  Doing it in
userspace is possible but ugly, because you have to handle several
different syscalls, plus keep track of the current directory, plus
handle symlinks, etc., etc., in the emulator.  The kernel has all that
information readily to hand plus the data structures to keep track of
it all.

> > Anyway, it's not your call.
> 
> if you look at MAINTAINERS I'm responsible for personality handling, so
> maybe it actually _is_ my call?

Oh.  Ah.  I didn't realize it was a subsystem with a maintainer.

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTACK3s>; Fri, 3 Jan 2003 05:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTACK3s>; Fri, 3 Jan 2003 05:29:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59196 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267474AbTACK3r>; Fri, 3 Jan 2003 05:29:47 -0500
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andy Pfiffer <andyp@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       wa@almesberger.net
Subject: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jan 2003 03:37:06 -0700
In-Reply-To: <20021231200519.A2110@in.ibm.com>
Message-ID: <m11y3uldt9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> The good news is that it worked for me. Not only that, I have just 
> managed to get lkcd to save a dump in memory and then write it out 
> to disk after a kexec soft boot ! I haven't tried real panic cases yet 
> (which probably won't work rightaway :) ) and have testing and 
> tuning to do. But kexec seems to be looking good.

Nice.  Any pointers besides lkcd.sourceforge.net

For the kexec on panic case there is a little code motion yet to be
done so that no memory allocations need to happen.  The big one is
setting up a page table with the reboot code buffer identity mapped.

I am tempted to do the identity mapping of the reboot code buffer in
init_mm, but for starters I will look at how complex it will be to
have a spare mm just sitting around for that purpose.  When I get
to dealing with the architectures like the hammer, and the alpha where
you always need page tables I will need to develop an architecture
specific hook for building the page tables needed by the
code residing in the reboot code buffer, (because virtual memory
cannot be disabled), but that should be straight forward.

My goal is to have no locks on the kexec part of the panic path.  And
the current memory allocations are the only really bad part of that.

A dump question.  Why doesn't the lkcd stuff use the normal ELF core
dump format?  allowing ``gdb vmlinux core'' to work?

Eric

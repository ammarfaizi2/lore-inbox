Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289381AbSAODJl>; Mon, 14 Jan 2002 22:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSAODJa>; Mon, 14 Jan 2002 22:09:30 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:49927 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S289370AbSAODJB>;
	Mon, 14 Jan 2002 22:09:01 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201150308.g0F38rp502016@saturn.cs.uml.edu>
Subject: Re: [RFC] klibc requirements
To: felix-dietlibc@fefe.de (Felix von Leitner)
Date: Mon, 14 Jan 2002 22:08:53 -0500 (EST)
Cc: greg@kroah.com (Greg KH), linux-kernel@vger.kernel.org,
        andersen@codepoet.org
In-Reply-To: <20020109042331.GB31644@codeblau.de> from "Felix von Leitner" at Jan 09, 2002 05:23:31 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner writes:

> My understanding of what "initramfs programs" actually means is vague at
> best.  Are these just programs that are intended to work in an initial
> ram disk?  Or is it a special collection that is included in the kernel
> distribution?

1. special collection by default
2. user-specified as desired

I think the dietlibc idea has to be scrapped so we can run BSD apps.
(and others maybe, but I'm not looking to start a flame war)

uClibc is LGPL, so traditional 4-clause BSD licensed code can be
linked with it.

> there are no legacy requirements to cater to.  We can write code without
> printf and stdio, for example.  Also, we probably don't need regular
> expressions or DNS.  Those are the big space hogs when linking
> statically against a libc.  In the diet libc, all of the above are very
> small, but avoiding them in the first place is better then optimizing
> them for small size.

DNS is very good to have. There are many things one might want
to specify by name. NFS servers, NIS servers, SMB servers, and
even the machine itself to get an IP via DNS.

> This may look like a good idea, but dynamic linking should be avoided.
> Trust me on this.  While it is possible to squeeze the dynamic loader
> down to below 10k, 10k really is a lot of code.  And empty program with
> the diet libc is way below 1k on x86.  So to reap the benefit of dynamic
> linking, you would need a lot of programs.  Also please note that -fPIC
> makes code larger.  And we need to keep symbols around, which makes up a
> substantial part of the shared diet libc.

a.out

Even with ELF, you shouldn't need that 10 kB. Treat ELF like a.out,
getting rid of the -fPIC stuff in favor of offsets assigned when
you build the initramfs. Dynamic linking should be:

open
mmap
mmap
close

You know the file to open. You know what offset you need it at.
There isn't any need for symbols. OK, that's half-dynamic,
but it gets the job done.

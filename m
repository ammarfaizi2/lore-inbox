Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265287AbSJRQeF>; Fri, 18 Oct 2002 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbSJRQeE>; Fri, 18 Oct 2002 12:34:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9955 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265287AbSJRQd0>;
	Fri, 18 Oct 2002 12:33:26 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021018111442.GH16501@dualathlon.random>
References: <1034915132.1681.144.camel@cog> 
	<20021018111442.GH16501@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Oct 2002 09:39:15 -0700
Message-Id: <1034959158.14862.21.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 04:14, Andrea Arcangeli wrote:
> the main reason it wasn't backported to i386 is that if glibc start
> using the vgettimeofday instead of sys_gettimeofday, you won't be able
> to downgrade kernel anymore to say 2.4 (oh yeah, I would then backport
> it to my tree or Marcelo could apply the patches too to 2.4 but then 2.2
> would be left uncovered, new glibc would segfault on the old kernels).
> Probably the only way to avoid breaking backwards compatibility is that
> glibc will check the uname at the first invocation and then it will
> store the information in a global variable in the library. So then for
> every second invocation it will be only an overhead of a branch. But it
> would be a slowdown for this sequence
> fork()exec()gettimeofday()exit()fork()exec()gettimeofday()exit()...

Hmmm. Yes, that is a good point. Especially since due to TSC sync
issues, everyone probably won't want to convert to this right off.
Probing might do it, but that would require some fancy trapping in
glibc. Maby users could manually LDPRELOAD a library that would alias
gettimeofday, rather then changing glibc? That way the user of, as you
said specialized db apps,etc, who *really* wants this can get it, but
doesn't affect others. 

[snip]
> However this is just a reminder message, I mainly wanted to point out
> why I didn't spent time in this effort myself, if Linus is excited to
> include vsyscalls on 32bit too that's fine with me, it would be a
> definitive improvement at least for the non asymmetric multithreading
> nor NUMA cases where the TSC loses synchronization (unless something
> mmapped like cyclone or HPET is available of course). So it's up to you ;).

It seems you been calling the psychic hotline recently! Actually that's
*exactly* what my plans were for the NUMA case. Very good call!

You bring up some good points. I'll try to think about it some more and
see if there isn't a better way. 

thanks
-john


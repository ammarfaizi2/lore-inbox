Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTBRDvt>; Mon, 17 Feb 2003 22:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTBRDvt>; Mon, 17 Feb 2003 22:51:49 -0500
Received: from dp.samba.org ([66.70.73.150]:2180 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267581AbTBRDvs>;
	Mon, 17 Feb 2003 22:51:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, tridge@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cyeoh@samba.org, sfr@canb.auug.org.au, anton@samba.org,
       paulus@samba.org, drepper@redhat.com
Subject: Re: [PATCH] Prevent setting 32 uids/gids in the error range 
In-reply-to: Your message of "17 Feb 2003 14:55:20 -0000."
             <1045493720.19397.4.camel@irongate.swansea.linux.org.uk> 
Date: Tue, 18 Feb 2003 15:01:29 +1100
Message-Id: <20030218040149.17A5D2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1045493720.19397.4.camel@irongate.swansea.linux.org.uk> you write:
> On Mon, 2003-02-17 at 07:41, Rusty Russell wrote:
> > Tridge noticed that getegid() was returning EPERM.
> > 
> > I used -1000 since that's what PTR_ERR uses, but i386 _syscall macros
> > use -125: I don't suppose it really matters.
> 
> Thats a bug in the interface. getegid/getgid/setegid/setuid() is not permitted to fail.
> If libc is setting errno and returning -1 the libc wrapper is wrong.

OK, thanks.  Note that out asm-i386/unistd.h syscallX macros do it
wrong, too.

AFAICT, glibc (2.3.1) gets this wrong, and interprets 0xffffffff
return from geteuid() as an error (ie. it's not just an strace bug).
Tested by Tridge.

Paulus points out that this also means special handling on archs (PPC
and PPC64 that I know of) which set a condition code on error: this
can be sidestepped in glibc, as well.

Other archs beware.

Thanks for the clarification,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

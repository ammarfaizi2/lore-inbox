Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTACSig>; Fri, 3 Jan 2003 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTACSig>; Fri, 3 Jan 2003 13:38:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267623AbTACSif>; Fri, 3 Jan 2003 13:38:35 -0500
Date: Fri, 3 Jan 2003 10:41:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <sfr@canb.auug.org.au>, <rth@twiddle.net>,
       <rmk@arm.linux.org.uk>, <bjornw@axis.com>, <davidm@hpl.hp.com>,
       <geert@linux-m68k.org>, <ralf@gnu.org>, <paulus@samba.org>,
       <anton@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <gniibe@m17n.org>, <kkojima@rr.iij4u.or.jp>,
       "David S. Miller" <davem@redhat.com>, <ak@suse.de>
Subject: Re: [PATCH] extable cleanup
In-Reply-To: <20030103082410.94B0E2C275@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301031036560.2750-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Jan 2003, Rusty Russell wrote:
>
> Fairly straightforward consolidation of extable handling.  Sparc64 is
> trickiest, with its extable range stuff (ideally, the ranges would be
> in a separate __extable_range section, then the extable walking code
> could be made common, too).
> 
> Only tested on x86: ppc and sparc64 written untested, others broken.

Did you test on a true i386, which needs exception handling very early on 
to handle the test for broken WP? In other words, are all the exception 
table data structures properly initialized?

And did you check that an oops in the init handling works correctly before
the kallsyms table has been initialized? That "initcall(symbol_init)"  
makes me suspect it won't..

There was a reason why "extable_init()" was in init/main.c, and was done 
_early_.

		Linus


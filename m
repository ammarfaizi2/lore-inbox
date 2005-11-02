Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVKBUMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVKBUMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVKBUMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:12:51 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:28648 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965213AbVKBUMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:12:50 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <rolandd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20051102174852.GB1899@redhat.com>
References: <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com> <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com> <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <52ll07a844.fsf@cisco.com> <Pine.LNX.4.64.0511020746330.27915@g5.osdl.org> <20051102174852.GB1899@redhat.com>
Date: Wed, 2 Nov 2005 12:11:31 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: New (now current development process)
In-Reply-To: <20051102174852.GB1899@redhat.com>
Message-ID: <Pine.LNX.4.62.0511021207550.2820@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
 <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
 <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com>
 <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <52ll07a844.fsf@cisco.com>
 <Pine.LNX.4.64.0511020746330.27915@g5.osdl.org> <20051102174852.GB1899@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Dave Jones wrote:

> On Wed, Nov 02, 2005 at 07:54:04AM -0800, Linus Torvalds wrote:
>
> > > For your last suggestion, maybe someone can automate running Andi's
> > > bloat-o-meter?  I think the hard part is maintaining comparable configs.
> >
> > Yes. And we should probably make -Os the default. Apparently Fedora
> > already does that by just forcibly hacking the Kconfig files.
>
> (excuse any typos, this wireless connection is god-awful)
> We do. We rip out the dependancyon CONFIG_EMBEDDED, and build
> with OPTIMISE_FOR_SIZE set. At least we usually do.
> Once every so often, we hit something which throws a spanner
> in the works, like the "x86-64 doesn't boot any more" problem
> that was fixed by the patch that Alexandre posted earlier
> this week.
>
> Most of the time now, when we hit bugs with -Os, it seems to be due
> to broken asm constraints in the kernel rather than actual
> gcc bugs, but of course, they also occur from time to time,
> whereas the same code works just fine with -O2.
> I think part of th reason for this is exactly because it
> doesn't get a great deal of testing.

I used to compile with Os on all my kernels, but when the alignment 
settings got added to the embedded section a few kernels ago and I saw 
that they all default to 0 (no alignment) it scared me off, becouse I know 
that unaligned accesses can be extremely expensive, and I wasn't 
comfortable that I had the right info to set them for the different CPU's 
that I have.

I would really like to see Os move out of the embedded section so that it 
can be tested (and used) without having to worry about all those other 
settings. The other option would be to have all those other settings get 
good defaults (with an option to reset them to the defaults when you 
change the CPU type).

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

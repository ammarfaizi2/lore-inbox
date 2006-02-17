Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWBQJnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWBQJnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWBQJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:43:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41640 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161171AbWBQJnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:43:13 -0500
Date: Fri, 17 Feb 2006 10:41:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060217094127.GA29991@elte.hu>
References: <20060216094130.GA29716@elte.hu> <20060216132309.fd4e4723.pj@sgi.com> <20060216215036.GD25738@elte.hu> <20060216205618.d4d97d9d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216205618.d4d97d9d.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> First, let me point out the tight coupling of this patch set, at least 
> as currently presented, with glibc.  Notice for example the following 
> comment from your patch:
> 
> + * NOTE: this structure is part of the syscall ABI, and must only be
> + * changed if the change is first communicated with the glibc folks.

Note that this is really business as usual: we already have dozens of 
different 'struct' parameters to hundreds of syscalls, to all of which 
exactly these restrictions apply: they must never be changed.

Furthermore there are a good deal of other implicit and explicit data 
structure assumptions that all form the ABI - and which the kernel must 
not break.

The only unusual thing i guess is that i documented it for this new bit 
of functionality ;-)

[ In fact, the robust_list syscalls are shaped so that the structures 
_can_ be changed if done with care (due to the length parameter). The 
overwhelming majority of our other ABI assumptions are hardcoded and are 
only changeable by writing totally new syscalls and phasing out the old 
ones. ]

I agree with your suggestion of better documenting the 
kernel<->userspace ABI, but this should be done independently of robust 
futexes.

	Ingo

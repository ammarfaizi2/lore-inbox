Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSAPVqj>; Wed, 16 Jan 2002 16:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289008AbSAPVqe>; Wed, 16 Jan 2002 16:46:34 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:14860 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287676AbSAPVqU>;
	Wed, 16 Jan 2002 16:46:20 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15429.61767.644150.186995@argo.ozlabs.ibm.com>
Date: Thu, 17 Jan 2002 08:31:51 +1100 (EST)
To: <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks... 
In-Reply-To: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain>
In-Reply-To: <E16QnOx-0003vt-00@wagner.rustcorp.com.au>
	<Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> It's
> slightly cheaper to pass an already existing (calculated) 'current'
> pointer over to another function, instead of calculating it once more in
> that function.

On x86 that's true; many other architectures - alpha, ia64, m68k,
mips, mips64, parisc, ppc, ppc64, sparc, sparc64 - keep current in a
register already and thus it is slightly more expensive to pass it as
a parameter instead of just using current in the function.

Either way surely the cost is tiny, and the maintainability
considerations should prevail.  Having a function which takes a
task_struct * parameter which _has_ to be current sounds to me like an
invitation for somebody to get it wrong down the track.

Paul.

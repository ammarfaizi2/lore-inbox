Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUDFQCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUDFQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:02:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38020
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263880AbUDFP72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:59:28 -0400
Date: Tue, 6 Apr 2004 17:59:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406155925.GW2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406115539.GA31465@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 01:55:39PM +0200, Ingo Molnar wrote:
> 
>         http://redhat.com/~mingo/4g-patches/loop_print.c

loop print does no memory access at all, it just loops forever, no
surprise at all you get very little slowdown no matter how many tlb
flushes happens.

If people needs >3G of user address space I assume they do some bulk
memory access too in their application.

Please write a realistic benchmark and repeat the test, the numbers you
posted are totally meaningless. Try a kernel compile of something
actually realistic (and a kernel compile doing lots of execve isn't the
worst case either).

Also note that the slowdown for app calling heavily syscalls is 30% not
5-10%, no matter if they're threaded or not, further more there has been
no proof that the 30% slowdown of mysql is really related to the
copy-users being serialized by a thread-wide spinlock, we made that
assumption but it's not certain yet.

You should also use a bleeding edge cpu for you measurements with large
tlb caches, which cpu did you use for your measurements?

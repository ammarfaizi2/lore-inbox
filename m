Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUCEOO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUCEOO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:14:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28942
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262597AbUCEOOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:14:24 -0500
Date: Fri, 5 Mar 2004 15:15:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305141504.GY4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305103308.GA5092@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 11:33:08AM +0100, Ingo Molnar wrote:
> 
> * Peter Zaitsev <peter@mysql.com> wrote:
> 
> > > > For Disk Bound workloads (200 Warehouse) I got 1250TPM for "hugemem" vs
> > > > 1450TPM for "smp" kernel, which is some 14% slowdown.
> > > 
> > > Please define these terms.  What is the difference between "hugemem" and
> > > "smp"?
> > 
> > Sorry if I was unclear.  These are suffexes from RH AS 3.0 kernel
> > namings.  "SMP" corresponds to normal SMP kernel they have, "hugemem"
> > is kernel with 4G/4G split.
> 
> the 'hugemem' kernel also has config_highpte defined which is a bit
> redundant - that complexity one could avoid with the 4/4 split. Another

the machine only has 4G of ram and you've an huge zone-normal, so I
guess it will offset not more than 1 point percent or so.

> detail: the hugemem kernel also enables PAE, which adds another 2 usecs
> to every syscall (!). So these performance numbers only hold if you are
> running mysql on x86 using more than 4GB of RAM. (which, given mysql's
> threaded design, doesnt make all that much of a sense.)

are you saying you force _all_ people with >4G of ram to use 4:4?!?
that would be way way overkill. 8/16/32G boxes works perfectly with 3:1
with the stock 2.4 VM (after you nuke rmap).

> vsyscall-sys_gettimeofday and vsyscall-sys_time could help quite some
> for mysql. Also, the highly threaded nature of mysql on the same MM

he said he doesn't use gettimeofday frequently, so most of the flushes
are from other syscalls.

> which is pretty much the worst-case for the 4/4 design. If it's an

definitely agreed.

> issue, there are multiple ways to mitigate this cost.

how? just curious.

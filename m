Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKTHPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 02:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTKTHPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 02:15:44 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:19843
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261555AbTKTHPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 02:15:43 -0500
Date: Thu, 20 Nov 2003 02:14:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <20031119230928.GE22139@waste.org>
Message-ID: <Pine.LNX.4.53.0311200212470.11537@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com>
 <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org> <20031119203210.GC22139@waste.org>
 <20031119230928.GE22139@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Matt Mackall wrote:

> On Wed, Nov 19, 2003 at 02:32:10PM -0600, Matt Mackall wrote:
> > 
> > Zwane's got a K6-2 500MHz. I've just managed to reproduce this on my
> > 1.4GHz Opteron box (with Debian gcc 3.2). Here, the "ooh la la" bit
> > doesn't help. So my suspicion is that the printk is changing the
> > timing just enough on Zwane's box that he's getting a timer interrupt
> > knocking him out of vm86 mode before he hits a fatal bit in the fault
> > handling path for 4/4. Printks in handle_vm86_trap, handle_vm86_fault,
> > do_trap:vm86_trap, and do_general_protection:gp_in_vm86 never fire so
> > there's probably something amiss in the trampoline code.
> 
> Some more datapoints:

Thanks for trying those out, i got another one to add.

> CPU          distro          compiler  video        X     result
> K6-2/500     connectiva 9    2.96      trident      4.3   reboot (zwane)
> K6-2/500     connectiva 9    3.2.2     trident      4.3   reboot (zwane)
> Opteron 240  debian unstable 3.2       S3           4.2.1 reboot
> Athlon 2100  debian unstable 3.2       radeon 7500  4.2.1 works
> P4M 1800     debian unstable 3.2       radeon m7    4.2.1 reboot

P4/Xeon 2000	Fedora Core 1	3.3.2	ATI Rage XL	4.3.0 reboot

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTLVTIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLVTIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:08:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41155
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264468AbTLVTIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:08:49 -0500
Date: Mon, 22 Dec 2003 20:09:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ville Herva <vherva@niksula.cs.hut.fi>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222190943.GF18767@dualathlon.random>
References: <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet> <20031221210917.GB4897@ovh.net> <20031221222338.GC1323@alpha.home.local> <20031222070344.GL1524@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222070344.GL1524@niksula.cs.hut.fi>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:03:44AM +0200, Ville Herva wrote:
> On Sun, Dec 21, 2003 at 11:23:38PM +0100, you [Willy Tarreau] wrote:
> > >
> > > Dec 21 22:08:44 stock kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > > Dec 21 22:08:44 stock kernel: OOM: nr_swap_pages=0cd865e6c c012e1e8 c0262e3c 00000000 000001d2 00000000 00000001 cd863c00 
> > 
> > OK, so there's no available swap anymore (nr_swap_pages=0, Marcelo forgot the
> > '\n' in the patch). I simply think that with other kernels, you're very short
> > of memory, but it runs, while with this one, all memory gets consumed, and
> > since there's no smart oom killer, one process has to get killed.
> 
> BTW, I have a box with 128MB ram and 512MB swap running 2.4.21-jam1 (it has
> the -aa vm). I can't shut it down cleanly, because trying it goes into
> endless loop trying to free memory when turning off swap. Nothing but
> alt-sysrq-b seems to work.
> 
> I don't know if there is a kernel memory leak, since all user level
> processes should be killed at that point, right? Unfortunately I didn't have
> time to dig deeper, as the box is in (sort of) production.

if this is a leak, I doubt it has been introduced recently, the only
swap accounting related change was in the shm layer, and it was supposed
to be a race fix. You may want to check if you've some shm allocated
in /dev/shm or ipcs, while the machine reboots.

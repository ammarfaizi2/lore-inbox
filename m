Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUC0OXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 09:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUC0OXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 09:23:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:672
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261725AbUC0OX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 09:23:29 -0500
Date: Sat, 27 Mar 2004 15:24:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       wli@holomorphy.com
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040327142423.GH9604@dualathlon.random>
References: <20040325214529.GJ20019@dualathlon.random> <Pine.LNX.4.44.0403261107100.16019-100000@localhost.localdomain> <20040326180235.GD9604@dualathlon.random> <20040326152523.5bfe41db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326152523.5bfe41db.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 03:25:23PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Fri, Mar 26, 2004 at 11:57:23AM +0000, Hugh Dickins wrote:
> > > Andrea's 2.6.5-rc2-aa4 (anon_vma): based on Martin's, but very
> > > likely safe since it does not use find_vma at all in swapout, and
> > > unuse_process downs mmap_sem as Martin's used to before.
> > 
> > Hugh, thanks for the review! I also don't see locking bugs in this area
> > in my tree and I like not to take the page_table_lock during vma
> > manipulations since I don't seem to need it.
> 
> It would be really, really nice if we could clean this crap up.  mmap_sem
> protects the vma tree, i_shared_sem protects the per-address_space vma
> lists and page_table_lock protects the pagetables.
> 
> Does this sound like something we can achieve?

yes, and I already achieved this in my tree, so if you plan to merge my
stuff you don't need to touch it in your tree (so it also avoids me to
reject on stuff I already did).

> (Could page_table_lock then become per-vma?)

I probably could make it per-vma, but it's low prio at this time.

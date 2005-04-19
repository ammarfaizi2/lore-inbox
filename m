Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVDSNf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVDSNf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVDSNf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:35:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42976 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261514AbVDSNfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:35:19 -0400
Date: Tue, 19 Apr 2005 15:35:09 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Andi Kleen <ak@suse.de>, "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050419133509.GF7715@wotan.suse.de>
References: <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 06:58:20PM +0100, Hugh Dickins wrote:
> On Fri, 15 Apr 2005, Chris Wright wrote:
> > * Andi Kleen (ak@suse.de) wrote:
> > > On Thu, Apr 14, 2005 at 11:27:12AM -0700, Chris Wright wrote:
> > > > Yes, I've seen it in .11 and earlier kernels.  Happen to have same
> > > > "x86_64" string on my bad pmd dumps, but can't reproduce it at all.
> > > > So, for now, I can hold off on adding the reload cr3 patch to -stable
> > > > unless you think it should be there anyway.
> > > 
> > > It is a bug fix (actually there is another related patch that fixes
> > > a similar bug), but we lived with the problems for years so I guess
> > > they can wait for .12. 
> > 
> > Sounds good.
> 
> I must confess, with all due respect to Andi, that I don't understand his
> dismissal of the possibility that load_cr3 in leave_mm might be the fix
> (to create_elf_tables writing user stack data into the pmd).

Sorry for the late answer.

Ok, lets try again. The hole fixed by this patch only covers
the case of an kernel thread with lazy mm doing some memory access
(or more likely the CPU doing a prefetch there). But ELF loading
never happens in lazy mm kernel threads.AFAIK in a "real" process
the TLB is always fully consistent.

Does that explanation satisfy you? 

I agree that my earlier one was a bit dubious because I argued about
the direct mapping, but the argv setup actually uses user addresses.
But I still think it must be something else.

-Andi

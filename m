Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUDDJ2H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 05:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUDDJ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 05:28:07 -0400
Received: from holomorphy.com ([207.189.100.168]:52410 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262291AbUDDJ2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 05:28:05 -0400
Date: Sun, 4 Apr 2004 01:27:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] setup_identity_mappings depends on zone init.
Message-ID: <20040404092750.GA791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
	Ingo Molnar <mingo@elte.hu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <16465.3163.999977.302378@notabene.cse.unsw.edu.au> <20040311172244.3ae0587f.akpm@osdl.org> <16465.20264.563965.518274@notabene.cse.unsw.edu.au> <20040311235009.212d69f2.akpm@osdl.org> <16466.57738.590102.717396@notabene.cse.unsw.edu.au> <16469.2797.130561.885788@notabene.cse.unsw.edu.au> <20040315091843.GA21587@elte.hu> <16470.22982.831048.924954@notabene.cse.unsw.edu.au> <20040315205201.7699e1c1.akpm@osdl.org> <Pine.LNX.4.58.0404040437190.16677@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404040437190.16677@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Andrew Morton wrote:
>> Calling page_address_init() earlier isn't the fix though - pmd pages aren't
>> in highmem so we should never have got that far.  Looks like the pgd or the
>> pmd page contains garbage.  Did you try it without CONFIG_DEBUG_SLAB?
>> Nick was seeing slab 0x6b patterns on the NUMAQ, inside the pmd, so there's
>> some consistency there.  We do have one early setup fix from Manfred, but
>> it's unlikely to cure this.
>> I'll have a play with your .config, see if I can reproduce it.  If not I'll
>> squeeze off -mm3 and would ask you to retest on that if poss.

On Sun, Apr 04, 2004 at 05:07:36AM -0400, Zwane Mwaikambo wrote:
> I spent a bit of time on this today, and the problem appears to be
> that we haven't done mem_map or zone initialisation, so
> mem_map[pfn]->flags is also wrong (e.g. PG_highmem tests). This is
> still triple faulting on 2.6.5-rc3-mm4 on my boxes. CONFIG_HIGHMEM
> and any setup without 4MB pages should do it. The following patch got
> an approving nod from Bill.

A nicer fix, though with potentially too high a "cleanup factor", would
be a pte_bootmem_alloc_map() or some such equivalent of pte_alloc_map().


-- wli

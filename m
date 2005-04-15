Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVDOR6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVDOR6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVDOR6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:58:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29516 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261541AbVDOR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:58:19 -0400
Date: Fri, 15 Apr 2005 18:58:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Jones <davej@redhat.com>
cc: Chris Wright <chrisw@osdl.org>, Andi Kleen <ak@suse.de>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
In-Reply-To: <20050415172816.GU493@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
References: <20050331104117.GD1623@wotan.suse.de> 
    <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> 
    <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> 
    <20050414170117.GD22573@wotan.suse.de> 
    <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> 
    <20050414181015.GH22573@wotan.suse.de> 
    <20050414181133.GA18221@wotan.suse.de> 
    <20050414182712.GG493@shell0.pdx.osdl.net> 
    <20050415172408.GB8511@wotan.suse.de> 
    <20050415172816.GU493@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > On Thu, Apr 14, 2005 at 11:27:12AM -0700, Chris Wright wrote:
> > > Yes, I've seen it in .11 and earlier kernels.  Happen to have same
> > > "x86_64" string on my bad pmd dumps, but can't reproduce it at all.
> > > So, for now, I can hold off on adding the reload cr3 patch to -stable
> > > unless you think it should be there anyway.
> > 
> > It is a bug fix (actually there is another related patch that fixes
> > a similar bug), but we lived with the problems for years so I guess
> > they can wait for .12. 
> 
> Sounds good.

I must confess, with all due respect to Andi, that I don't understand his
dismissal of the possibility that load_cr3 in leave_mm might be the fix
(to create_elf_tables writing user stack data into the pmd).

My belief is that leaving any opening for unpredictable speculations to
pull stale translations into the TLB, is a recipe for strange trouble
down the line when those translations may get used in actuality.

I'd been hoping Andi would come to see it my way overnight!
since I'm clearly not up to arguing the case persuasively.

But I certainly don't expect Chris to add an unjustified patch to -stable.

> > If there was a fix for the bad pmd problem it might be a candidate
> > for stable, but so far we dont know what causes it yet.
> 
> If I figure a way to trigger here, I'll report back.

Dave, earlier on you were quite able to reproduce the problem on 2.6.11,
finding it happened the first time you ran X.  Do you have any time to
reverify that, then try to reproduce with the load_cr3 in leave_mm patch?

But please don't waste your time on this unless you think it's plausible.

Thanks,
Hugh

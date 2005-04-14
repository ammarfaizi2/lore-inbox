Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVDNRBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVDNRBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDNRBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:01:36 -0400
Received: from mail.suse.de ([195.135.220.2]:23730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261550AbVDNRBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:01:22 -0400
Date: Thu, 14 Apr 2005 19:01:17 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050414170117.GD22573@wotan.suse.de>
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks very much as if the mm being created has for pmd a page
> which was used for user stack in the outgoing mm; but somehow exec's
> exit_mmap TLB flushing hasn't taken effect.  I only now noticed this
> patch where you fix just such an issue.

Thanks for the analysis. However I doubt the load_cr3 patch can fix
it. All it does is to stop the CPU from prefetching mappings (which
can cause different problem). But the Linux code who does bad pmd checks
never looks at CR3 anyways, it always uses the current->mm. If
bad pmd sees a bad page it must be still in the page tables of the MM,
not a stable TLB entry.

It must be something else. Somehow we get a freed page into
the page table hierarchy. After the initial 4level implementation
I did not do many changes there, my suspection would be rather
on the recent memory.c changes.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVCOHTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVCOHTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 02:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVCOHTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 02:19:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:8096 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262317AbVCOHTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 02:19:21 -0500
Subject: Re: bad pgd/pmd in latest BK on ia64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: tony.luck@intel.com, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, hugh@veritas.com
In-Reply-To: <20050314153156.159d4bb3.davem@davemloft.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
	 <20050314143442.2ab086c9.davem@davemloft.net>
	 <20050314151142.716903cb.davem@davemloft.net>
	 <20050314153156.159d4bb3.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 18:17:27 +1100
Message-Id: <1110871047.29138.92.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 15:31 -0800, David S. Miller wrote:
> On Mon, 14 Mar 2005 15:11:42 -0800
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > I therefore suspect the pgwalk patches.
> 
> I just noticed something else while reviewing this stuff.
> The PTRS_PER_PMD macros aren't used anymore, so my hacks
> to get 32-bit process VM operations optimized on sparc64
> aren't even being used any more, ho hum... :-)  There are
> better ways to do this.
> 
> (For the interested, see {REAL_}PTRS_PER_PMD in
>  include/asm-sparc64/pgtable.h)
> 
> Come to think of it, this may be related somehow to whatever
> is causing the problems.

That reminds me ... I still itend to toy with your old patches and add
some more abstract walkers & bitmap stuffs. Just no time at the moment. 

The main thing I want to change from your approach is instead of calling
a pte_work callback for every pte, call it for ranges of PTEs (that is
PTE pages most of the time). The goal here is to avoid the overhead of
the indirect function call (& additional stackframe junk etc...) on
every single PTE.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUGBEWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUGBEWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUGBEWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:22:08 -0400
Received: from holomorphy.com ([207.189.100.168]:36027 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266474AbUGBEWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:22:06 -0400
Date: Thu, 1 Jul 2004 21:21:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-ID: <20040702042153.GJ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <40E43BDE.85C5D670@tv-sign.ru> <20040702012012.GC5937@zax> <20040702024422.GG21066@holomorphy.com> <20040702034937.GE5937@zax> <20040702041215.GG5937@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702041215.GG5937@zax>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 01:49:37PM +1000, David Gibson wrote:
>> Duh, sorry, misread the sense of the VM_SHARED test in the zeromap
>> code.

On Fri, Jul 02, 2004 at 02:12:15PM +1000, David Gibson wrote:
> On second thoughts, though, I think logically it should be fixed in
> both places.  For now forcing VM_SHARED in the hugetlbfs code is
> sufficient, but if we ever allow (real) MAP_PRIVATE hugepage mappings
> (by implementing hugepage COW, for example), then the zeromap code
> will need fixing.
> Conceptually it's not so much the fact that the hugepage memory is
> shared which is tripping up zeromap as the fact that it isn't mapped
> in the normal way.
> Of course, one could argue that the whole zeromap idea is just too
> damn clever for its own good...

Better that there should be a zeromap_hugepage_range() than pollution
of random pseudodrivers.


-- wli

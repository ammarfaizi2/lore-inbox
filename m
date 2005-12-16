Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVLPVFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVLPVFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVLPVFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:05:47 -0500
Received: from gold.veritas.com ([143.127.12.110]:57123 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751117AbVLPVFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:05:47 -0500
Date: Fri, 16 Dec 2005 21:05:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pte_alloc_kernel parameters
In-Reply-To: <43A19190.76F0.0078.0@novell.com>
Message-ID: <Pine.LNX.4.61.0512162057190.8996@goblin.wat.veritas.com>
References: <43A19190.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Dec 2005 21:05:43.0044 (UTC) FILETIME=[79E22440:01C60284]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Jan Beulich wrote:
> Is there any particular reason why pte_alloc_kernel() has to have
> 'struct mm_struct*' as its first parameter? Except for a case in parisc
> (where NULL gets passed) and another (ill-looking one) in arm26 it is
> always &init_mm, and since the function is not inline the compiler can't
> eliminate the needless passing of the argument.

You're looking at old source: it's gone in 2.6.15-rc.  There was a point
to it before 2.6.13 - arch/ppc64 used it on its ioremap_mm too, but has
since amalgamated that into init_mm.  I removed the arg in 2.6.15-rc,
not really as an optimization, more to force a build error on mismatch
when making a change to the locking there.

Hugh

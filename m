Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWEKJvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWEKJvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEKJvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 05:51:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:46273 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030208AbWEKJvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 05:51:38 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 11 May 2006 19:51:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17507.2326.70030.243757@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH-RFC] Improve randomness of hash_long on 64bit.
In-Reply-To: message from Andrew Morton on Thursday May 11
References: <20060509165610.10378.patches@notabene>
	<1060509065940.10406@suse.de>
	<20060511003556.5ba2e3d2.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 11, akpm@osdl.org wrote:
> 
> We end up with
> 
> static inline u32 hash_u32(u32 val, unsigned int bits)
> {
> 	u32 hash = val;
> 
> 	/* On some cpus multiply is faster, on others gcc will do shifts */
> 	hash *= GOLDEN_RATIO_PRIME_32;
> 
> 	/* High bits are more random, so use them. */
> 	return hash >> (32 - bits);
> }
> 
> static inline u32 hash_u64(u64 val, unsigned int bits)
> {
> 	u32 hi = val >> 32;
> 	return hash_u32(hash_u32(val, 32) ^ hi, bits);
> }
> 
> So if one does
> 
> 	hash_u64(foo, 44)
> 
> we have a negative shift distance.

True.  But as hash_u64 returns a u32, asking for 44 bits would be
clearly unwise.  It really no different than doing

        hash_long(foo, 100)

Based on the return type, that is equally unwise.

Fortunately no one (current) askes for more than 14 bits.

Thanks,
NeilBrown

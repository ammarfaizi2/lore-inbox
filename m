Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRHVJVF>; Wed, 22 Aug 2001 05:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271972AbRHVJUz>; Wed, 22 Aug 2001 05:20:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24707 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271971AbRHVJUt>;
	Wed, 22 Aug 2001 05:20:49 -0400
Date: Wed, 22 Aug 2001 05:21:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Kara <jack@suse.cz>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Ext2 quota bug in 2.4.8
In-Reply-To: <20010822104424.D11019@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0108220520110.10119-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Aug 2001, Jan Kara wrote:

>   Hello,
> 
>   Jan Sanislo <oystr@cs.washington.edu> found a bug in ext2 quota code in 2.4.6+.
> During changes in ext2 code in 2.4.6 some DQUOT_INIT()s were removed but they
> shouldn't and as a result quota is not computed right.
>   The patch which adds missing DQUOT_INIT()s is below. I didn't place DQUOT_INIT()s to
> original places but rather to generic vfs parts which seems better to me.
>   Please apply - patch is against 2.4.8.

Wrong place - DQUOT_INIT should be in iput(), just before the call of
->delete_inode()


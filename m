Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVC3RQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVC3RQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVC3RQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:16:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:3353 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262356AbVC3RQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:16:01 -0500
Date: Wed, 30 Mar 2005 18:15:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <20050330150813.GF28472@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0503301804240.21508@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> 
    <20050324122637.GK895@wotan.suse.de> 
    <Pine.LNX.4.61.0503292233080.18131@goblin.wat.veritas.com> 
    <20050330150813.GF28472@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Andi Kleen wrote:
> 
> Ok. I will defer the bitvector patch now. 
> 
> I had it mostly working with hacks, but than I ran into
> a nasty include ordering problem that scared me off so far.

Hah, you too!  I knew Ben and Nick had designs in that kind
of direction, and meant to leave the field clear for them; but
once the vma idea struck me, it seemed silly not to pursue it.

> Ok. I will change it to a VMA.

Thanks.  (It's only the 32-bit emulation case I'm caring about,
that poses a problem for free_pgtables: I'm not sure whether you're
meaning to VMA-ize the 64-bit one too, that's entirely up to you.)

> Only bad thing is that this has to be done at program startup.
> At fault time we cannot upgrade the read lock on mmap sem to a write
> lock that is needed to insert the VMA :/ But I guess that is ok
> because with modern glibc basically all programs will use vsyscsall.

Sorry for bumping you into this, but I think it's the right approach.
ARM can justify its special FIRST_USER_ADDRESS treatment because (as
I understaned it) the low vectors just have to be set up earlier and
cleared later, but your case is at a higher level.

Hugh

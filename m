Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbULYWDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbULYWDh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbULYWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 17:03:37 -0500
Received: from [213.85.13.118] ([213.85.13.118]:18563 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261575AbULYWDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 17:03:35 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
	<20041220125443.091a911b.akpm@osdl.org>
	<Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
	<20041224160136.GG4459@dualathlon.random>
	<Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com>
	<20041224164024.GK4459@dualathlon.random>
	<Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com>
	<20041225020707.GQ13747@dualathlon.random>
	<Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
	<20041225190710.GZ771@holomorphy.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Sun, 26 Dec 2004 01:03:14 +0300
In-Reply-To: <20041225190710.GZ771@holomorphy.com> (William Lee Irwin, III's
 message of "Sat, 25 Dec 2004 11:07:10 -0800")
Message-ID: <m1652q2fz1.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Sat, 25 Dec 2004, Andrea Arcangeli wrote:
>>> the first place? If that happens it means you're under a lowmem
>>> shortage, something you apparently ruled out when you said
>>> lowmem_reserve couldn't help your workload.
>
> On Sat, Dec 25, 2004 at 12:59:10PM -0500, Rik van Riel wrote:
>> Let me explain a 3rd time:
> [...]
>> If you have any more questions as to why the bug happens, don't
>> hesitate to ask and I'll explain you why this problem happens.
>
> This is an old and well-known problem.
>
> Lifting the artificial lowmem restrictions on blockdev mappings
> (thereby nuking mapping->gfp_mask altogether) would resolve a number of
> problems, not that anything making that much sense could ever happen.

mapping->gfp_mask is used for other things beyond specifying a
zonelist. For example, file systems want all allocations inside a
transaction to be done with GFP_NOFS, which forces GFP_NOFS in
mapping->gfp_mask of meta-data address_spaces.

>
>
> -- wli

Nikita.

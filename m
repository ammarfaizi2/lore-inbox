Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUIMNZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUIMNZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIMNZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:25:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57580 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266704AbUIMNZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:25:53 -0400
Date: Mon, 13 Sep 2004 15:25:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Hugh Dickins <hugh@veritas.com>
cc: Alex Zarochentsev <zam@namesys.com>, Paul Jackson <pj@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined   
 atomic_sub_and_test
In-Reply-To: <Pine.LNX.4.44.0409131327350.17673-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409131522090.981@scrub.home>
References: <Pine.LNX.4.44.0409131327350.17673-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Sep 2004, Hugh Dickins wrote:

> But Bill already said he doesn't want it, [...]
> 
> -		if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
> +		if (atomic_sub_return(bio->bi_vcnt, &fq->nr_submitted) == 0)

And that is more portable how? atomic_sub_and_test() allows some archs to 
generate better code and the rest can still fall back to 
atomic_sub_return. (Maybe it's time for <linux/atomic.h>/ 
<asm-generic/atomic.h>?)

bye, Roman

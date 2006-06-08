Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWFHHNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWFHHNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFHHNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:13:16 -0400
Received: from mail.suse.de ([195.135.220.2]:40934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751228AbWFHHNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:13:15 -0400
From: Andi Kleen <ak@suse.de>
To: bidulock@openss7.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Date: Thu, 8 Jun 2006 09:07:26 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080851.20232.ak@suse.de> <20060608010004.A12202@openss7.org>
In-Reply-To: <20060608010004.A12202@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080907.26350.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 09:00, Brian F. G. Bidulock wrote:

> > Originally because it made assembly too unreadable. Later it was discovered
> > it produces smaller code too.
> > 
> 
> Thank you for the explanation.  But, this brings to mind two other questions:
> 
>   Does the option not also make assembly less readable on other architectures?

Yes it does. Maybe the people who spend a lot of time debugging these
don't feel the pain anymore.

> 
>   If one is interested in smaller code, why not use -Os?

We already use -Os if you set the right config (but this change was actually 
long before that)

It's possible that -Os includes -fno-block-reordering though.

> Also, does -fno-reorder-blocks actually defeat __builtin_expect()?
> (GCC documentation doesn't really say that.)

AFAIK gcc mostly uses the probability information for block reordering
to make the fast path fall through without jumps.

There are some more uses, but they don't impact the code very much.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSHBUTZ>; Fri, 2 Aug 2002 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSHBUTZ>; Fri, 2 Aug 2002 16:19:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316842AbSHBUTZ>;
	Fri, 2 Aug 2002 16:19:25 -0400
Message-ID: <3D4AE995.DFD862EF@zip.com.au>
Date: Fri, 02 Aug 2002 13:20:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> This patch eliminates about 35% of the raw rmap setup/teardown overhead by
> adopting a new locking interface that allows the add_rmaps to be batched in
> copy_page_range.

Well that's fairly straightforward, thanks.  Butt-ugly though ;)

Don't bother doing teardown yet.  I have patches which batch
all the zap_page_range activity into 16-page chunks, so we
eventually end up in a single function with 16 virtually-contiguous
pages to release.  Adding the batched locking to that will
be simple.

Sigh.  I have a test which sends the 2.5.30 VM into a five-minute
coma and which immediately panics latest -ac with pte_chain oom.
Remind me again why all this is worth it?

I'll port your stuff to 2.5 over the weekend, let you know...

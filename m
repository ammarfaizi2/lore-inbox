Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSLDRkC>; Wed, 4 Dec 2002 12:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSLDRkC>; Wed, 4 Dec 2002 12:40:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:27622 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266971AbSLDRkB>;
	Wed, 4 Dec 2002 12:40:01 -0500
Message-ID: <3DEE3FAE.558649F5@digeo.com>
Date: Wed, 04 Dec 2002 09:47:26 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erich Focht <efocht@ess.nec.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: per cpu time statistics
References: <200212041343.39734.efocht@ess.nec.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 17:47:26.0680 (UTC) FILETIME=[35660D80:01C29BBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> 
> Andrew, Bill,
> 
> I had to learn from Michael Hohnbaum that you've eliminated the per
> CPU time statistics in 2.5.50 (akpm changeset from Nov. 26). Reading
> the cset comments I understood that the motivation was to save
> 8*NR_CPUS bytes of memory in the task_struct. Maybe that was really an
> issue at the time when Bill suggested the patch (July), but in the
> mean time we got configurable NR_CPUS (October) and that small amount
> of additional memory really doesn't matter. Most people running SMP
> have 2 CPUs.

It's mainly the big ia32 boxes which a) have a lot of CPUs and
b) have a lot of memory and c) run a lot of tasks.  They're
gasping for normal-zone memory.

I'm half-inclined to just revert the whole thing and put the stats
back, rather than adding yet another obscure config option.  But
your patch is certainly very tidy...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVBXW2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVBXW2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVBXW1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:27:49 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:23476 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262518AbVBXW12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:27:28 -0500
Message-ID: <421E54D3.8060903@sgi.com>
Date: Thu, 24 Feb 2005 14:27:31 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, erikj@subway.americas.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <20050222232002.4d934465.akpm@osdl.org> <Pine.LNX.4.53.0502231041450.19035@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0502231041450.19035@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Tue, 22 Feb 2005, Andrew Morton wrote:
> 
> 
>>We really want to avoid doing such stuff in-kernel if at all possible, of
>>course.
>>
>>Is it not possible to implement the fork/exec/exit notifications to
>>userspace so that a daemon can track the process relationships and perform
>>aggregation based upon individual tasks' accounting?  That's what one of
>>the accounting systems is proposing doing, I believe.
>>
>>(In fact, why do we even need the notifications?  /bin/ps can work this
>>stuff out).
> 
> 
> 
> I had started a proof of concept implementation that could reconstruct the 
> whole process tree from userspace just from the BSD accounting currently 
> in the kernel (+ the conceptual bug-fix that I misnamed "[RFC] "biological 
> parent" pid"). This could do the whole job ID thing from userspace.
> Unfortunately, I haven't had time to work on it recently.
> 
> Also, doing per-job accounting might actually be more lightweight than 
> per-process accounting, so I'm not at all opposed to unifying CSA and BSD 
> accounting into one mechanism that just writes different file formats.

Thanks, Tim!

After spending some time studying how ELSA works, it appeared to me
that CSA still needs a hook for do_exit. Since people agreed that
a complete framework was an overkill, i would be glad to submit
another patch later just to provide a CSA exit-handling inside the
acct_process().

Thanks,
  - jay

> 
> A complete framework seems like overkill to me, too.
> 
> Tim
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267569AbUGWH2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267569AbUGWH2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267570AbUGWH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:28:36 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:51330 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267569AbUGWH2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:28:35 -0400
Message-ID: <4100BE1F.7050207@yahoo.com.au>
Date: Fri, 23 Jul 2004 17:28:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au> <20040723054735.GA14108@elte.hu> <4100B403.6080402@yahoo.com.au> <20040723065504.GA15118@elte.hu> <4100BA0E.3080204@yahoo.com.au> <20040723072127.GA15565@elte.hu>
In-Reply-To: <20040723072127.GA15565@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>You wouldn't need to do this to break out of interrupt context
>>softirqs because you wouldn't bother returning to it. Just hand the
>>work off to ksoftirqd.
> 
> 
> this is plainly not the case. Look at eg. the net_tx_action() lock-break
> i did in the -I1 patch. There we first create a private queue which we
> work down. With my approach we can freely reschedule _within the loop_.
> With your suggestion this is not possible.
> 

Sorry I missed that. Yeah if you are seeing high latencies *within*
a single softirq then my thing obviously wouldn't work.

If they're as high as a couple of ms on your 2GHz machine, then they
definitely shouldn't be processed in the interrupt path, so yeah
doing them in process context is the best thing to do.

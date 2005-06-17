Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVFQOMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVFQOMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVFQOMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:12:35 -0400
Received: from mxsf41.cluster1.charter.net ([209.225.28.173]:36492 "EHLO
	mxsf41.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261982AbVFQOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:12:28 -0400
X-IronPort-AV: i="3.93,208,1115006400"; 
   d="scan'208"; a="1186939860:sNHT16101000"
Message-ID: <42B2DA49.30806@cybsft.com>
Date: Fri, 17 Jun 2005 09:12:25 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <42B1BDF7.1000700@cybsft.com> <20050616204358.GA4656@elte.hu> <20050617111822.GA28236@elte.hu>
In-Reply-To: <20050617111822.GA28236@elte.hu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>>There doesn't seem to be any actual lockups, just messages. I will try 
>>>disabling the above when I get home this evening. Can't get to the 
>>>system right now.
>>
>>i tweaked the softlockup detector in the last patch a bit (to fix 
>>false positives under very high loads), might have broken it on SMP.
> 
> 
> yeah - found a bug that could explain the symptoms on your system.  
> Called softlockup_tick() from the global timer interrupt, instead of the 
> per-CPU timer interrupt. So on SMP the other CPUs would not see any 
> softlockup ticks at all, and would incorrectly report soft lockups.  
> This bug is fixed in the -48-36 patch i just uploaded.
> 
> 	Ingo
> 
Yes I noticed the softlockup_tick() in some stack traces that I
generated with -48-35 last night. Just downloaded and starting to
compile -48-36. Will report back the results. Also will turn of the
CONFIG_DEBUG_RT_LOCKING_MODE mentioned in your previous mail.

thanks.

-- 
   kr

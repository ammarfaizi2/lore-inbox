Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUJYMpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUJYMpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUJYMpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:45:24 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:50860 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261779AbUJYMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:44:01 -0400
Message-ID: <417CF50A.6080702@yahoo.com.au>
Date: Mon, 25 Oct 2004 22:43:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Sami Farin <7atbggg02@sneakemail.com>
CC: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Linux 2.6.9 latencies: scheduler bug?
References: <20041024212618.GA19377@m.safari.iki.fi> <20041025120021.GA9917@m.safari.iki.fi>
In-Reply-To: <20041025120021.GA9917@m.safari.iki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami Farin wrote:
> On Mon, Oct 25, 2004 at 12:26:18AM +0300, Sami Farin wrote:
> ...
> 
>>while that's running, "rtc_latencytest 1024" has max latencies of 253ms.
>>$BLOCKLIST has around two thousand lines.
>>http://safari.iki.fi/ip_tables_original_maxlat_253ms.png
>>from pressing sysrq+p while it was running, I guesstimated one evil spot
>>and added cond_resched() in there :)
>>http://safari.iki.fi/ip_tables_cond_resched.png
>>at 5s I started the script.
> 
> 
> forget this stupid ip_tables.c patch, latencies have nothing to do with
> netfilter code, but bad interaction between xmms, rtc_latencytest
> and iptables.  I now get at max 3.1s (yup, 3100000us) latencies.
> http://safari.iki.fi/2.6.9-xmms-fun-1.png
> if you want to reproduce this:
> 1) run "rtc_latencytest 1024" (can't reproduce with "rtc_latencytest 512")
> 2) press play in xmms
> 3) start iptables-script
> 
> xmms has to be prepared first.
> a) put it in repeat mode
> b) start playing >= 2 files (like that short testcase.mp3 from lame)
> c) remove the files while xmms is playing
> d) wait till xmms has played all of the selected files
> e) press stop [now then you press play in 2), xmms does silly infinite
>    loop without delays while trying to open the songs]
> 
> please give me patches to try, 3.1s is really evil 8-)
> 

Don't think I've tried rtc_latency test. A quick search didn't turn
up its source code...

So... stupid question, is rtc_latencytest running with a realtime
scheduling policy?

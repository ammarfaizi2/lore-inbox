Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267827AbUH3MZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267827AbUH3MZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUH3MZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:25:56 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:41221 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S267827AbUH3MZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:25:49 -0400
Message-ID: <41331CC6.6090206@fr.thalesgroup.com>
Date: Mon, 30 Aug 2004 14:25:42 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: voluntary-preempt-2.6.8.1-P9 : big latency when logging on console
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net> <20040828121413.GB17908@elte.hu> <4132F302.7030706@fr.thalesgroup.com> <20040830094124.GA26445@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * P.O. Gaillard <pierre-olivier.gaillard@fr.thalesgroup.com> wrote:
> 
> 
>>Hello,
>>
>>I have a 1.6ms latency every time I log in with P9.
> 
> 
> could you try the patch below, ontop of P9? (or ontop of the latest, -Q5
> patch)
> 
> The problem with font loading is that vt_ioctl runs with the BKL held
> (as all ioctls) which disables preemption, but in this case it seems
> pretty safe to drop the lock - the vga console has its own spinlock.
> 
Thank you very much. I had to add a "#include <linux/smp_lock.h>" at the start 
of vga_con.c to get it to compile and then :
1) I can login on the console without getting any latency above 100 microseconds.
2) Nothing seems to be broken by your change.

Note: I tested on 2.6.8.1 + P9.

	thanks !

	Pierre-Olivier



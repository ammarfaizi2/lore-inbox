Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVHWXa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVHWXa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHWXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:30:28 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:55959 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1750904AbVHWXa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:30:27 -0400
Message-ID: <430BB16E.8030808@candelatech.com>
Date: Tue, 23 Aug 2005 16:29:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: danial_thom@yahoo.com, Sven-Thorsten Dietrich <sven@mvista.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050823201004.77101.qmail@web33310.mail.mud.yahoo.com> <430B89BE.1020600@trash.net>
In-Reply-To: <430B89BE.1020600@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Danial Thom wrote:
> 
>>None of this is helpful, but since no one has
>>been able to tell me how to tune it to provide
>>absolute priority to the network stack I'll
>>assume it can't be done.
> 
> 
> The network stack already has priority over user processes,
> except when executed in process context, so preemption has
> no direct impact on briding or routing performance.

Well, NAPI puts a lot more of the packet processing in
process context, including the code that would do routing
I believe.

To give networking more priority, you can re-nice the ksoftirqd
process(es) to a high-priority level like -18 or so.

You can also reserve more memory for the networking stack
and increase the size of the permitted buffers.

I am also interested to hear how your system responds to compiling
w/out PREEMPT.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


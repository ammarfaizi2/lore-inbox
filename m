Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVCJTQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVCJTQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbVCJTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:13:08 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:2474 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262838AbVCJTDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:03:55 -0500
Message-ID: <42309A0A.4080004@candelatech.com>
Date: Thu, 10 Mar 2005 11:03:38 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	<422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com>	<422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au>	<422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au>	<422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com>	<422F8A8A.8010606@candelatech.com> <422F8C58.4000809@rapidforum.com>	<422F9259.2010003@candelatech.com> <422F93CE.3060403@rapidforum.com>	<20050309211730.24b4fc93.akpm@osdl.org> <m1is3zvprz.fsf@muc.de>
In-Reply-To: <m1is3zvprz.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> If he had a lot of RX traffic (it is hard to figure out because his
> bug reports are more or less useless and mostly consists of rants):
> The packets are allocated with GFP_ATOMIC and a lot of traffic
> overwhelms the free memory.
> 
> Some drivers work around this by doing the RX ring refill in process
> context (easier with NAPI), but not all do.

I think his traffic is mostly 'send' from his server's perspective.

He's reading from disk with sendfile too, I believe, so maybe that
would be consuming lots of pages of memory?

However, in my case, I would definately welcome something that auto-tuned
the VM to give me lots and lots of GFP_ATOMIC pages.  As it is now, I
end up setting the /proc/sys/vm/freepages much higher.  Since it appears
the name has changed and I didn't notice, I guess my script to set
this has not actually been doing anything useful in the 2.6 kernel series :P

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


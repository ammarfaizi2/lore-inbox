Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268705AbUHLUCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268705AbUHLUCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUHLUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:02:35 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:8940 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S268705AbUHLUCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:02:32 -0400
Message-ID: <411BCCC7.2090804@candelatech.com>
Date: Thu, 12 Aug 2004 13:02:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> While doing the network emulator, I discovered that the default net_random()
> is too stupid, and get_random_bytes() is more than needed. Rather than put
> another function in just for sch_netem, how about making net_random() smarter?
> The tin-hat crowd already replace net_random() with get_random_bytes anyway.
> 
> Here is a proposed alternative to use a longer period PRNG for net_random().
> The choice of TT800 was because it was freely available, had a long period,
> was fast and relatively small footprint. The existing net_random() was not
> really thread safe, but was immune to thread corruption. 

Is it really worth the extra spin lock & math?  Maybe we could have a
net_more_random() method instead that encompasses this improved random logic?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


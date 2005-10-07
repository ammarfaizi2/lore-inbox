Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVJGRK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVJGRK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbVJGRK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:10:27 -0400
Received: from mail.collax.com ([213.164.67.137]:10656 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030468AbVJGRK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:10:26 -0400
Message-ID: <4346AB94.4050006@trash.net>
Date: Fri, 07 Oct 2005 19:08:36 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509281037.03185.ak@suse.de> <4342B575.9090709@trash.net> <200510051853.32196.ak@suse.de> <20051007023801.GA5953@rama> <20051006175956.GI6642@verdi.suse.de>
In-Reply-To: <20051006175956.GI6642@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Oct 07, 2005 at 04:38:02AM +0200, Harald Welte wrote:
> 
>>On Wed, Oct 05, 2005 at 06:53:31PM +0200, Andi Kleen wrote:
>>
>>>Well you most likely wrecked local performance then when it's enabled.

There are lots of other hooks and conntrack/NAT already have a
quite large negative influence on performance. Do you have numbers
that show that enabling this actually causes more than a slight
decrease in performance? Besides, most distributors enable all
these options anyway, so it only makes a difference for a small
group of users.

>>so you would favour a system that incorrectly deals with ICMP errors but
>>has higher performance?
> 
> I would favour a system where development doesn't lose sight of performance.

I don't think we do.

> Perhaps there would be other ways to fix this problem without impacting
> performance unduly? Can you describe it in detail? 

When an ICMP error is send by the firewall itself, the inner
packet needs to be restored to its original state. That means
both DNAT and SNAT which might have been applied need to be
reversed. DNAT is reversed at places where we usually do
SNAT (POST_ROUTING), SNAT is reversed where usually DNAT is
done (PRE_ROUTING/LOCAL_OUT). Since locally generated packets
never go through PRE_ROUTING, it is done in LOCAL_OUT, which
required enabling NAT in LOCAL_OUT unconditionally. It might
be possible to move this to some different hook, I didn't
investigate it.

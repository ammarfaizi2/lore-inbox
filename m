Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVBYAWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVBYAWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVBYAUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:20:14 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:47338 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262617AbVBYAQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:16:35 -0500
Message-ID: <421E6E61.3040005@candelatech.com>
Date: Thu, 24 Feb 2005 16:16:33 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tulip (DFE-570tx) & keyboard lockup in 2.6.9 and other 2.6 kernels.
References: <421CF0BA.1020100@candelatech.com>
In-Reply-To: <421CF0BA.1020100@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> I finally had some time to debug this one a little more
> thoroughly.  On two different machines (Shuttle SB61G1) I
> get the same results, so I do not believe it is bad hardware...
> 
> The bug is as follows:
> 
> I have 1 4-port tulip NIC in the machine.  If I generate traffic
> between two interfaces, it runs fine.  But, if I start running traffic
> on all 4 interfaces, the keyboard quits taking input, and ethernet
> traffic stops on at least a few of the interfaces.  I can still ssh
> into the machine (via the rtl8139 interface), so at least one of the
> processors (I'm using SMP on an P4 HT processor) is working.  I also
> enabled NMI and that does not trigger.

This was my bug.  I was holding a lock that was required for receiving a packet
while calling the hard_start_xmit method.  When an IRQ happened while I was in
the hard_start_xmit method, the IRQ could not grab the lock, and just sat there
spinning...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWJVXxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWJVXxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWJVXxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:53:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42893 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750885AbWJVXxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:53:33 -0400
Message-ID: <453C0470.6090503@zytor.com>
Date: Sun, 22 Oct 2006 16:53:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
CC: Cristian Grigoriu <cristian.grigoriu@provus.ro>, b.innocenti@develer.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: NAT failure with TCP, too
References: <4538B314.2020309@provus.ro> <453C01AE.7060103@develer.com>
In-Reply-To: <453C01AE.7060103@develer.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> 
> 
> Cristian Grigoriu wrote:
>> Hi,
>>
>> I can confirm the same bug you reported here 
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0509.2/0279.html
>> This time it happens with TCP connections originating from the same 
>> TCP port (1234) from multiple machines. The SNAT simply doesn't take 
>> place and the normal routing occurs.
>>
>> Kernel is Debian stock 2.6.18-1.
>>
>> Please let me know if you have find a workaround.
> 
> It turned out that the real thing that was triggering the bug
> for me was unloading and reloading the ip_nat module without
> also reloading ip_conntrack.
> 
> The connection tracking tuple would remain in the kernel, visible
> in /proc/net/ip_conntrack, but no longer linked to the SNAT rule.
> I'd consider this a bug, but very few users will ever be affected.
> 
> The workaround for me was to remove my hand-cracted iptables
> rules from ppp's ip-up.local and move them to the distro-supplied
> iptables firewall instead.  The only downside is that I must now
> hardcode the destination ip of the SNAT rule because it's too early
> to read the interface address of ppp0.
> 

You may want to use the MASQUERADE target instead of the SNAT target.

	-hpa


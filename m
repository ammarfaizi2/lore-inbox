Return-Path: <linux-kernel-owner+w=401wt.eu-S1751253AbXAILuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXAILuP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXAILuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:50:15 -0500
Received: from stinky.trash.net ([213.144.137.162]:41713 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbXAILuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:50:14 -0500
Message-ID: <45A38173.9090305@trash.net>
Date: Tue, 09 Jan 2007 12:50:11 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Schmidt <berni@birkenwald.de>
CC: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] OOPS with nf_conntrack_ipv6, probably fragmented UDPv6
References: <459D322F.5010707@birkenwald.de> <45A63D72.2060405@trash.net> <45A37F5F.2030501@birkenwald.de>
In-Reply-To: <45A37F5F.2030501@birkenwald.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Schmidt wrote:
> Patrick McHardy wrote:
> 
>>> I've hit another kernel oops with 2.6.20-rc3 on i386 platform. It is
>>> reproducible, as soon as I load nf_conntrack_ipv6 and try to send
>>> something large (scp or so) inside an OpenVPN tunnel on my client
>>> (patched with UDPv6 transport) the router (another box) OOPSes.
>>>
>>> tcpdump suggests the problem appears as soon as my client sends
>>> fragmented UDPv6 packets towards the destination. It does not happen
>>> when nf_conntrack_ipv6 is not loaded. This is the OOPS as dumped from
>>> the serial console:
>>
>> Does this patch help?
> 
> 
> Yes, seems to be working fine.

Thanks, I'll send it upstream tonight.

> Can you tell since when this bug is in the kernel?

The real bug is in nf_conntrack and probably has been there since
the beginning (which I think is about 1.5 years ago). It blows up
in combination with the GSO code, which I believe was added in
2.6.18-rc, but it might have caused troubles somewhere else before.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWINXFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWINXFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWINXFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:05:55 -0400
Received: from rex.snapgear.com ([203.143.235.140]:11722 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S932110AbWINXFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:05:54 -0400
Message-ID: <4509E05A.7010306@snapgear.com>
Date: Fri, 15 Sep 2006 09:06:02 +1000
From: Philip Craig <philipc@snapgear.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
Cc: Joerg Roedel <joro-lkml@zlug.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
References: <20060911204129.GA28929@zlug.org> <4508AE92.1090202@snapgear.com> <20060914095205.GA23405@zlug.org> <45092ADB.9060808@trash.net>
In-Reply-To: <45092ADB.9060808@trash.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Joerg Roedel wrote:
>> On Thu, Sep 14, 2006 at 11:21:22AM +1000, Philip Craig wrote:
>>
>>> Joerg Roedel wrote:
>>>
>>>> +	 To configure tunnels an extra tool is required. You can download
>>>> +	 it from http://zlug.fh-zwickau.de/~joro/projects/ under the
>>>> +	 EtherIP section. If unsure, say N.
>>> To obtain a list of tunnels, this tool calls SIOCGETTUNNEL
>>> (SIOCDEVPRIVATE + 0) for every device in /proc/net/dev. I don't think
>>> this is safe, but I don't have a solution for you.
>>
>> You are right. But this is the way the ipip driver does it. In the case
>> of ipip it is safe, because it is visible as a tunnel interface to
>> userspace. But my driver registers its devices as Ethernet (it has to,
>> otherwise the devices will not be usable in a bridge). There is no safe
>> way to distinguish between real Ethernet devices and devices registered
>> by my driver. I think about implementing an ioctl to fetch a list of
>> all EtherIP tunnel devices from the driver.
> 
> 
> Just do what ipip and gre do, use a network device with a fixed name
> for the ioctl (you already have the ethip0 device for this purpose it
> appears).

That fixed name device isn't used to get a list of tunnels. Instead,
ipip and gre read /proc/net/dev, and check for ARPHRD_TUNNEL or
ARPHRD_IPGRE. This won't work for etherip because it uses ARPHRD_ETHER,
which isn't specific to etherip tunnels. A new ioctl to get a list could
be added (this ioctl would use the fixed name device), is that acceptable?

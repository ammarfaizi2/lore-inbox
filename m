Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWINKLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWINKLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWINKLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:11:42 -0400
Received: from stinky.trash.net ([213.144.137.162]:57003 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750741AbWINKLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:11:40 -0400
Message-ID: <45092ADB.9060808@trash.net>
Date: Thu, 14 Sep 2006 12:11:39 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Roedel <joro-lkml@zlug.org>
CC: Philip Craig <philipc@snapgear.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
References: <20060911204129.GA28929@zlug.org> <4508AE92.1090202@snapgear.com> <20060914095205.GA23405@zlug.org>
In-Reply-To: <20060914095205.GA23405@zlug.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel wrote:
> On Thu, Sep 14, 2006 at 11:21:22AM +1000, Philip Craig wrote:
> 
>>Joerg Roedel wrote:
>>
>>>+	 To configure tunnels an extra tool is required. You can download
>>>+	 it from http://zlug.fh-zwickau.de/~joro/projects/ under the
>>>+	 EtherIP section. If unsure, say N.
>>
>>To obtain a list of tunnels, this tool calls SIOCGETTUNNEL
>>(SIOCDEVPRIVATE + 0) for every device in /proc/net/dev. I don't think
>>this is safe, but I don't have a solution for you.
> 
> 
> You are right. But this is the way the ipip driver does it. In the case
> of ipip it is safe, because it is visible as a tunnel interface to
> userspace. But my driver registers its devices as Ethernet (it has to,
> otherwise the devices will not be usable in a bridge). There is no safe
> way to distinguish between real Ethernet devices and devices registered
> by my driver. I think about implementing an ioctl to fetch a list of
> all EtherIP tunnel devices from the driver.


Just do what ipip and gre do, use a network device with a fixed name
for the ioctl (you already have the ethip0 device for this purpose it
appears).

>>Is there a reason why you have a separate tool rather than modifying
>>iproute2?
> 
> 
> I wrote an own tool for testing. At development I wanted to concentrate
> on the driver and not how to modify iproute2. But when the driver
> becomes stable and may be included I will add it to iproute2.


The iproute changes are only a few lines, just add the ethip0 device to
the do_add, do_del, ... commands and set the protocol to IPPROTO_ETHERIP
when an etherip tunnel is requested.


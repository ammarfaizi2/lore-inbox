Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUI1MKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUI1MKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUI1MKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:10:42 -0400
Received: from [195.23.16.24] ([195.23.16.24]:35982 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S267668AbUI1MKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:10:35 -0400
Message-ID: <415954AD.7010905@grupopie.com>
Date: Tue, 28 Sep 2004 13:10:21 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost> <1096306153.1729.2.camel@localhost.localdomain>
In-Reply-To: <1096306153.1729.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> ....
>>+{
>>+	struct net_device *net = to_net_dev(dev);
>>+	if (netif_running(net)) {
>>+		if (netif_carrier_ok(net))
>>+			return snprintf(buf, 3, "%d\n", 1);
>>+		else
>>+			return snprintf(buf, 3, "%d\n", 0);
> 
> 
> Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
> The most concise format of this would be:
> 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));

<nitpick>
Since netif_carrier_ok already has a "!" in it, it is guaranteed to 
return a 0 / 1 result. so this could be:

  	return sprintf(buf, dec_fmt, netif_carrier_ok(dev));

Of course your way is more robust to future 'netif_carrier_ok' changes 
and the compiler should optimize it way anyway since it is an inline 
function, so I actually prefer the !! version :)
</nitpick>

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978

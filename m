Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUHVNLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUHVNLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHVNLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:11:33 -0400
Received: from wasp.net.au ([203.190.192.17]:18356 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266887AbUHVNKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:10:20 -0400
Message-ID: <41289B5E.60703@wasp.net.au>
Date: Sun, 22 Aug 2004 17:10:54 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S266616AbUHVJsa/20040822094830Z+232@vger.kernel.org>
In-Reply-To: <S266616AbUHVJsa/20040822094830Z+232@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> I am still persistent on the fact that NAT should work with this sense.
> 
> I just enable NAT with the following command
> 
> iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to 192.168.1.5
> 
> This IP 192.168.1.5 is our patched linux server which is allowed to acccess
> 192.168.1.77
> 

Ok.. Idea time..
Can you add another linux box in there. Something like

Client (192.168.0.30) ---> Box1Eth0(192.168.0.1) SNAT Box1Eth1(192.168.1.99) ---> 
Box2Eth0(192.168.1.100) () Box2Eth1(192.168.77.99) ---> HorridBuggyBox(192.168.77.1)

With Box 1 doing the NAT and Box 2 having the patch and just doing normal routing.

Have a route in Box 1 set to send 192.168.77.0/24 to the gateway at 192.168.1.100 which will know to 
send anything destined for 192.168.77.1 out eth1.

If I try it, it's going to work fine as I don't have a box that munges IP's like yours does so I 
can't provide a full test. (I guess I could butcher another UML to do it if I really had to)

Doing this stuff is so much easier when you have the faulty device in front of you. Your not in the 
UAE by any chance ;p)

Regards,
Brad

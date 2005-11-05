Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVKEHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVKEHqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVKEHqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:46:03 -0500
Received: from mail.collax.com ([213.164.67.137]:15595 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751371AbVKEHqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:46:01 -0500
Message-ID: <436C34F8.3090903@trash.net>
Date: Sat, 05 Nov 2005 05:28:40 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <436C090D.5020201@trash.net>
In-Reply-To: <436C090D.5020201@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Thomas Graf wrote:
> 
>> broadcast 10.0.0.0  proto kernel  scope link  src 10.0.0.2 local 
>> 10.0.0.2  proto kernel  scope host  src 10.0.0.2 broadcast 10.0.0.255  
>> proto kernel  scope link  src 10.0.0.2
>> Local routes for 10.0.0.3 and 10.0.0.4 have disappeared _without_
>> any notification.
>>
>> I think the correct way to fix this is to prevent the deletion of
>> the local routes, not just readding them. _If_ the deletion of them
>> is intended, which I doubt, then at least notifications must be
>> sent out.
> 
> I agree, the routes should ideally not be deleted at all. The missing
> notifications appear to be a different bug. Let me have another look ..

The reason why all routes are deleted is because their prefered
source addresses is the primary address. fn_flush_list should
probably send the missing notifications for the deleted routes.
Changing address promotion to not delete the other routes at all
looks extremly complicated, I think just fixing it to behave
correctly is good enough (which my patch didn't do entirely,
I'll send a new one this weekend).

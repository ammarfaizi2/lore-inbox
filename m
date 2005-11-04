Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVKDPQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVKDPQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVKDPQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:16:23 -0500
Received: from [85.8.13.51] ([85.8.13.51]:50582 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964902AbVKDPQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:16:22 -0500
Message-ID: <436B7B46.6060205@drzeus.cx>
Date: Fri, 04 Nov 2005 16:16:22 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
References: <436B2819.4090909@drzeus.cx> <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
In-Reply-To: <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 11/4/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>   
>> +
>> +int pnp_start_dev(struct pnp_dev *dev)
>> +{
>> +       if (!pnp_can_write(dev)) {
>> +               pnp_info("Device %s does not supported activation.", dev->dev.bus_id);
>>     
>
> "...does not support...", there is no "ed" at the end.
>
>   

That's just code that's been moved around. But I suppose a speling fix 
could be included in the same patch. :)

>> +               return -EINVAL;
>> +       }
>>     
>
> Hmm, would'nt presence of such device stop suspend process? It will
> cause pnp_bus_resume to fail too. Perhaps returning 0 in this case is
> better.
>
>   

The problem is that this code is also visited from pnp_activate_dev() & 
co where this return value is needed. For pnp_stop_dev() the same check 
(pnp_can_disable()) is performed in the suspend routine to avoid that 
particular problem. For resume my assumption was that a device that 
doesn't support activation will not have a driver attached to it. 
Perhaps this is wrong?

Rgds
Pierre

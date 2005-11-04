Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbVKDPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbVKDPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbVKDPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:52:59 -0500
Received: from [85.8.13.51] ([85.8.13.51]:57238 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751537AbVKDPw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:52:59 -0500
Message-ID: <436B83D9.8@drzeus.cx>
Date: Fri, 04 Nov 2005 16:52:57 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.6a1 (X11/20051022)
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [Fwd: [PATCH] [PNP][RFC] Suspend support for PNP bus.]
References: <436B2819.4090909@drzeus.cx>	 <d120d5000511040649u5b33405an73b5e33fb4ce5cf6@mail.gmail.com>	 <436B7B46.6060205@drzeus.cx> <d120d5000511040727x7d433e08jeb8937cb2e48249a@mail.gmail.com>
In-Reply-To: <d120d5000511040727x7d433e08jeb8937cb2e48249a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 11/4/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>   
>> Dmitry Torokhov wrote:
>>     
>>> Hmm, would'nt presence of such device stop suspend process? It will
>>> cause pnp_bus_resume to fail too. Perhaps returning 0 in this case is
>>> better.
>>>
>>>
>>>       
>> The problem is that this code is also visited from pnp_activate_dev() &
>> co where this return value is needed. For pnp_stop_dev() the same check
>> (pnp_can_disable()) is performed in the suspend routine to avoid that
>> particular problem. For resume my assumption was that a device that
>> doesn't support activation will not have a driver attached to it.
>> Perhaps this is wrong?
>>
>>     
>
> i8042 registers drivers for keyboard and AUX ports to gather
> information whether the ports are present and what IRQ and IO ports
> shoudl be used to access them. And I have seen a few boxes that do not
> alloe [de]activate these devices.
>
>   

But the activation is performed by the PNP layer when the driver is 
matched with a driver. So the driver isn't really responsible for the 
activation. It can prevent activation through 
PNP_DRIVER_RES_DO_NOT_CHANGE though, but that flag is also checked in 
the suspend routines.

Rgds
Pierre

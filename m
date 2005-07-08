Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVGHLkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVGHLkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVGHLkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:40:15 -0400
Received: from alog0367.analogic.com ([208.224.222.143]:57003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262573AbVGHLkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:40:12 -0400
Date: Fri, 8 Jul 2005 07:34:10 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Michael Tokarev <mjt@tls.msk.ru>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast:
 0.0.0.0 on lo?
In-Reply-To: <200507081418.01686.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0507080726450.15557@chaos.analogic.com>
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
 <42CD289B.5080403@tls.msk.ru> <200507081418.01686.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Denis Vlasenko wrote:

>> The problem is, I can't see what is causing this misconfiguration
>> or whatever.  I wasn't able to capture such a packet so far either --
>> it never happened while tcpdump was running.
>
> You may try to add printk("bad boy is: %s\n", current()->comm)),
> or dump_stack(), or something like that in icmp path of IP stack.
> (I am currently tracking an intermittent network problem
> on my home box in similar way).
>
>>  Note the local IP address mentioned is different, I've
>> seen 3 so far, all 3 are local on this box and are on 3
>> different (ethernet) interfaces (but the ICMP always comes
>> from lo).
>
> BTW what tcpdump actually shows?
> --
> vda
>

Please read line 1148 of /usr/src/linux-`uname -r`/net/ipv4/icmp.c.
The error message is in response to a bogus frame. The NETMASK
must match at both ends (a configuration error). If the mask matches,
then you can turn off the messages with 'sysctl', i.e., ....
`echo "1" >/proc/sys/net/icmp_ignore_bogus_error_responses`.
Otherwise, find the interface netmask that's broken and fix it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

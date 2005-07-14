Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbVGNK0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbVGNK0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbVGNK0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:26:50 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:19841
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263001AbVGNK0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:26:00 -0400
Message-ID: <42D63D4A.2050607@prodmail.net>
Date: Thu, 14 Jul 2005 15:54:10 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Vinay Venkataraghavan <raghavanvinay@yahoo.com>, linux-crypto@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com> <42D63AD0.6060609@aitel.hist.no>
In-Reply-To: <42D63AD0.6060609@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think buffer overflow has anything to do with transparent proxy. 
Transparent proxying is just doing some protocol filtering. Still the 
proxy code may have some buffer overflows. The best way is first to try 
avoiding any buffer overflows and take programming precautions. Other 
way is to chroot the services, if running it on a firewall. There are 
various mechanisms which can be used like bounding the memory region it 
self. Stack Randomisation and Canary based approaches can also avoid any 
buffer overflow attacks.
IDS runs on L7, best example is snort. Its not possible for IDS to 
detect these attacks accurately.

rvk

Helge Hafting wrote:

> Vinay Venkataraghavan wrote:
>
>> I know how to implement buffer overflow attacks. But
>> how would an intrusion detection system detect a
>> buffer overflow attack.
>>
> Buffer overflow attacks vary, but have one thing in common.  The
> overflow string is much longer than what's usual for the app/protocol in
> question.  It may also contain illegal characters, but be careful -
> non-english users use plenty of valid non-ascii characters in filenames,
> passwords and so on.
>
> The way to do this is to implement a transparent proxy module for every
> protocol you want to do overflow prevention for.  Collect the strings
> transmitted, pass them on after validating them.  Or reset the
> connection when one gets "too long".  For example, you may want to
> limit POP usernames to whatever the maximum username length is
> on your system.  But make such things configurable, others may
> want longer usernames than you.
>
>> My question is at the layer
>> that the intrusion detection system operates, how will
>> it know that a particular string for exmaple is liable
>> to overflow a vulnerable buffer.
>>
>>
>>
> It can't know of course, but it can suspect that 1000-character
> usernames, passwords or filenames is foul play and reset the
> connection.  Or 10k URL's . . .
>
> Helge Hafting
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> .
>


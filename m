Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVGNMW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVGNMW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVGNMW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:22:59 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:24705
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S261237AbVGNMWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:22:39 -0400
Message-ID: <42D658A9.7050706@prodmail.net>
Date: Thu, 14 Jul 2005 17:50:57 +0530
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
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com> <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net> <42D658A8.4040009@aitel.hist.no>
In-Reply-To: <42D658A8.4040009@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Proxies can be a good way of filtering but it can't avoid buffer 
overflows. It can only increase it. More code more bugs. If it is 
running on a hardware firewall as a service then its more dangerous as 
once it is compramised then IDS signatures also can be deleated :-). No 
use of IDS the right ?
So the best way is either make your code free of buffer overflows or use 
some library which controls the attack during any buffer overflow or use 
Stack Randomisation and Canary based approaches.

rvk

Helge Hafting wrote:

> RVK wrote:
>
>> I don't think buffer overflow has anything to do with transparent
>> proxy. Transparent proxying is just doing some protocol filtering.
>
>
> A transparent proxy is a protocol filter, which is why it is an
> ideal way of detecting protocol-dependent buffer overflow attacks.
>
> The detection code have to be built into the proxy, of course.
>
> Examples:
> A web proxy can check for anomalous long "get" request,
> there have been web servers with buffer overflows when the
> URL was too long.  The proxy can terminate such connections,
> protecting the possibly vulnerable webserver.
>
> An ftp proxy can check for (and remove) anomalous long filenames,
> as well as funnies like "ls */*/*/*/*/*"
>
> Similiar for many other services.  The proxy approach is useful
> because knowledge of the protocol is necessary.  After all,
> it is ok to up/download a huge file via ftp, while a 2M filename
> is suspicious.  Size alone is not enough.
>
>> Still the proxy code may have some buffer overflows.
>
>
> A proxy (or any other attempt at a firewall) may have its own
> holes of course, but avoiding making them isn't that hard.
>
>
>> The best way is first to try avoiding any buffer overflows and take
>> programming precautions.
>
>
> Of course, if you have the source and that source isn't an
> unmaintainable mess.  One or both of those conditions may fail,
> and then the IDS becomes useful.
>
>> Other way is to chroot the services, if running it on a firewall.
>
>
> Provided it is an unixish server . . .
>
>> There are various mechanisms which can be used like bounding the
>> memory region it self. Stack Randomisation and Canary based approaches
>> can also avoid any buffer overflow attacks.
>
>
> These may or may not be available.  You can always stick a proxy
> firewall in front of the server though, no matter what os and
> server apps it runs.
>
> Helge Hafting
> .
>


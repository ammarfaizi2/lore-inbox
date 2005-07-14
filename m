Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVGNM7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVGNM7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 08:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVGNM7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 08:59:17 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:20699 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S261254AbVGNM7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 08:59:15 -0400
Message-ID: <42D6634A.2000801@aitel.hist.no>
Date: Thu, 14 Jul 2005 15:06:18 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rvk@prodmail.net
CC: Vinay Venkataraghavan <raghavanvinay@yahoo.com>, linux-crypto@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com> <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net> <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>
In-Reply-To: <42D658A9.7050706@prodmail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RVK wrote:

> Proxies can be a good way of filtering but it can't avoid buffer 
> overflows. 

Yes they can - did you read and udnerstand my previous post at all?
A proxy _can_ avoid a buffer overflow by noticing the
anomalously large data item and simply refuse to pass
it on to the real server!  The proxy can terminate the tcp
connection and throw away the data.

> It can only increase it. More code more bugs. 

Of course the proxy can be buggy too, but it is easier to
avoid problems there:
1. The server was written to perform a service, perhaps with
    security thrown in later.  (Yes, that's bad design.)
    A firewall proxy is written for security, so buffer overflows
    are usually avoided in the firewall proxy itself.  Because this
    is exactly what the firewall writer is thinking about.
2. The proxy may be much smaller and simpler than the server
    it protects, it is therefore much easier to audit for security
    problems.
3. Fixing the server is indeed best, but not necessarily an option.
    It could be proprietary, or written in a unknown language.

> If it is running on a hardware firewall as a service then its more

"Hardware firewall" ???

> dangerous as once it is compramised then IDS signatures also can be 
> deleated :-). No use of IDS the right ?

A compromised firewall is of no use - sure.  So what? That applies
to any firewall, any IDS, or any server for that matter.

> So the best way is either make your code free of buffer overflows or

Yes, but the server may not be "my code" at all.  Can't you see that
problem?  It may very well be someone elses code.  I may not have the
source, or the source may be useless for a number of reasons,
such as:
1. being written in a language I don't understand
2. Have a licence that forbids change
3. Need compilers/tools I don't have
4. Being such a nasty mess that writing a proxy is much easier
    than fixing the bloated ill-designed server code one
    unfortunately depends on for the time being.

In these cases, I can still protect my server with a proxy firewall,
although I can't fix the server itself.

> use some library which controls the attack during any buffer overflow 
> or use Stack Randomisation and Canary based approaches.

A library that controls any buffer overflow doesn't exist at all.

Stack randomization helps but don't solve all cases, the attacker
simply need code to search for randomly moved parts he need, pad with
a few megabytes of NOPs and things like that.  Of course, a proxy
can easily detect megabytes of NOPs and kill that connection . . .

Helge Hafting

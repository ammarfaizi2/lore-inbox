Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVAOXqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVAOXqx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVAOXqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:46:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:26856 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262367AbVAOXqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:46:50 -0500
Message-ID: <41E9A9A8.5030602@osdl.org>
Date: Sat, 15 Jan 2005 15:39:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: matthias@corelatus.se
CC: Arjan van de Ven <arjan@infradead.org>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
References: <16872.55357.771948.196757@antilipe.corelatus.se>	<20050115013013.1b3af366.akpm@osdl.org>	<20050115093657.GI3474@holomorphy.com>	<1105783125.6300.32.camel@laptopd505.fenrus.org>	<20050115195504.GA10754@taniwha.stupidest.org>	<1105820460.6300.86.camel@laptopd505.fenrus.org> <16873.42607.937915.146208@antilipe.corelatus.se>
In-Reply-To: <16873.42607.937915.146208@antilipe.corelatus.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Lang wrote:
> Chris Wedgewood suggested handling this with a printk, to which Arjan
> van de Ven asked 
> 
>  > but why????
>  > 
>  > if someone wants the stuff rejected in a posix confirm way, he can do
>  > these tests easily in the syscall wrapper he needs anyway for this
>  > function.
> 
> For negative times and oversized usec values, that's easy. But the
> third problem was that setitimer() may silently truncate the time
> value. To deal with that, a wrapper would need to
> 
>   a) know that this silent truncation happens in the first place. 
>      The only way I know of finding that out is to read the kernel
>      source. (the man page doesn't say anything, and POSIX doesn't
>      mention any silent truncation either)
> 
> and
> 
>   b) Know that the particular value the truncation happens at is
>      dependent on HZ (and, presumably, know what HZ is on that
>      particular machine)
>  
> I found it surprising that the timer set by setitimer() could expire
> before the time passed to it---the manpage explicitly promises that
> will never happen. 
> 
> On many (most?) machines, the obvious symptoms of this truncation
> don't start appearing until after 248 days of uptime, so it's not the
> sort of problem which jumps out in testing. A printk() warning would
> have helped me. As would a warning in the manpage, e.g.:
> 
>    | BUGS
>    |
>    | Under Linux, timers will expire before the requested time if the
>    | requested time is larger than MAX_SEC_IN_JIFFIES, which is
>    | defined in include/linux/jiffies.h.
> 
> Where can I send manpage improvements?

aeb wrote on 2004-OCT-31:

Fortunately Michael Kerrisk has accepted to take over.
Send corrections and additions to mtk-manpages@gmx.net .

-- 
~Randy

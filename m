Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbUDEXxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbUDEXxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:53:00 -0400
Received: from pxy5allmi.all.mi.charter.com ([24.247.15.44]:30353 "EHLO
	proxy5-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S263519AbUDEXw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:52:58 -0400
Message-ID: <4071F07E.2040307@quark.didntduck.org>
Date: Mon, 05 Apr 2004 19:49:18 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Drop exported symbols list if !modules
References: <20040405205539.GG6248@waste.org> <1081205099.15272.7.camel@bach> <20040405230723.GK6248@waste.org>
In-Reply-To: <20040405230723.GK6248@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Apr 06, 2004 at 08:45:01AM +1000, Rusty Russell wrote:
> 
>>On Tue, 2004-04-06 at 06:55, Matt Mackall wrote:
>>
>>>Drop ksyms if we've built without module support
>>>
>>>From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
>>>Subject: Re: 2.6.1-rc1-tiny2
>>
>>Other than saving a little compile time, does this actually do anything?
>>
>>I'm not against it, I just don't think I see the point.
> 
> 
> Well it obviously saves memory and image size too; I'm in the process
> of merging bits from my -tiny tree. As bloat has a way of being
> well-distributed across the code base, it's going to take many small
> trimmings to cut it back. Most of the 150 or so patches I've got now
> save between 1 and 8k. Doesn't sound like much, but it adds up.
> 

EXPORT_SYMBOL() is a no-op when modules are disabled:
$ size arch/i386/kernel/i386_ksyms.o
    text    data     bss     dec     hex filename
       0       0       0       0       0 arch/i386/kernel/i386_ksyms.o

Although, what really should be done is to move the exports to the 
appropriate files instead of keeping them lumped together.

--
				Brian Gerst

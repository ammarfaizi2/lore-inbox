Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVA1RW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVA1RW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVA1RWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:22:37 -0500
Received: from [195.23.16.24] ([195.23.16.24]:39399 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261171AbVA1RWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:22:33 -0500
Message-ID: <41FA74CA.2030303@grupopie.com>
Date: Fri, 28 Jan 2005 17:22:18 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org> <41F94B5A.2030301@comcast.net>
In-Reply-To: <41F94B5A.2030301@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> In other words, no :)
> 
> Here's self-exploiting code to discover its own return address offset
> and exploit itself.  It'll lend some insight into how this stuff works.

I really shouldn't feed the trolls, but this must be the most silly 
piece of code I saw on this mailing list in a very long time (and there 
have been some good examples over time).

The stack randomization doesn't prevent some sort of attacks (like 
return into libc, etc.) and given a small randomization it might be 
possible to write an exploit with a long sequence of NOP's and a return 
address somewhere in there (the attacker wouldn't know exactly where, 
but it wouldn't matter anyway). If we are able to write 'N' NOP's then 
we get a 'N'/64k chance that the exploit works.

Your code doesn't show any of this kinds of attacks. It just shows that 
if you're able to run code then.... you're able to run code?

What are you going to show next? That you can steal your own car? Are 
you going to blame the car manufacturer's for that?

As it was already pointed out this is a step into implementing a larger 
randomization, so that things don't break all at once. Even a large 
stack randomization is just another layer of protection, as there are 
still attacks that it doesn't prevent.... Duh.

>[...] 
> 		/*find the distance between a and myret*/
> 		for (i = (void*)a; *(void**)i != myret; i++) {
> 			distance++;
> 		}

And this must be "la piece de resistance". Some very obfuscated (and 
inefficient) way to do a simple unsigned subtraction...

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu


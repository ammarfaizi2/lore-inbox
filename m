Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJPXCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTJPXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:02:55 -0400
Received: from marco.bezeqint.net ([192.115.106.37]:14038 "EHLO
	marco.bezeqint.net") by vger.kernel.org with ESMTP id S263241AbTJPXCx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:02:53 -0400
Message-ID: <3F8F23BE.7020703@users.sf.net>
Date: Fri, 17 Oct 2003 01:03:26 +0200
From: Eli Billauer <eli_billauer@users.sf.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016173135.GL5725@waste.org>
In-Reply-To: <20031016173135.GL5725@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Thu, Oct 16, 2003 at 07:29:05AM -0400, Jeff Garzik wrote:
>  
>
>>So, given that trend and also given the existing /dev/[u]random, I 
>>disagree completely:  /dev/frandom is the perfect example of something 
>>that should _not_ be in the kernel.  If you want /dev/urandom faster, 
>>then solve _that_ problem.  Don't try to solve a /dev/urandom problem by 
>>creating something totally new.
>>    
>>
>
>I have some performance fixes for /dev/urandom, but there's a fair
>amount of other cleanup that has to go in first.
>
... and this reminded me that I originally wanted to patch random.c, and 
change the algorithm to the faster one. To my best understanding, there 
would be no degradation in random quality, assuming I would do it 
correctly (and not being hung for the nerve to do it). But that's the 
problem: What if I got something wrong?

If a hardware device driver is buggy, you usually know about it sooner 
or later. If an RNG has a rare bug, or an architecture-dependent flaw, 
it's much harder to notice. If the RNG starts to repeat itself, you 
won't know about it, unless you happened to test exactly that data. The 
algorithm may be perfect, but a silly bug can blow it all.

So personally, I wouldn't touch the urandom code, not even the smallest 
fix. Instead, I decided to write another RNG, which doesn't interfere 
with the existing one. The only way to be confident about it, is to give 
it mileage. And that means making it available for broad use.

Which is why I originally offered frandom as a supplement, not an 
alternative.

   Eli



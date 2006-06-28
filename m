Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWF1QLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWF1QLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWF1QLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:11:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751322AbWF1QLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:11:38 -0400
Message-ID: <44A2AA2B.3090101@osdl.org>
Date: Wed, 28 Jun 2006 09:11:23 -0700
From: John Daiker <jdaiker@osdl.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Hawkes <hawkes@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
References: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>	 <1151483994.3153.5.camel@laptopd505.fenrus.org>	 <005e01c69ac9$a55e1bf0$6f00a8c0@comcast.net> <1151511668.15166.34.camel@localhost.localdomain>
In-Reply-To: <1151511668.15166.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-06-28 am 08:43 -0700, ysgrifennodd John Hawkes:
>   
>>> #define HZ sysconf(_SC_CLK_TCK)
>>>       
>> That did occur to me.  It obviously does get the correct value.  The downside
>> is that one of those crufty apps that thinks it is using "HZ" as a constant
>> will instead be invoking a more costly syscall.  Should we care about the
>> resulting performance impact?
>>     
>
> Given that HZ can be cached by glibc the performance impact is minimal
> for most cases. The bigger problem will be code that does things with HZ
> that only work on compile time evaluation. At least for those you'll
> break at compile time.
>
> Either way its kind of irrelevant, the ABI set HZ. Its done, there are
> plenty of ways to change the kernel HZ without confusing userspace.
>
> Alan
>
>   
Alan, I agree with Arjan's solution as well.  From a very novice point 
of view, it makes sense to #define HZ as a syscall (which it technically 
should be anyway, right?).  Any performance hit isn't our problem... 
people should have been using the syscall to begin with... we're just 
forcing it on them this way!  :-)  That's my $0.02

John Daiker

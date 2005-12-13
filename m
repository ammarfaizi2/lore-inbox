Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVLMVsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVLMVsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVLMVsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:48:12 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:15720 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030249AbVLMVsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:48:11 -0500
Message-ID: <439F4188.80108@ru.mvista.com>
Date: Wed, 14 Dec 2005 00:47:52 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net>
In-Reply-To: <200512131101.02025.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>Neither is it "remove" in the normal sense either.  The hot
>path never had an allocation before ... but it could easily
>have one now, because that sort of bounce-buffer semantic is
>what a DMA_UNSAFE flag demands from the lower levels.  (That's
>a key part part of the proposed change that's not included in
>this patch... making the chage look much smaller.)
>  
>
Makes no sense to me, sorry. What 'not included' changes are you talking 
about?

>
>How much of the reason you're arguing for this is because you
>have that WLAN stack that does some static allocation for I/O
>buffers?  Changing that to use dynamic allocation -- the more
>usual style -- should be easy.  But instead, you want all code
>in the SPI stack to need to worry about two different kinds of
>I/O memory:  the normal stuff, and the DMA-unsafe kind.  Not
>  
>
Err, this change also allows to get rid of ugly stuff in write_then_read.
It also allows to keep track of memory allocation in SPI controller 
driver withough hacky tricks.
And... it's not *all* the code; if it doesn't provide such means, it's 
also fine.

>just this WLAN code which for some reason started out using
>a nonportable scheme for allocating I/O buffers.
>  
>
I'm afraid I just can't understand what you mean by 'portable' here.

>It'd take a lot more persuasion to make me think that's a good
>idea.  That's the kind of subtle confusion that really promotes
>hard-to-find bugs in drivers, and lots of developer confusion.
>  
>
What hard-to-find bugs, I wonder?
And... I'm afraid that your core is unacceptable for us w/o the changes 
proposed.

Vitaly

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVCYEqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVCYEqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVCYEqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:46:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63646 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261288AbVCYEqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:46:07 -0500
Message-ID: <42439781.4080007@pobox.com>
Date: Thu, 24 Mar 2005 23:45:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: Andrew Morton <akpm@osdl.org>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	 <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda>	 <42432596.2090709@pobox.com> <1111724759.23532.121.camel@uganda>
In-Reply-To: <1111724759.23532.121.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, 2005-03-24 at 15:39 -0500, Jeff Garzik wrote:
> 
>>Evgeniy Polyakov wrote:
>>
>>>hw_random.c already does it using userspace daemons,
>>>which is bad idea for very fast HW - like VIA xstore/xcrypt 
>>>instructions.
>>
>>This is incorrect, because it implies that a user would want to use the 
>>'xstore' feature at full speed -- which would dominate the CPU, 
>>drastically slowing down the applications that are actually doing work.
> 
> 
> If user want to get RNG data at full speed we do not want to allow it?
> Something changed in the world...

I agree with this sentiment; this is mainly a policy decision that 
kernel programmers should not make.

Certainly _by default_ the RNG should not be run "full blast" all the 
time.  This is a needless CPU soaker.

This is another example of why the userspace rngd is useful:  it is 
trivial to implement "CPU soaker" policy if you wish, or use the default 
"don't eat all my CPU" policy.


> User actually do not want to use xstore, but only read from /dev/random.

That's a policy decision to be made by the user, not you.

Some users may wish to use RNG directly.


> If kernelspace can assist and driver _knows_ in advance that data
> produced is cryptographically strong, why not allow it directly
> access pools?

A kernel driver cannot know in advance that the data from a hardware RNG 
is truly random, unless the data itself is 100% validated beforehand.

	Jeff



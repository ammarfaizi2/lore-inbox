Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCXU5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCXU5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCXU5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:57:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50409 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261315AbVCXU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:56:34 -0500
Message-ID: <42432972.5020906@pobox.com>
Date: Thu, 24 Mar 2005 15:56:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>
In-Reply-To: <1111671993.23532.115.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, 2005-03-24 at 23:23 +1000, David McCullough wrote:
> 
>>Jivin Jeff Garzik lays it down ...
>>
>>>Evgeniy Polyakov wrote:
>>>
>>>>On Thu, 2005-03-24 at 14:27 +1000, David McCullough wrote:
>>>>
>>>>
>>>>>Hi all,
>>>>>
>>>>>Here is a small patch for 2.6.11 that adds a routine:
>>>>>
>>>>>	add_true_randomness(__u32 *buf, int nwords);
>>>>>
>>>>>so that true random number generator device drivers can add a entropy
>>>>>to the system.  Drivers that use this can be found in the latest release
>>>>>of ocf-linux,  an asynchronous crypto implementation for linux based on
>>>>>the *BSD Cryptographic Framework.
>>>>>
>>>>>	http://ocf-linux.sourceforge.net/
>>>>>
>>>>>Adding this can dramatically improve the performance of /dev/random on
>>>>>small embedded systems which do not generate much entropy.
>>>>
>>>>
>>>>People will not apply any kind of such changes.
>>>>Both OCF and acrypto already handle all RNG cases - no need for any kind
>>>>of userspace daemon or entropy (re)injection mechanism.
>>>>Anyone who want to use HW randomness may use OCF/acrypto mechanism.
>>>>For example here is patch to enable acrypto support for hw_random.c
>>>>It is very simple and support only upto 4 bytes request, of course it
>>>>is 
>>>>not interested for anyone, but it is only 2-minutes example:
>>>
>>>If you want to add entropy to the kernel entropy pool from hardware RNG, 
>>>you should use the userland daemon, which detects non-random (broken) 
>>>hardware and provides throttling, so that RNG data collection does not 
>>>consume 100% CPU.
>>>
>>>If you want to use the hardware RNG directly, it's simple:  just open 
>>>/dev/hw_random.
>>>
>>>Hardware RNG should not go kernel->kernel without adding FIPS tests and 
>>>such.
>>
>>For reference,  the RNG on the Safenet I am using this with is
>>FIPS140 certified.  I believe the HIFN part  is also but I place the doc that
>>says so.
> 
> 
> At least HIFN 795x is certified.
> 
> Idea to validate entropy data is good in general, 
> but it should be implemented in a way allowing external both in-kernel
> and userspace
> processes to contribute data.
> So for in-kernel use we need such a mechanism, and userspace gkernel
> daemon
> should use it(as the latest "step") too.

See the earlier discussion, when data validation was -removed- from the 
original Intel RNG driver, and moved to userspace.


> Your changes are correct, ioctl(RNDADDENTROPY) could even use it instead
> of direct
> add_entropy_words()/credit_entropy_store(), but without external entropy
> contributors
> it will not be applied by maintainers.

No changes are needed, as the system is currently functional without 
these changes.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVCXUwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVCXUwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCXUwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:52:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29417 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261179AbVCXUvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:51:25 -0500
Message-ID: <4243283D.7000603@pobox.com>
Date: Thu, 24 Mar 2005 15:51:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David McCullough <davidm@snapgear.com>
CC: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, michal@logix.cz
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast> <42424C6D.2020605@pobox.com> <20050324125210.GC7115@beast>
In-Reply-To: <20050324125210.GC7115@beast>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough wrote:
> Jivin Jeff Garzik lays it down ...
> 
>>David McCullough wrote:
>>
>>>Jivin Jeff Garzik lays it down ...
>>>
>>>
>>>>On Thu, Mar 24, 2005 at 02:27:08PM +1000, David McCullough wrote:
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
>>>>We've already had hardware RNG support for a while now.
>>>>
>>>>No kernel patching needed.
>>>
>>>
>>>Are you talking about /dev/hw_random ?  If not then sorry I didn't see it 
>>>:-(
>>>
>>>On a lot of the small systems I work on,  /dev/random is completely
>>>unresponsive,  and all the apps use /dev/random,  not /dev/hw_random.
>>>
>>>Would you suggest making /dev/random point to /dev/hw_random then ?
>>
>>All the apps are supposed to use /dev/random, so that's correct.
> 
> 
> Ok
> 
> 
>>For Hardware RNGs, userspace rngd daemon obtains entropy, checks it 
>>(mainly checking for hardware failures), and then stuffs entropy into 
>>the kernel random device.   http://sf.net/projects/gkernel/
>>
>>On the "to do" list is making rngd directly generate entropy use 
>>'xstore' on VIA CPUs, rather than going kernel -> userland -> kernel.
>>
>>Also, there are other entropy daemons floating about.  I think there is 
>>one that obtains noise from an audio device.
> 
> 
> I had looked at hw_random,  but it seemed a little platform specific (x86),
> and it doesn't currently have a way for RNG providers to register themselves.
> Admittedly I did not know how it's output was being used in practice.
> 
> The drivers I am working with do crypto/public key and RNG.  Not all of
> them can easily have the RNG support taken from the driver and plugged
> into hw_random.c,  since it is (in most cases) a single PCI chip with
> it's own  registers, initialisation and configuration,  that,  IMO
> belongs in the driver for the particular chip.

Agreed.


> Not that it isn't possible,  but hw_random would start supporting a
> much larger number of HW variants and I think it would get ugly.

Agreed.


> It would be possible to add a "register" interface to hw_random so that
> you can register other RNG's easily.  This would seem reasonable.

Agreed.


> I work on fairly resource constrained embedded devices a lot of the
> time, so when I can avoid adding applications and reduce kernel size,
> I do.  Thus my motivation to add a simple API for adding entropy to
> /dev/random.

We already have the facilities to add entropy, as current use of 
hw_random+rngd shows.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbVCXFOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbVCXFOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbVCXFOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:14:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50610 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263026AbVCXFOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:14:11 -0500
Message-ID: <42424C6D.2020605@pobox.com>
Date: Thu, 24 Mar 2005 00:13:17 -0500
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
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050324043300.GA2621@havoc.gtf.org> <20050324044621.GC3124@beast>
In-Reply-To: <20050324044621.GC3124@beast>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough wrote:
> Jivin Jeff Garzik lays it down ...
> 
>>On Thu, Mar 24, 2005 at 02:27:08PM +1000, David McCullough wrote:
>>
>>>Hi all,
>>>
>>>Here is a small patch for 2.6.11 that adds a routine:
>>>
>>>	add_true_randomness(__u32 *buf, int nwords);
>>>
>>>so that true random number generator device drivers can add a entropy
>>>to the system.  Drivers that use this can be found in the latest release
>>>of ocf-linux,  an asynchronous crypto implementation for linux based on
>>>the *BSD Cryptographic Framework.
>>>
>>>	http://ocf-linux.sourceforge.net/
>>>
>>>Adding this can dramatically improve the performance of /dev/random on
>>>small embedded systems which do not generate much entropy.
>>
>>We've already had hardware RNG support for a while now.
>>
>>No kernel patching needed.
> 
> 
> Are you talking about /dev/hw_random ?  If not then sorry I didn't see it :-(
> 
> On a lot of the small systems I work on,  /dev/random is completely
> unresponsive,  and all the apps use /dev/random,  not /dev/hw_random.
> 
> Would you suggest making /dev/random point to /dev/hw_random then ?

All the apps are supposed to use /dev/random, so that's correct.

For Hardware RNGs, userspace rngd daemon obtains entropy, checks it 
(mainly checking for hardware failures), and then stuffs entropy into 
the kernel random device.   http://sf.net/projects/gkernel/

On the "to do" list is making rngd directly generate entropy use 
'xstore' on VIA CPUs, rather than going kernel -> userland -> kernel.

Also, there are other entropy daemons floating about.  I think there is 
one that obtains noise from an audio device.

	Jeff




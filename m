Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWHCPhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWHCPhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWHCPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:37:36 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:1482 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S964773AbWHCPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:37:34 -0400
Date: Thu, 03 Aug 2006 17:37:41 +0200
From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: problems with e1000 and jumboframes
In-reply-to: <20060803151631.GA14774@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Krzysztof Oledzki <olel@ans.pl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-id: <44D21845.6020703@arndnet.de>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-Enigmail-Version: 0.94.0.0
X-Spam-Report: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru>
 <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru>
 <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
 <20060803151631.GA14774@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Evgeniy Polyakov wrote:
> On Thu, Aug 03, 2006 at 05:08:51PM +0200, Krzysztof Oledzki (olel@ans.pl) wrote:
>>>> Why? After your explanation that makes sense for me. The driver needs
>>>> one contiguous chunk for those 9k packet buffer and thus requests a
>>>> 3-order page of 16k. Or do i still do not understand this?
>>> Correct, except that it wants 32k.
>>> e1000 logic is following:
>>> align frame size to power-of-two,
>> 16K?
> 
> Yep.
> 
>>> then skb_alloc adds a little
>>> (sizeof(struct skb_shared_info)) at the end, and this ends up
>>> in 32k request just for 9k jumbo frame.
>> Strange, why this skb_shared_info cannon be added before first alignment? 
>> And what about smaller frames like 1500, does this driver behave similar 
>> (first align then add)?
> 
> It can be.
> Could attached  (completely untested) patch help?

I will try this in a minute. However is there any way to see which
allocation e1000 does without triggering allocation failures? ;-)

Thanks,
Arnd Hannemann



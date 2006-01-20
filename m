Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWATCRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWATCRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161404AbWATCRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:17:34 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:31624 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1161176AbWATCRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:17:33 -0500
Message-ID: <43D04828.8010107@cfl.rr.com>
Date: Thu, 19 Jan 2006 21:17:12 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au>
In-Reply-To: <17360.9233.215291.380922@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>Maybe the problem here is thinking of md and dm as different things.
>Try just not thinking of them at all.  
>Think about it like this:
>  The linux kernel support lvm
>  The linux kernel support multipath
>  The linux kernel support snapshots
>  The linux kernel support raid0
>  The linux kernel support raid1
>  The linux kernel support raid5
>
>Use the bits that you want, and not the bits that you don't.
>
>dm and md are just two different interface styles to various bits of
>this.  Neither is clearly better than the other, partly because
>different people have different tastes.
>
>Maybe what you really want is for all of these functions to be managed
>under the one umbrella application.  I think that is was EVMS tried to
>do. 
>
>  
>

I am under the impression that dm is simpler/cleaner than md.  That 
impression very well may be wrong, but if it is simpler, then that's a 
good thing. 


>One big selling point that 'dm' has is 'dmraid' - a tool that allows
>you to use a lot of 'fakeraid' cards.  People would like dmraid to
>work with raid5 as well, and that is a good goal.
>  
>

AFAIK, the hardware fakeraid solutions on the market don't support raid5 
anyhow ( at least mine doesn't ), so dmraid won't either. 

>However it doesn't mean that dm needs to get it's own raid5
>implementation or that md/raid5 needs to be merged with dm.
>It can be achieved by giving md/raid5 the right interfaces so that
>metadata can be managed from userspace (and I am nearly there).
>Then 'dmraid' (or a similar tool) can use 'dm' interfaces for some
>raid levels and 'md' interfaces for others.
>

Having two sets of interfaces and retrofiting a new interface onto a 
system that wasn't designed for it seems likely to bloat the kernel with 
complex code.  I don't really know if that is the case because I have 
not studied the code, but that's the impression I get, and if it's 
right, then I'd say it is better to stick with dm rather than retrofit 
md.  In either case, it seems overly complex to have to deal with both. 



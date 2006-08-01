Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWHAUgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHAUgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWHAUgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:36:11 -0400
Received: from relay02.pair.com ([209.68.5.16]:43536 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751004AbWHAUgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:36:10 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 1 Aug 2006 15:36:07 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Amit Gud <agud@redhat.com>
cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       hpa@zytor.com, deweerdt@free.fr
Subject: Re: [RFC] [PATCH] sysctl for the latecomers
In-Reply-To: <44CFA5A8.50105@redhat.com>
Message-ID: <Pine.LNX.4.64.0608011529010.12077@turbotaz.ourhouse>
References: <44CF69F0.6040801@redhat.com> <Pine.LNX.4.64.0608011155040.12077@turbotaz.ourhouse>
 <Pine.LNX.4.64.0608011213190.12077@turbotaz.ourhouse> <44CFA5A8.50105@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Amit Gud wrote:

> Chase Venters wrote:
>>  On Tue, 1 Aug 2006, Chase Venters wrote:
>>  Btw, wanted to add some comments on the specific approach:
>>
>>  1. A ring hard-coded to 32 elements is IMO unuseable. While it may not be
>>  a real limit for what use case you have in mind, if it's in the kernel
>>  sooner or later someone else is going to use it and get bitten. Imagine if
>>  they wrote in 33 entries, and the first one was some critical security
>>  setting that ended up getting silently ignored...
>>
>>  2. On the other hand, allowing it to grow unbounded is equally
>>  unacceptable without a mechanism to list and clear the current "pending"
>>  sysctl values. Unfortunately, at this point, you're starting to violate
>>  "KISS".
>> 
>
> You figured it right, theres no "correct" number of elements that I could 
> adhere to.
>
>>  Are the modules you refer to inserted during init at all? Because it seems
>>  like it would be a lot more appropriate to just move sysctl until after
>>  loading the modules, or perhaps running it again once they are loaded.
>> 
>
> I have a case where sunrpc module gets inserted and 
> sunrpc.tcp_slot_table_entries parameter is to be set _before_ nfs module is 
> inserted. I agree that for this particular case user-space works (either udev 
> rule, or modprobe.conf or sysctl after modprobe in initscripts), but am on a 
> lookout for a more generic way for handling such cases - be it user-space or 
> otherwise.

It just seems like something that belongs in user-space -- whether that be 
better init scripts, changes to modprobe, both, or something else 
entirely.

To make a kernel implementation of this concept that isn't 
fundamentally flawed from a usability and "least-surprise" 
perspective would mean enough code and behavior that the resulting 
implementation wouldn't be considered correct for the kernel anyway.

The kernel has, fundamentally, three kinds of configuration - CONFIG_*, 
the bootloader command-line, and 'live' configuration that gets set by 
user-space whenever appropriate.

>
> AG
>

Thanks,
Chase

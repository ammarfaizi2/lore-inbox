Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQKOVXB>; Wed, 15 Nov 2000 16:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQKOVWv>; Wed, 15 Nov 2000 16:22:51 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:61320 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129724AbQKOVWj>; Wed, 15 Nov 2000 16:22:39 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <Pine.LNX.4.21.0011151308140.5584-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 15 Nov 2000 21:52:18 +0100
In-Reply-To: Rik van Riel's message of "Wed, 15 Nov 2000 13:19:26 -0200 (BRDT)"
Message-ID: <qwwem0dyn3x.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Wed, 15 Nov 2000, Rik van Riel wrote:
> On 15 Nov 2000, Christoph Rohland wrote:
> 
>> -  shm_swap is called from swap_out. Actually on my machine after a
>>    while it only gets called without __GFP_IO set, which means it
>>    will not do anything which again leads to deadlock.
> 
> Only _without_ __GFP_IO ?  That's not quite right since
> that way the system will never get around to swapping out
> dirty pages...

Yes :-(

>> -  If I call this from page_launder it will work much better, but
>>    after a while it gets stuck on prepare_highmem_swapout and will
>>    again lock up under heavy load.
> 
> So calling it from page_launder() is just a workaround to
> make the deadlock more difficult to trigger and not a fix?

It does solve the __GFP_IO issue but triggers another lockup later.

>> 2) Integrating it into the global lru lists and/or the page cache. 
>> 
>> I think the second approach is the way to go but I do not
>> understand the global lru list handling enough to do this and I
>> do not know if we can do this in the short time.
> 
> Indeed, this is the way to go. However, for 2.4 ANY change
> that makes the system work would be a good one ;)

That's what I think. But from my observations I get the impression
that balancing the vm for big shm loads will not work. So the second
approach is perhaps what we have to do to get it working.

Actually I would appreciate some hints, where I could hook into the vm
if I implement a swap_shm_page() which could be called from the
vm. Can I simply call add_to_lru_cache or do I need to add it to the
page cache...

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

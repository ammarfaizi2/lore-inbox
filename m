Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTHUQvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTHUQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:51:45 -0400
Received: from phobos.aros.net ([66.219.192.20]:60425 "EHLO phobos.aros.net")
	by vger.kernel.org with ESMTP id S262818AbTHUQvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:51:44 -0400
Message-ID: <3F44F88F.9010106@aros.net>
Date: Thu, 21 Aug 2003 10:51:27 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
References: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk> <3F44E2EB.6020508@pobox.com>
In-Reply-To: <3F44E2EB.6020508@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Matthew Wilcox wrote:
>
>> Linux is really far too verbose at boot time.  I don't think these 
>> messages
>> add anything to either the end user experience or debug ability.
>>
>> Index: fs/bio.c
>> ===================================================================
>> RCS file: /var/cvs/linux-2.6/fs/bio.c,v
>> retrieving revision 1.2
>> diff -u -p -r1.2 bio.c
>> --- fs/bio.c    29 Jul 2003 17:25:49 -0000    1.2
>> +++ fs/bio.c    21 Aug 2003 14:58:40 -0000
>> @@ -793,10 +793,6 @@ static void __init biovec_init_pools(voi
>>                      mempool_free_slab, bp->slab);
>>          if (!bp->pool)
>>              panic("biovec: can't init mempool\n");
>> -
>> -        printk("biovec pool[%d]: %3d bvecs: %3d entries (%d bytes)\n",
>> -                        i, bp->nr_vecs, pool_entries,
>> -                        size);
>
>
> . . . removing the messages outright might not serve the best 
> interests the developer.  Since even KERN_DEBUG still spams dmesg, in 
> these situations I usually change these type of messages to be 
> conditionally printed iff a debug macro is enabled.

How about using KERN_DEBUG and augmenting the dmesg store so that the 
level that is saved is configurable? Even compile time configurable 
seems reasonable to start. But axeing out even the possibility of boot 
time info seems bad to me.


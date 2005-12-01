Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVLAVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVLAVJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVLAVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:09:47 -0500
Received: from rtr.ca ([64.26.128.89]:41683 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932471AbVLAVJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:09:47 -0500
Message-ID: <438F6699.1080506@rtr.ca>
Date: Thu, 01 Dec 2005 16:09:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com
Subject: Re: [PATCH] Fix bytecount result from printk()
References: <438F1D05.5020004@rtr.ca> <20051201175732.GD19433@redhat.com>	<20051201.121554.130875743.davem@davemloft.net> <p737jaofg1o.fsf@verdi.suse.de>
In-Reply-To: <p737jaofg1o.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "David S. Miller" <davem@davemloft.net> writes:
..
>>Wow, that's amazing. :)
> 
> Taking the blame.
> 
>>I bet these can easily be removed, and since printk() is such
>>a core thing, simplifying it should trump whatever benfits
>>these few call sites have from getting a return byte count.
> 
> I used it for linewrapping in the oops output.
...
> Actually I would expect more users from sprintf and snprintf
> (e.g. common in /proc output to compute the return value of the read) 
> and that is exactly the same code path.

When I grep the 2.6.15-rc3 kernel tree, the *only* use of vprintk
seems to be for doing printk().  It does not seem to be used for
the sprintf/snprintf functions.  Actually it is the other way around,
where vprintk() calls those functions.

So no problem there, and vprintk() really doesn't need to return anything.

Cheers

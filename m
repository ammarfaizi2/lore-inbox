Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbTFLBKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbTFLBKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:10:13 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:18436 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264655AbTFLBKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:10:04 -0400
Message-ID: <3EE7D5F2.1070508@cyberone.com.au>
Date: Thu, 12 Jun 2003 11:22:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Andrew Morton <akpm@digeo.com>, bos@serpentine.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] as-iosched divide by zero fix
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com> <1055380257.662.8.camel@localhost>
In-Reply-To: <1055380257.662.8.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:

>On Wed, 2003-06-11 at 17:24, Andrew Morton wrote:
>
>
>>Do you know what the actual oops is?
>>
>
>I got it all figured out now.
>
>It is a divide by zero in update_write_batch() called from
>as_completed_request().
>
>
>>Odd that starting the X server triggers it.  Be interesting if your patch
>>fixes things for Brian.
>>
>
>I reproduced it without X.
>
>The divide by zero is on line 959 with the divide by 'write_time'. It
>can obviously be zero (see line 950). The divide by 'batch' on line 953
>seems safe.
>
>The correct patch is below.
>

Probably put in the other check to be on the safe side.
And can the check be if (!write_time || (batch / write_time > 2)

>
>
>Most important question: why are only some of us seeing this?
>

It would occur if a write batch didn't take any jiffies, which
isn't very likely. The HZ=100 change probbly brought it out.
Thanks guys.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTJ1DyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 22:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTJ1DyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 22:54:08 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:29622 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263793AbTJ1DyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 22:54:05 -0500
Message-ID: <3F9DE858.7020109@cyberone.com.au>
Date: Tue, 28 Oct 2003 14:54:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@clear.net.nz>
CC: cliff white <cliffw@osdl.org>, Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
References: <200310261201.14719.mhf@linuxmail.org> <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au> <1067305071.1693.14.camel@laptop-linux> <1067311879.1512.7.camel@laptop-linux>
In-Reply-To: <1067311879.1512.7.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nigel Cunningham wrote:

>As you rightly guessed, I was forgetting there are now 1000 jiffies per
>second.
>
>With your patch applied, I can achieve something close to 2.4
>performance, but only if I set the limit on the number of pages to
>submit at one time quite high. If I set it to 3000, I can get 20107 4K
>pages written in 5267 jiffies (14MB/s) and can read them back at resume
>time (so cache is not a factor) in 4620 jiffies (16MB/s). In 2.4, I
>normally set the limit on async commits to 100, and achieve the same
>performance. 100 here makes it very jerky and much slower.
>
>Could there be some timeout value on BIOs that I might be able to
>tweak/disable during suspend?
>

Try setting /sys/block/xxx/queue/iosched/antic_expire to 0 on your
device under IO and see how it goes. That shouldn't be causing the
problem though, especially as you are mostly writing I think?

Otherwise might possibly be the queue plugging stuff, or maybe a
regression in the disk driver.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267127AbTGLAGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267137AbTGLAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:06:34 -0400
Received: from dyn-ctb-203-221-74-60.webone.com.au ([203.221.74.60]:22020 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S267127AbTGLAGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:06:32 -0400
Message-ID: <3F0F5453.2060203@cyberone.com.au>
Date: Sat, 12 Jul 2003 10:20:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>
In-Reply-To: <1057932804.13313.58.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Thu, 2003-07-10 at 09:57, Jens Axboe wrote:
>
>>On Tue, Jul 08 2003, Marcelo Tosatti wrote:
>>
>>>Hello people,
>>>
>>>To get better IO interactivity and to fix potential SMP IO hangs (due to
>>>missed wakeups) we, (Chris Mason integrated Andrea's work) added
>>>"io-stalls-10" patch in 2.4.22-pre3.
>>>
>>>The "low-latency" patch (which is part of io-stalls-10) seemed to be a
>>>good approach to increase IO fairness. Some people (Alan, AFAIK) are a bit
>>>concerned about that, though.
>>>
>>>Could you guys, Stephen, Andrew and maybe Viro (if interested :)) which
>>>havent been part of the discussions around the IO stalls issue take a look
>>>at the patch, please?
>>>
>>>It seems safe and a good approach to me, but might not be. Or have small
>>>"glitches".
>>>
>>Well, I have one naive question. What prevents writes from eating the
>>entire request pool now? In the 2.2 and earlier days, we reserved the
>>last 3rd of the requests to writes. 2.4.1 and later used a split request
>>list to make that same guarentee.
>>
>>I only did a quick read of the patch so maybe I'm missing the new
>>mechanism for this. Are we simply relying on fair (FIFO) request
>>allocation and oversized queue to do its job alone?
>>
>
>Seems that way.  With the 2.4.21 code, a read might easily get a
>request, but then spend forever waiting for a huge queue of merged
>writes to get to disk.
>

But it is the job of the io scheduler to prevent this, isn't it?

>
>I believe the new way provides better overall read performance in the
>presence of lots of writes.
>
>

I don't know how that can be, considering writers will consume
basically limitless requests. What am I missing?



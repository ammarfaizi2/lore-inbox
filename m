Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTDNDlO (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 23:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTDNDlO (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 23:41:14 -0400
Received: from dialup-126.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.126]:47108
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262728AbTDNDlN (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 23:41:13 -0400
Message-ID: <3E9A308D.4060705@cyberone.com.au>
Date: Mon, 14 Apr 2003 13:52:45 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <tmiller10@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <001301c30145$5ff85fb0$6801a8c0@epimetheus> <3E994F06.2000402@cyberone.com.au> <000901c301d0$e3223100$6801a8c0@epimetheus>
In-Reply-To: <000901c301d0$e3223100$6801a8c0@epimetheus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>From: "Nick Piggin" <piggin@cyberone.com.au>
>
>
>>The benefit I see is knowing the seek time itself (not geometry), which
>>can be used to tune the IO scheduler. This is something that I'll
>>probably need to do (in kernel) in order to get my IO scheduler in 2.6,
>>as it probably (not tested yet) has bad failure cases on high seek time
>>devices like CDROMs.
>>
>
>Well, that IS the heart of the matter, really.  Detecting geometry was only
>a means to the end of predicting seek time and rotational latency.
>
OK yeah. I thought you had more exotic techniques in mind
like rotational latency optimisation which require actual geometry

>  If you
>could magically predict the seek time between any two accesses, then you
>could sort your queue optimally.
>
Well using the assumption that |head sector - target sector| gives
an ordering correstponding to seek time, we do sort the queue optimally.
I personally feel that being trickier than that is too much complexity.

>What would be able to do that?  A neural
>net?  :)  What would be able to do that without a lot of training time?
>
I think just some averages, maybe histograms. Not quite sure exactly
how I'll need to do it. I probably want each IO submitting process'
average seek time, and the average seek time when changing from one
process to another. Nothing too fancy.

>
>
>Personally, I've been excited about AS, and I would hate to see it not get
>in.
>
It is getting there. It definitely does some things much better than
deadline, although in other areas it is not so good.


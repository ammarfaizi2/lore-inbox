Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUC1Rsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUC1Rsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:48:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262271AbUC1RsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:48:25 -0500
Message-ID: <40670FDB.6080409@pobox.com>
Date: Sun, 28 Mar 2004 12:48:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de>
In-Reply-To: <20040328173508.GI24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Mar 28 2004, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Sat, Mar 27 2004, Jeff Garzik wrote:
>>>
>>>
>>>>I also wouldn't want to lock out any users who wanted to use SATA at 
>>>>full speed ;-)
>>>
>>>
>>>And full speed requires 32MB requests?
>>
>>
>>Full speed is the SATA driver supporting the hardware maximum.  The 
> 
> 
> Come on Jeff, don't be such a slave to the hardware specifications. Just
> because it's possible to send down 32MB requests doesn't necessarily
> mean it's a super thing to do, nor that it automagically makes 'things
> go faster'. The claim is that back-to-back 1MB requests are every bit as
> fast as a 32MB request (especially if you have a small queue depth, in
> that case there truly should be zero benefit to doing the bigger ones).
> The cut-off point is likely even lower than 1MB, I'm just using that
> figure as a value that is 'pretty big' yet doesn't incur too large
> latencies just because of its size.


For me this is a policy issue.

I agree that huge requst hurt latency.  I just disagree that the 
_driver_ should artificially lower its maximums to fit a guess about 
what the best request size should be.

If there needs to be an overall limit on per-size size, do it at the 
block layer.  It's not scalable to hardcode that limit into every 
driver.  That's not the driver's job.  The driver just exports the 
hardware limits, nothing more.

A limit is fine.  I support that.  An artificial limit in the driver is not.

	Jeff




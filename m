Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUIGJiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUIGJiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIGJiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:38:23 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:57290 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S267769AbUIGJiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:38:19 -0400
Message-ID: <413D81F3.6000402@hispeed.ch>
Date: Tue, 07 Sep 2004 11:40:03 +0200
From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: de-ch, de-de, en
MIME-Version: 1.0
To: Mike Mestnik <cheako911@yahoo.com>
CC: Dave Airlie <airlied@gmail.com>,
       =?ISO-8859-1?Q?=22Felix_=5C=22K=FC?=
	 =?ISO-8859-1?Q?hling=5C=22=22?= <fxkuehl@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>, diablod3@gmail.com,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] r200 dri driver deadlocks
References: <20040907070635.7268.qmail@web11906.mail.yahoo.com>
In-Reply-To: <20040907070635.7268.qmail@web11906.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Mestnik wrote:
> Most IMPORTANT is that some-one some-where there is a list of ALL of
> these.  These are best in the form of code comments so the the respective
> places in the code can be changed.
> 
> --- Dave Airlie <airlied@gmail.com> wrote:
> 
> 
>>>Dose the DRM varify that the cmds are in this order?  Why not just
>>
>>have
>>
>>>the DRM 'sort' the cmds?  A simple bouble sort would have no more
>>
>>overhead
>>
>>>then the check for correct order, but it would fix missordered cmd
>>>streams.
>>>
>>>Once this is done the statement holds true, userland stuff should
>>
>>never...
>>
>>Feel free to implement it and profile it, but there are so many ways
>>to lock up a radeon chip it is scary, the above was just one example,
>>some days if you look at it funny it can lockup :-), it is accepted
>>that userland can crap out 3D chips, the Intel ones are fairly easy to
>>hangup also..
>>
> 
> I'd love to, where do I start?  The problem he is that I have no-idea...
> 1. What values I'd neet to test for and sort.
> 2. The order of the sorting(probly documented in DRI-client code).
> 3. Where in the DRM I can proform the needed test and sort.
> 
> I would also love a list of ALL of these so I can fix them one by one.  A
> good project for a new DRI developer, no.

I seriously doubt this is doable. Unless you put the whole driver in the 
kernel, which of course nobody wants. I frequently caused gpu lockups by 
experimental driver changes (for instance, wrong vertex setup). I think 
the consensus was that it's ok for the driver to lock up the gpu, but it 
should not lock up the kernel.
It might be possible to prevent lockups by a watchdog, resetting the gpu 
if a lockup is detected. This is how ATI deals with lockups in windows 
(dubbed "VPU Recover"), and there is a patch floating around for DRI too 
(though it is not exactly for that, and doesn't always work).

Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWAIWCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWAIWCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWAIWCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:02:31 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:32905 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750791AbWAIWCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:02:30 -0500
Date: Mon, 9 Jan 2006 13:58:00 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
cc: Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <200601091812.55943.rene@exactcode.de>
Message-ID: <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, René Rebe wrote:

> On Monday 09 January 2006 16:10, Hannu Savolainen wrote:
>
>>>> I don't think so. The library can do such conversions (and alsa-lib does)
>>>> quite easy. If we have a possibility to remove the code from the kernel
>>>> space without any drawbacks, then it should be removed. I don't see any
>>>> advantage to have such conversions in the kernel.
>>>
>>> Also, when the data is already available as single streams in a user-space
>>> multi track application, why should it be forced interleaved, when the hardware
>>> could handle the format just fine?
>> Because the conversion doesn't cost anything. Trying to avoid it by
>> making the API more complicated (I would even say confusing) is extreme
>> overkill.
>
> Since when doesn't cost convesion anything? I'm able to count a lot of wasted
> CPU cycles in there ...

if the data needed to be accessed by the CPU anyway it's free becouse 
otherwise the CPU would stall waiting for the next chunk of memory. you 
can do quite a bit of work on data in cache while you are waiting for the 
next cache line to load.

in this same way, checksumming a network packet is free if the CPU needs 
to copy the data anway, it only costs something if the data could bypass 
the CPU.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare


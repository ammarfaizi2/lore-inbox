Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbUKUKAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbUKUKAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 05:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUKUKAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 05:00:42 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:21398 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261343AbUKUKAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 05:00:36 -0500
Message-ID: <41A0673D.8030504@colorfullife.com>
Date: Sun, 21 Nov 2004 11:00:29 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
References: <419F6DEB.6030606@colorfullife.com> <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr> <419F8D7A.1020305@colorfullife.com> <Pine.LNX.4.53.0411211039240.242@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411211039240.242@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>You have already written the code, so I'd leave it as it is and I'll
>>blame the book. They probably started from an older version of
>>fs/pipe.c, which contained _interruptible calls. There are gone now,
>>this allowed some cleanup.
>>    
>>
>
>Well, it's just one line so I would not care, and I'm also open for
>suggestions. Does down_interruptible() cost so much more in CPU cycles than
>down()?
>
>  
>
It's more about code complexity than performance. down_interruptible() 
means that you must handle failures - double check that you free all 
temporary allocations, decrease all reference counts (make the reference 
counts atomic_t), etc.

--
    Manfred

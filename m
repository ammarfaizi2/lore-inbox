Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263139AbUKTSbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbUKTSbc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUKTSbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:31:32 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:2194 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263139AbUKTSb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:31:26 -0500
Message-ID: <419F8D7A.1020305@colorfullife.com>
Date: Sat, 20 Nov 2004 19:31:22 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
References: <419F6DEB.6030606@colorfullife.com> <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411201718040.925@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>For example the use of down_interruptible() looks wrong to me, I'd use
>>plain down().
>>    
>>
>
>I'd like to be able to hit Ctrl+C (in the userspace application) whenever
>possible. If that's not a reason, blame the book
>http://www.xml.com/ldd/chapter/book/ch03.html#t8 ("the read method" a further
>down below)
>
>  
>
As far as I can see BufferLock is only held for tiny sections - the 
longest thing is a copy_to_user(), i.e. at worst a swap in. I my opinion 
the delay for handling Ctrl+C is therefore negligible and not worth the 
added code for handling down_interruptible().
You have already written the code, so I'd leave it as it is and I'll 
blame the book. They probably started from an older version of 
fs/pipe.c, which contained _interruptible calls. There are gone now, 
this allowed some cleanup.

--
    Manfred

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284662AbRLEUeQ>; Wed, 5 Dec 2001 15:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLEUeH>; Wed, 5 Dec 2001 15:34:07 -0500
Received: from colorfullife.com ([216.156.138.34]:20243 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S284662AbRLEUd4>;
	Wed, 5 Dec 2001 15:33:56 -0500
Message-ID: <3C0E84B4.1070808@colorfullife.com>
Date: Wed, 05 Dec 2001 21:33:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct + kernel stack colouring ...
In-Reply-To: <Pine.LNX.4.40.0112051103100.1644-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote

>
>
>By adding three bits of colouring you're going to cut the collision of
>about 1/8.
>
No, Shuji is right:
You have just shifted the problem, without reducing collisions.
256 kB, 4 way cache with 32 byte linesize.

cacheline == bits 15..5
offset within cacheline: bits 4..0

The colouring must depend on more than just bits 13 to 15 - if these 
bits are different, then the access goes into a different line even 
without colouring, there won't be a collision.

Shuij, I don't understand why you need both a shift and a modulo: 
address % odd_number should generate a random distribution (i.e. all 
bits affect the result), even without the shift.

--
    Manfred



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbTCIREg>; Sun, 9 Mar 2003 12:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbTCIREg>; Sun, 9 Mar 2003 12:04:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12254 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262544AbTCIREf>;
	Sun, 9 Mar 2003 12:04:35 -0500
Message-ID: <3E6B769D.2040602@colorfullife.com>
Date: Sun, 09 Mar 2003 18:15:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fast path context switch - microoptimize FPU reload
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:

>We don't need the lock prefix to test our local thread flags state.
>Unfortunately test_thread_flag currently always uses test_bit which
>has a LOCK on SMP, but that's unnecessary. LOCK is costly on P4,
>so it's a good idea to avoid it.
>  
>

No, LOCK is required: the TIF_ flags word is also used for signal 
delivery - writing without lock could corrupt state.

What about moving TIF_USEDFPU from the thread_info into 
task_struct->flags? This flag word is only accessed by "current", no 
special atomicity requirements.

--
    Manfred


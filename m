Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbTIDTuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbTIDTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:50:11 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:16585 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264841AbTIDTuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:50:05 -0400
Message-ID: <3F579767.8030806@colorfullife.com>
Date: Thu, 04 Sep 2003 21:49:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Henry Qian" <henry@amperion.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SLAB_LEVEL_MASK question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

>The kernel panics because in the flags variable, I have other flags
>(0x1f0) besides SLAB_ATOMIC.
>  
>
Which flags were set? __GFP_WAIT must not be set [i.e. will panic], the 
other combinations are invalid. The only legal values for the flags 
variable are 0 or SLAB_ATOMIC [aka GFP_ATOMIC, aka __GFP_HIGH].

>I modified it to:
>
>        if (in_interrupt() && (flags & SLAB_ATOMIC) != SLAB_ATOMIC)
>                BUG();
>
>It seems working fine.
>
>Is this good?
>  
>
No, it's wrong. Your driver will panic once in a while, especially under 
memory intensive stress tests.

--
    Manfred


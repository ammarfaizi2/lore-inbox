Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTD2Ud4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTD2Ud4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:33:56 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:2955 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261704AbTD2Udy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:33:54 -0400
Message-ID: <3EAEE48E.8030307@colorfullife.com>
Date: Tue, 29 Apr 2003 22:46:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas <linux@1g6.biz>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops mm/slab.c:1563  on 2.5.68
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas wrote:

>Apr 29 17:37:00 hal9003 kernel: drivers/usb/media/ov511.c: Invalid channel 
>(-1)
>Apr 29 17:37:31 hal9003 last message repeated 123 times
>Apr 29 17:37:52 hal9003 last message repeated 89 times
>Apr 29 17:37:53 hal9003 kernel: ------------[ cut here ]------------
>Apr 29 17:37:53 hal9003 kernel: kernel BUG at mm/slab.c:1563!
>
You are running with slab debugging enabled, and the internal self test 
noticed a corrupted object list.

>Apr 29 17:37:53 hal9003 kernel: invalid operand: 0000 [#1]
>Apr 29 17:37:53 hal9003 kernel: CPU:    0
>Apr 29 17:37:53 hal9003 kernel: EIP:    0060:[cache_alloc_refill+533/616]    
>
The error is noticed during allocation

>Apr 29 17:37:53 hal9003 kernel:  [copy_mm+456/864] copy_mm+0x1c8/0x360
>  
>
of an mm_struct object.

It looks like a double-free. It was not detected during free, because 
mm_struct's are larger than 512 bytes, and thus not redzoned.

Is this the first oops that occured since reboot, or were there previous 
messages?

Could you provide further details about your system?
--
    Manfred


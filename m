Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTIDUTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTIDUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:19:41 -0400
Received: from 67.106.152.115.ptr.us.xo.net ([67.106.152.115]:21317 "EHLO
	amperion01.amperion.com") by vger.kernel.org with ESMTP
	id S265063AbTIDUTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:19:37 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SLAB_LEVEL_MASK question
Date: Thu, 4 Sep 2003 16:19:36 -0400
Message-ID: <C6D44AA99ECEB540A5498F15F92DA07DCF0DBA@amperion01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB_LEVEL_MASK question
Thread-Index: AcNzHbwJED5D2CapQXayyNN9pVKGoQAAytsA
From: "Henry Qian" <henry@amperion.com>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other flags are __GFP_WAIT, __GFP_HIGH, __GFP_IO, __GFP_HIGHIO, and
__GFP_FS (flags == 0x1f0).

So this must be something else's wrong.  I was using madwifi Atheros
driver.

Thank you very much,

Henry

-----Original Message-----
From: Manfred Spraul [mailto:manfred@colorfullife.com] 
Sent: Thursday, September 04, 2003 3:50 PM
To: Henry Qian
Cc: linux-kernel@vger.kernel.org
Subject: Re: SLAB_LEVEL_MASK question


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


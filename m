Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTAJRLg>; Fri, 10 Jan 2003 12:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbTAJRLg>; Fri, 10 Jan 2003 12:11:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:10891 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265700AbTAJRLf>;
	Fri, 10 Jan 2003 12:11:35 -0500
Message-ID: <3E1F00BB.2090904@colorfullife.com>
Date: Fri, 10 Jan 2003 18:19:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH]Re: spin_locks without smp.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>On Fri, 2003-01-10 at 13:04, William Lee Irwin III wrote:
>> Okay, what I'm getting here is that the UP case already has preempt
>> disabled b/c the locks are taken in IRQ context?
>
>The tx/timeout path isnt always in IRQ context.
>
It is.
tx and timeout are both called at BH context with the dev_xmit spinlock 
held. See Documentation/networking/netdevices.txt

What about

    disable_irq();
    spin_lock(&np->lock);

That's what 8390.c uses, no need for an #ifdef.

--
    Manfred


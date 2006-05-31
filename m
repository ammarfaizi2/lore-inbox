Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWEaFk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWEaFk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWEaFk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:40:59 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:21148 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751705AbWEaFk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:40:59 -0400
Message-ID: <447D2C4E.6040008@colorfullife.com>
Date: Wed, 31 May 2006 07:40:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [patch 02/61] lock validator: forcedeth.c fix
References: <20060529212109.GA2058@elte.hu>	<20060529212313.GB3155@elte.hu> <20060529183300.122c671b.akpm@osdl.org>
In-Reply-To: <20060529183300.122c671b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Mon, 29 May 2006 23:23:13 +0200
>Ingo Molnar <mingo@elte.hu> wrote:
>
>  
>
>>nv_do_nic_poll() is called from timer softirqs, which has interrupts
>>enabled, but np->lock might also be taken by some other interrupt
>>context.
>>    
>>
>
>But the driver does disable_irq(), so I'd say this was a false-positive.
>
>And afaict this is not a timer handler - it's a poll_controller handler
>(although maybe that get called from timer handler somewhere?)
>
>  
>
It's both a timer handler and a poll_controller handler:
- if the interrupt handler causes a system overload (gig e without irq 
mitigation...), then the nic disables the irq on the device and waits 
one tick and handles the interrupts from a timer. This is nv_do_nic_poll().

- nv_do_nic_poll is also called from the poll_controller handler.

I'll try to remove the disable_irq() calls from the poll_controller 
handler, but probably not before the week-end.

--
    Manfred

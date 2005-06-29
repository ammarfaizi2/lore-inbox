Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVF2UqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVF2UqB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVF2Upi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:45:38 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:10161 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262639AbVF2Uo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:44:29 -0400
Message-ID: <42C3081A.1040108@colorfullife.com>
Date: Wed, 29 Jun 2005 22:44:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc without GFP_xxx?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One question from Linux-Tag was about the lack of documentation about/in 
the kernel. I try to maintain docbook entries when I modify code, even 
though I think it's mostly wasted time: Virtually noone reads it anyway, 
instead armchair logic on lkml.

Steven wrote:

>Here we see that task 2 can spin with interrupts off, while the first task
>is servicing an interrupt, and God forbid if the IRQ handler sends some
>kind of SMP signal to the CPU running task 2 since that would be a
>deadlock.  Granted, this is a hypothetical situation, but makes using
>spin_lock with interrupts enabled a little scary.
>  
>
Not, it's not even a hypothetical situation. It's an explicitely 
forbidden situation: SMP signals are sent with smp_call_function and the 
documentation to that function clearly says:
 *
 * You must not call this function with disabled interrupts or from a
 * hardware interrupt handler or from a bottom half handler.
 */

--
    Manfred

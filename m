Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVF2U2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVF2U2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVF2U2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:28:49 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:4273 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262613AbVF2U2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:28:40 -0400
Message-ID: <42C30467.8060900@colorfullife.com>
Date: Wed, 29 Jun 2005 22:28:23 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis wrote:

>It struck me that kernel actually can figure out whether it's okay
>to sleep or not by looking at combination of (flags & __GFP_WAIT)
>and ((in_atomic() || irqs_disabled()) as it already does this for
>might_sleep() barfing:
>
Wrong:
- the kernel cannot figure out if a thread owns a normal spinlock(): 
in_atomic detects spin_lock_bh(), irqs_disabled spin_lock_irq(). But 
spin_lock has no global state.
- dito for get_cpu()/put_cpu users.
- dito for rcu users, or anyone else that uses preempt_disable() for 
whatever purpose

--
    Manfred


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWGENdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGENdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGENdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:33:15 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:45831 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964859AbWGENdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:33:14 -0400
Message-ID: <44ABBF97.3070709@argo.co.il>
Date: Wed, 05 Jul 2006 16:33:11 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Duncan Sands <duncan.sands@math.u-psud.fr>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       chas@cmf.nrl.navy.mil
Subject: Re: possible recursive locking in ATM layer
References: <1152029582.3109.70.camel@laptopd505.fenrus.org>
In-Reply-To: <1152029582.3109.70.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 13:33:12.0491 (UTC) FILETIME=[8FEC47B0:01C6A037]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> > Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 
> (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006
>
> >
> > [ 2381.598609] =============================================
> > [ 2381.619314] [ INFO: possible recursive locking detected ]
> > [ 2381.635497] ---------------------------------------------
> > [ 2381.651706] atmarpd/2696 is trying to acquire lock:
> > [ 2381.666354]  (&skb_queue_lock_key){-+..}, at: [<c028c540>] 
> skb_migrate+0x24/0x6c
> > [ 2381.688848]
>
>
> ok this is a real potential deadlock in a way, it takes two locks of 2
> skbuffs without doing any kind of lock ordering; I think the following
> patch should fix it. Just sort the lock taking order by address of the
> skb.. it's not pretty but it's the best this can do in a minimally
> invasive way.
>

Isn't it a deadlock only if skb_migrate(a, b) and skb_migrate(b, a) can 
be called concurrently?

-- 
error compiling committee.c: too many arguments to function


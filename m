Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281955AbRKUTJW>; Wed, 21 Nov 2001 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281949AbRKUTJO>; Wed, 21 Nov 2001 14:09:14 -0500
Received: from colorfullife.com ([216.156.138.34]:9222 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S281943AbRKUTJI>;
	Wed, 21 Nov 2001 14:09:08 -0500
Message-ID: <3BFBFBD0.D7923E9B@colorfullife.com>
Date: Wed, 21 Nov 2001 20:09:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 
 client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> IOW:
>     Either we must demand that CPU 2 uses irq-safe spinlocks in order to 
> protect against sk->write_space(), or we must demand that CPU 1 should drop 
> 'lock1' before being allowed to call dev_kfree_skb_any().

Or dev_kfree_skb_any() should consider disabled local interrupts as
'in_irq()' and call dev_kfree_skb_irq() in this case, or the driver
could call dev_kfree_irq() if it really wants to free while holding an
irq spinlock.

But that's a known problem:
http://groups.google.com/groups?q=dev_kfree_skb_any&hl=en&rnum=1&selm=linux.net.20010905.184245.94554736.davem%40redhat.com

--
	Manfred

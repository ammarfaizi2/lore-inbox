Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTCEOhf>; Wed, 5 Mar 2003 09:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbTCEOhf>; Wed, 5 Mar 2003 09:37:35 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:11925 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S264875AbTCEOhe>; Wed, 5 Mar 2003 09:37:34 -0500
Message-Id: <200303051447.h25ElcGi006199@locutus.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Mon, 03 Mar 2003 23:07:06 -0300."
             <20030303230706.R2791@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 09:47:38 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030303230706.R2791@almesberger.net>,Werner Almesberger writes:
>see getting moved to net/core/skbuff.c, because it seems to provide
>a reasonably generic function.

it has been suggested to me that the locking in skb_migrate might not be
completely correct.  any comments on the following?

        spinlock_t *first, *second;
        if ((unsigned long)from < (unsigned long) to)) {
                first = &from->lock;
                second = &to->lock;
        } else {
                first = &to->lock;
                second = &from->lock;
        }

        local_irq_save(flags);
        spin_lock(&first);
        spin_lock(&second);

i imagine this is to prevent deadlocks when you do something silly like
skb_migrate(a,b) and then skb_migrate(b,a) elsewhere.

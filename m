Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbRA3RLP>; Tue, 30 Jan 2001 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRA3RLF>; Tue, 30 Jan 2001 12:11:05 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:49285 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130671AbRA3RK5>; Tue, 30 Jan 2001 12:10:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Mdiqd.A.qe.yEvd6@dinero.interactivesi.com> 
In-Reply-To: <Mdiqd.A.qe.yEvd6@dinero.interactivesi.com>  <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.21.0101291018080.5353-100000@ns-01.hislinuxbox.com> 
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 17:10:39 +0000
Message-ID: <11875.980874639@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ttabi@interactivesi.com said:
>  What is wrong with sleep_on()?

Are you asking me? If so, why did I not receive a copy in my inbox? If I 
want to filter duplicates locally, I can. I don't.

It's almost impossible to use it safely, and the few ways you _can_ use it
safely are frowned upon, because they mostly involve using the BKL, usage of
which is slowly being phased out in favour of finer-grained locking.

This kind of code is far too common:

 if (!event) {
	/* BUT WHAT IF THE EVENT ARRIVES _NOW_? */
 	sleep_on(&event_wait);
 }

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbSKFWnn>; Wed, 6 Nov 2002 17:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266187AbSKFWnn>; Wed, 6 Nov 2002 17:43:43 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:47751 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266179AbSKFWnk>;
	Wed, 6 Nov 2002 17:43:40 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Nov 2002 23:49:40 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.44 (now 2.5.46-c929): Strange oopses triggered by .
X-mailer: Pegasus Mail v3.50
Message-ID: <6C6A40E5238@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Nov 02 at 23:09, Petr Vandrovec wrote:
> 
> I'm getting really nervous :-( Is kdb able to track who caused unbalanced
> in_atomic() incrementation? 
> 
> After more than week of stable system I run simple 
> "arp vanicka.vc.cvut.cz" few minutes ago, and after arp output I got 
> sleeping function called from illegal context, quickly followed by two
> scheduling while atomic, and finally it died because of userspace faults 
> when in_atomic() is != 0 are treated as kernel ones...
> 
> As I saw nobody else reporting this or simillar problem, I'll start
> looking at e100 driver I use. Maybe it did not occured because of I
> was running -acX kernels since 25th Oct until yesterday. Anybody knows?

-acX use special stack for hardware IRQs, and preempt_count() is
copied only from task -> hwirq, not other way around (because of it
assumes that preempt_count() is same on exit as it was on enter...).
That's probably reason why -acX was working for me almost two weeks,
but as soon as I returned back to non-ac, it died.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

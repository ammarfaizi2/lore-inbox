Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUISRqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUISRqB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUISRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:46:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261451AbUISRpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:45:45 -0400
Date: Sun, 19 Sep 2004 13:45:29 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Dominik Brodowski <linux@dominikbrodowski.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: boot_cpu_data vs current_cpu_data in voluntary-preempt-2.6.9-rc2-mm1-S1
In-Reply-To: <20040919140738.GA8327@dominikbrodowski.de>
Message-ID: <Pine.LNX.4.58.0409191344150.16584@devserv.devel.redhat.com>
References: <20040919140738.GA8327@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Sep 2004, Dominik Brodowski wrote:

> Your voluntary-preempt-2.6.9-rc2-mm1-S1 patch contains this change
> 
> @@ -34,7 +34,7 @@ inline void __const_udelay(unsigned long
>  	xloops *= 4;
>  	__asm__("mull %0"
>  		:"=d" (xloops), "=&a" (d0)
> -		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy *
> (HZ/4)));
> +		:"1" (xloops),"0" (boot_cpu_data.loops_per_jiffy * (HZ/4)));

this comes from the BKL patch - this is done to avoid false positives in
the smp_processor_id() debugger.

	Ingo

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLRUs0>; Mon, 18 Dec 2000 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLRUsH>; Mon, 18 Dec 2000 15:48:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:21766 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129436AbQLRUsC>;
	Mon, 18 Dec 2000 15:48:02 -0500
Date: Mon, 18 Dec 2000 21:17:34 +0100
From: Andi Kleen <ak@suse.de>
To: "Boerner, Brian" <Brian_Boerner@adaptec.com>
Cc: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Re: Disabling interrupts in 2.4.x
Message-ID: <20001218211734.A2513@gruyere.muc.suse.de>
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4DA4@ntcexc02.ntc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E9EF680C48EAD311BDF400C04FA07B612D4DA4@ntcexc02.ntc.adaptec.com>; from Brian_Boerner@adaptec.com on Mon, Dec 18, 2000 at 02:57:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only thing I am sure of is that interrupts are simply not disabled.

They are only disabled on the local CPU, they could still occur on other 
CPUs. This is not different from 2.2.

> 
> I've also looked at some other scsi drivers that are disabling interrupts
> and they appear to be making similar calls to spin_lock_irqsave.
> 
> Does anyone have any suggestions for debugging this? Is there a call that
> can be made to find out if interrupts are actually disabled?

unsigned flag; 
asm volatile("pushfl ; popfl %0" : "=r" (flag)); 
printk(KERN_DEBUG "local interrupts are %s\n", (flag & (1<<9)) ? "enabled" : "disabled"); 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTJAHsB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJAHsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:48:00 -0400
Received: from users.linvision.com ([62.58.92.114]:38573 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261956AbTJAHry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:47:54 -0400
Date: Wed, 1 Oct 2003 09:47:52 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC error on SMP machine
Message-ID: <20031001074752.GC30137@bitwizard.nl>
References: <3F79F8BB.2080905@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F79F8BB.2080905@yahoo.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:42:19PM +0100, Chris Rankin wrote:
> Linux-2.4.22-SMP, 1 GB RAM, devfs, gcc-3.2.3.
> 
> Hi,
> 
> Today, my dual PIII (Coppermine) refused to boot, and wrote a large number 
> of these messages to the serial console instead:
> 
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)

> Can anyone tell me what these might mean, please? The kernel source implies 
> that it's a "Send accept error", but this doesn't help me in an "Ah, I can 
> fix that!" sense.

I rewrote that code to make it spit out those messages that you
see. That however doesn't mean I know what I'm doing....

The APIC chip has a bit register that indicates errors. The kernel,
reads the register, stores it, and that should clear the error. Just to
be sure, we read it again, and store the result. Then we print the two
results. 

In your case, the APIC seems to have a problem, and it doesn't go away
when we read the register, as it should. 

On my "BP6" motherboard, I often see 04(08) errors: The error changes
after I read it once.

The code was printing the whole bitflag shebang before reading it again,
allowing the system to generate another error in the meanwhile, and
hanging the machine. To prevent this, I modified it to just print the
raw bits, trusting that you'd be knowledgable enough to grep through the
kernel sources to find the definitions of the bits. That proved true.
And as expected, you (just like me) don't know what to do with the
definition of that bit anyway. 

On the BP6 it seems that the APIC bus is a bit noisy. So we get
transmission errors on that bus, allowing for a variety of errors on the
recieving end. In your case, the errors seem to end up happening faster 
than the machine can handle :-(

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****

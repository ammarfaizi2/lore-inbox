Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVAZFpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVAZFpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 00:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVAZFpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 00:45:52 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:54704 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262354AbVAZFpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 00:45:44 -0500
In-Reply-To: <1106696952.6244.22.camel@gaston>
References: <1106696952.6244.22.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7E912176-6F5D-11D9-986F-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Problem with cpu_rest() change
Date: Tue, 25 Jan 2005 23:45:33 -0600
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will these changes cause us to back out the patch already made to 
arch/ppc/kernel/idle.c for systems that did not support powersavings?

- kumar

On Jan 25, 2005, at 5:49 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2005-01-25 at 10:01 +0100, Ingo Molnar wrote:
>
> > it can be bad for the idle task to hold the BKL and to have 
> preemption
>  > enabled - in such a situation the scheduler will get confused if an
>  > interrupt triggers a forced preemption in that small window. But 
> it's
>  > not necessary to keep IRQs disabled after the BKL has been dropped. 
> In
>  > fact i think IRQ-disabling doesnt have to be done at all, the patch
>  > below ought to solve this scenario equally well, and should solve 
> the
>  > PPC side-effects too.
>  >
> > Tested ontop of 2.6.11-rc2 on x86 PREEMPT+SMP and PREEMPT+!SMP (which
>  > IIRC were the config variants that triggered the original problem), 
> on
>  > an SMP and on a UP system.
>
> Excellent, thanks.
>
> Ben.
>
>
>
> -
>  To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/


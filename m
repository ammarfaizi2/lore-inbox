Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTEUOPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTEUOPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:15:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41928 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261262AbTEUOPC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:15:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "David S. Miller" <davem@redhat.com>, akpm@digeo.com
Subject: Re: userspace irq balancer
Date: Wed, 21 May 2003 07:27:19 -0700
User-Agent: KMail/1.4.3
Cc: arjanv@redhat.com, haveblue@us.ibm.com, wli@holomorphy.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, mannthey@us.ibm.com
References: <1053407030.13207.253.camel@nighthawk> <20030520021712.1a548e2d.akpm@digeo.com> <20030520.172230.102567463.davem@redhat.com>
In-Reply-To: <20030520.172230.102567463.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305210727.19892.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 05:22 pm, David S. Miller wrote:
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Tue, 20 May 2003 02:17:12 -0700
>
>    Concerns have been expressed that the /proc interface may be a bit racy.
>    One thing we do need to do is to write a /proc stresstest tool which
> pokes numbers into the /proc files at high rates, run that under traffic
> for a few hours.
>
> This issue is %100 independant of whether policy belongs in the
> kernel or not.  Also, the /proc race problem exists and should be
> fixed regardless.
>
>    Nobody has tried improving the current balancer.
>
> Policy does not belong in the kernel.  I don't care what algorithm
> people decide to use, but such decisions do NOT belong in the kernel.

You keep saying that, but suppose I want to try HW IRQ balancing using the TPR 
registers.  How could I do that from userspace?  And if I could, wouldn't the 
benefit of real time IRQ routing be lost?

It seems to me that only long term interrupt policy can be done from userland.  
Anything that does fast responses to fluctuating load must be inside the 
kernel.

At the moment we don't do any fast IRQ policy.  Even the original irq_balance 
only looked for idle CPUs after an interrupt was serviced.  However, suppose 
you had a P4 with hyperthreading turned on.  If an IRQ is to be delivered to 
the main thread but it is busy and its sibling is idle, why shouldn't we 
deliver the interrupt to the idle sibling?  They both share the same caches, 
etc, so cache warmth isn't a problem.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


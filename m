Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCKF0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUCKF0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:26:39 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19096 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261601AbUCKF0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:26:33 -0500
Date: Thu, 11 Mar 2004 14:29:59 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-reply-to: <20040311.103447.10929472.t-kochi@bq.jp.nec.com>
To: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, kaneshige.kenji@jp.fujitsu.com
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <MDEEKOKJPMPMKGHIFAMAIEMADGAA.kaneshige.kenji@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="us-ascii"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I misunderstood your concern.

I think you are right. Probe_irq_on() still have another problems even if my
patch
is applied. For example, if buggy PCI device generates interrupts during its
device
driver calls probe_irq_on(), these interrupts might be considered as
spurious and
IRQ probing will fail. I think this is another problem than I pointed out.

In addition to this, if probe_irq_on() is used for PCI interrupts (level
triggered),
interrupts are generated repeatedly because there are no handlers which
clears
these interrupt request. But I think this is not a problem, because these
interrupts
will be masked by probe_irq_on() or probe_irq_off() soon. If this is a
problem, I think
probe_irq_on() should never be used for PCI (level triggered) interrupt
probing.

Regards,
Kenji Kaneshige


> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org
> [mailto:linux-ia64-owner@vger.kernel.org]On Behalf Of Takayoshi Kochi
> Sent: Thursday, March 11, 2004 10:35 AM
> To: kaneshige.kenji@jp.fujitsu.com
> Cc: davidm@hpl.hp.com; linux-ia64@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] fix PCI interrupt setting for ia64
>
>
> Hi,
>
> From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Subject: RE: [PATCH] fix PCI interrupt setting for ia64
> Date: Thu, 11 Mar 2004 09:34:06 +0900
>
> > Hi,
> >
> > I'm sorry that the report falls behind. I wanted to check out by using
> > real device driver which uses a probe_irq_on(), but I don't
> have appropriate
> > environment now.
> >
> > Though I didn't check out on a real machine yet, I believe my
> patch doesn't
> > have any influence on probe_irq_on() because current
> probe_irq_on() calls
> > startup callback to unmask the RTEs as you said before.
>
> My concern was that if there's a buggy PCI device that raises
> interrupts all the time until it's initialized by some device driver,
> probe_irq_on() would not work as expected regardless of whether
> your patch is applied or not.  I thought masking the interrupt line
> doesn't work around this case.
>
> ---
> Takayoshi Kochi <t-kochi@bq.jp.nec.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


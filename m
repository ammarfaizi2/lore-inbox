Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbUDUQb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUDUQb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDUQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:31:28 -0400
Received: from mtagate7.de.ibm.com ([195.212.29.156]:40096 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S263415AbUDUQbY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:31:24 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF5F328943.611CF55B-ONC1256E7D.005A1D57-C1256E7D.005ABDDC@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 21 Apr 2004 18:31:08 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 21/04/2004 18:31:10
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Christoph,

> > +static inline void rcu_set_active_cpu_map(cpumask_t *mask)
> > +{
> > +        cpumask_t active = idle_cpu_mask;
> > +        cpus_complement(active);
> > +        cpus_and(*mask, cpu_online_map, active);
> > +}
>
> This is a bit ugly.  What about inlining the CONFIG_NO_IDLE_HZ case
> of this function in it's only caller and define idle_cpu_mask to
> an empty cpu mask for all other arches?

This would mean that all other arches need to do the above three
statements in rcu_start_batch. If this is acceptable we certainly
can introduce a global idle_cpu_mask. Where? sched.c?

> > +        KERN_S390_HZ_TIMER=64,  /* int: hz timer on or off */
>
> Kill the S390, this seems usefull for a bunch of other architectures.

Ok, makes sense.

> > +#ifdef CONFIG_NO_IDLE_HZ
> > +extern unsigned long next_timer_interrupt(void);
> > +#endif
>
> kill the ifdef.  externs don't need to be cpp'ed away.

Aye, aye, sir ;-)

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



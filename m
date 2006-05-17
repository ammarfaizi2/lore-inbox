Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWEQPxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWEQPxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWEQPxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:53:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27967 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750741AbWEQPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:53:40 -0400
Subject: Re: [RFC] [Patch 5/8] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
In-Reply-To: <17193.1147840147@ocs3>
References: <17193.1147840147@ocs3>
Content-Type: text/plain
Date: Wed, 17 May 2006 17:53:28 +0200
Message-Id: <1147881208.6361.22.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 14:29 +1000, Keith Owens wrote:
> Martin Peschke (on Tue, 16 May 2006 19:46:38 +0200) wrote:
> >+static inline void statistic_add(struct statistic *stat, int i,
> >+				 s64 value, u64 incr)
> >+{
> >+	int cpu;
> >+	unsigned long flags;
> >+
> >+	if (stat[i].state == statistic_state_on) {
> >+		cpu = get_cpu();
> >+		local_irq_save(flags);
> >+		stat[i].add(&stat[i], cpu, value, incr);
> >+		local_irq_restore(flags);
> >+		put_cpu();
> >+	}
> >+}
> 
> Using get_cpu()/put_cpu() is pure overhead when you are disabling
> interrupts as well.
> 
> 	if (stat[i].state == statistic_state_on) {
> 		local_irq_save(flags);
> 		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> 		local_irq_restore(flags);
> 	}
> 

Ouch. Fixed it. Thank you.


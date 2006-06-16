Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWFPVFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWFPVFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPVFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:05:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:10434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751410AbWFPVFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:05:12 -0400
Date: Fri, 16 Jun 2006 13:40:47 -0700
From: Greg KH <greg@kroah.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: statistics infrastructure (in -mm tree) review
Message-ID: <20060616204047.GB9445@kroah.com>
References: <20060613232131.GA30196@kroah.com> <20060613234739.GA30534@kroah.com> <p73slm8qqe4.fsf@verdi.suse.de> <44909292.2080005@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44909292.2080005@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 12:49:54AM +0200, Martin Peschke wrote:
> Andi Kleen wrote:
> >Greg KH <greg@kroah.com> writes:
> >>>+ * exploiters don't update several statistics of the same entity in one 
> >>>go.
> >>>+ */
> >>>+static inline void statistic_add(struct statistic *stat, int i,
> >>>+				 s64 value, u64 incr)
> >>>+{
> >>>+	unsigned long flags;
> >>>+	local_irq_save(flags);
> >>>+	if (stat[i].state == STATISTIC_STATE_ON)
> >>>+		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> >
> >
> >Indirect call in statistics hotpath?  You know how slow this is 
> >on IA64 and even on other architectures it tends to disrupt 
> >the pipeline.
> 
> Okay, let's try to improve it then. The options here are:
> 
> a) Replace the indirect function call by a switch statement which directly
>    calls the add function of the data processing mode chosen by user.
>    (e.g. simple counter, histogram, utilisation indicator etc.).
> 
>    No loss in functionality, slightly uglier code, acceptable 
>    performance(?).
>    This would be my choice.

Probably best.  Just don't make it an inline function :)

thanks,

greg k-h

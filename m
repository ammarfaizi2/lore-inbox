Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUJFGSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUJFGSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268312AbUJFGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:18:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:59307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268298AbUJFGSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:18:36 -0400
Date: Tue, 5 Oct 2004 23:16:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andrea@novell.com, nickpiggin@yahoo.com.au, rml@novell.com,
       roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
 (SCSI-libsata, VIA SATA))
Message-Id: <20041005231642.55308f99.akpm@osdl.org>
In-Reply-To: <41638AEB.5080703@pobox.com>
References: <52is9or78f.fsf_-_@topspin.com>
	<4163465F.6070309@pobox.com>
	<41634A34.20500@yahoo.com.au>
	<41634CF3.5040807@pobox.com>
	<1097027575.5062.100.camel@localhost>
	<20041006015515.GA28536@havoc.gtf.org>
	<41635248.5090903@yahoo.com.au>
	<20041006020734.GA29383@havoc.gtf.org>
	<20041006031726.GK26820@dualathlon.random>
	<4163660A.4010804@pobox.com>
	<20041006040323.GL26820@dualathlon.random>
	<41636FCF.3060600@pobox.com>
	<20041005214605.5ec397ab.akpm@osdl.org>
	<41638AEB.5080703@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >>Preempt will always be something I ask people to turn off when reporting 
> >> driver bugs; it just adds too much complicated mess for zero gain.
> > 
> > 
> > What driver bugs are apparent with preemption which are not already SMP bugs?
> 
> If your implied answer is true, then we wouldn't need 
> preempt_{en,dis}able() sprinkled throughout the code so much.
> 

Where?

`grep -r preempt_disable drivers' points at one bodgy scsi driver.

`grep -r preempt_disable fs' finds two instances of per-cpu data.

`grep -r preempt_disable mm' finds three instances (wtf is vmalloc_to_page
trying to do?  Looks redundant)

`grep -r preempt_disable ipc' is empty

`grep -r preempt_disable net' is empty

`grep -r preempt_disable include' gets a few.

It's less than I expected, actually.

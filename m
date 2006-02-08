Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWBHITE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWBHITE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWBHITE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:19:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030331AbWBHITC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:19:02 -0500
Date: Wed, 8 Feb 2006 00:18:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add execute_in_process_context() API
Message-Id: <20060208001833.49300fe1.akpm@osdl.org>
In-Reply-To: <p737j86l1es.fsf@verdi.suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
	<p737j86l1es.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> James Bottomley <James.Bottomley@SteelEye.com> writes:
> 
> In general this seems like a lot of code for a simple problem.
> It might be simpler to just put the work structure into the parent
> object and do the workqueue unconditionally
> 

That apparently would have really bad performance problems.  If we're
!in_interrupt() we want to do the work synchronously.

But yes, if we can embed the work_struct inside the structure which the
callback will operate on

> > +	if (unlikely(!wqw)) {
> > +		printk(KERN_ERR "Failed to allocate memory\n");
> > +		WARN_ON(1);
> 
> WARN_ON for GFP_ATOMIC failure is bad. It is not really a bug.

it will solve this problem.  (And I think is is a problem: if the
allocation fails, we leak things?)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWATWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWATWQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWATWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:16:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932239AbWATWQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:16:43 -0500
Date: Fri, 20 Jan 2006 14:18:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, dsingleton@mvista.com, drepper@gmail.com,
       mingo@elte.hu
Subject: Re: [robust-futex-4] futex: robust futex support
Message-Id: <20060120141801.71d842f7.akpm@osdl.org>
In-Reply-To: <200601201841.24565.ioe-lkml@rameria.de>
References: <43C84D4B.70407@mvista.com>
	<F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com>
	<20060118212256.1553b0ec.akpm@osdl.org>
	<200601201841.24565.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> > > +	list_for_each_entry_safe(this, next, head, list) {
> > > +		list_del(&this->list);
> > > +		kmem_cache_free(robust_futex_cachep, this);
> > > +	}
> > 
> > If we're throwing away the entire contents of the list, there's no need to
> > detach items as we go.
>  
> Couldn't even detach the list elements first by
> 
> list_splice_init(&mapping->robust_head->robust_list, head);
> 
> and free the list from "head" after releasing the mutex? 
> This would reduce lock contention, no?

Yes, it would reduce lock contention nicely.

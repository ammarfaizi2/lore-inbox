Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUCZVTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUCZVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:19:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:61089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbUCZVSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:18:32 -0500
Date: Fri, 26 Mar 2004 13:17:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, davej@redhat.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-Id: <20040326131736.1cc6a939.akpm@osdl.org>
In-Reply-To: <1080333938.7033.0.camel@laptop.fenrus.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
	<20040326104904.59f7a156.akpm@osdl.org>
	<16484.37279.839961.375027@napali.hpl.hp.com>
	<20040326123303.7a775b02.akpm@osdl.org>
	<1080333938.7033.0.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> > a) execute a prefetch at addresses which are not PREFETCH_STRIDE-aligned
>  >    and, as a consequence,
>  > 
>  > b) prefetch data from the next page, outside the range of the user's
>  >    (addr,len).
> 
>  well if you assume that cachelines (and prefetch stride) are proper
>  divisors of PAGE_SIZE is that still true ?

Probably not ;)

If someone does

	prefetch_range(4096, 1);

on 4k pagesize, what should we do?

Issuing a single

	prefetch 4090

sounds reasonable.

In that case I'm arranging for it to perform

	prefetch (4096 - 32)

in that case, which seems neater.

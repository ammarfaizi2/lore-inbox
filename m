Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWHYHNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWHYHNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWHYHNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:13:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbWHYHNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:13:51 -0400
Date: Fri, 25 Aug 2006 00:13:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, hch@infradead.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, netdev@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [take13 1/3] kevent: Core files.
Message-Id: <20060825001314.b320b10a.akpm@osdl.org>
In-Reply-To: <20060825.000106.30184424.davem@davemloft.net>
References: <20060824200322.GA19533@infradead.org>
	<20060825054815.GC16504@2ka.mipt.ru>
	<20060824232024.0d230823.akpm@osdl.org>
	<20060825.000106.30184424.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 00:01:06 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Thu, 24 Aug 2006 23:20:24 -0700
> 
> > On Fri, 25 Aug 2006 09:48:15 +0400
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > > kmalloc is really slow actually - it always shows somewhere on top 
> > > in profiles and brings noticeble overhead
> > 
> > It shouldn't.  Please describe the workload and send the profiles.
> 
> Not that I can account for the problem in this specific case, in my
> experience cutting down kmalloc() calls matters a _lot_ performance
> wise.
> 
> For example, this is why we allocate TCP sockets as one huge blob
> instead of 3 seperate allocations (generic socket, IP socket, TCP
> socket).
> 
> In fact, one of the remaining performance issues in IPSEC rule
> creation is that we allocate seperately hunks of memory for the rule's
> encryption state, the optional hash algorithm state, etc.

Part of that will be cache sharing between the three structs though.

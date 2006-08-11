Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWHKGzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWHKGzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHKGzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:55:40 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:39385 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932382AbWHKGzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:55:38 -0400
Date: Fri, 11 Aug 2006 10:55:10 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060811065509.GA13413@2ka.mipt.ru>
References: <20060811061535.GA11230@2ka.mipt.ru> <44DC22C1.1060200@redhat.com> <20060811063353.GC11230@2ka.mipt.ru> <20060810.233826.24610567.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060810.233826.24610567.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 11 Aug 2006 10:55:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:38:26PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> Date: Fri, 11 Aug 2006 10:33:53 +0400
> 
> > That requires mmap hacks to substitute pages in run-time without user
> > notifications. I do not expect it is a good solution, since on x86 it
> > requires full TLB flush (at least when I did it there were no exported
> > methods to flush separate addresses).
> 
> You just need to provide a do_no_page method, the VM layer will
> take care of the page level flushing or whatever else might be
> needed.

Yes, it is the simplest way to extend mapping but not to replace pages
which are successfully mapped, but such hacks are not needed for kevent
which only expects to extend mapping when number of ready kevents
increases.

So I will create such implementation and will place a reduced amount of
info into that pages.

-- 
	Evgeniy Polyakov

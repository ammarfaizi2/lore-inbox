Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWHKGel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWHKGel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHKGel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:34:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14574 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932067AbWHKGek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:34:40 -0400
Date: Fri, 11 Aug 2006 10:33:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060811063353.GC11230@2ka.mipt.ru>
References: <11551105602734@2ka.mipt.ru> <20060809152127.481fb346.akpm@osdl.org> <20060810061433.GA4689@2ka.mipt.ru> <20060810001844.ff5e7429.akpm@osdl.org> <20060810075047.GB24370@2ka.mipt.ru> <20060810010254.3b52682f.akpm@osdl.org> <20060810082235.GA21025@2ka.mipt.ru> <20060810175639.b64faaa9.akpm@osdl.org> <20060811061535.GA11230@2ka.mipt.ru> <44DC22C1.1060200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44DC22C1.1060200@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 11 Aug 2006 10:33:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:25:05PM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > The main disadvantage is that all memory is allocated on the start even
> > if it will not be used later. I think dynamic grow is appropriate
> > solution, since user will have that memory used anyway, since kevents
> > are allocated,
> 
> If you _allocate_ memory at startup you're doing something wrong.  All
> you should do is allocate address space.  Memory should be allocated
> when it is needed.
> 
> Growing a memory region is always hard because it means you cannot keep
> any addresses around and always have to reload a base pointer.  That's
> not ideal.
>
> Especially on 64-bit machines address space really is no limitation
> anymore.  So, allocate as much as needed, allocate memory when it's
> needed, and don't resize.

That requires mmap hacks to substitute pages in run-time without user
notifications. I do not expect it is a good solution, since on x86 it
requires full TLB flush (at least when I did it there were no exported
methods to flush separate addresses).

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCIGvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCIGvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVCIGvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:51:00 -0500
Received: from waste.org ([216.27.176.166]:7869 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261630AbVCIGua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:50:30 -0500
Date: Tue, 8 Mar 2005 22:50:27 -0800
From: Matt Mackall <mpm@selenic.com>
To: Dmitry Yusupov <dmitry_yus@yahoo.com>
Cc: Alex Aizman <itn780@yahoo.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
Message-ID: <20050309065027.GX3120@waste.org>
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org> <422E8EEB.7090209@yahoo.com> <20050309060544.GW3120@waste.org> <1110349558.4451.8.camel@mylaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110349558.4451.8.camel@mylaptop>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 10:25:58PM -0800, Dmitry Yusupov wrote:
> On Tue, 2005-03-08 at 22:05 -0800, Matt Mackall wrote:
> > On Tue, Mar 08, 2005 at 09:51:39PM -0800, Alex Aizman wrote:
> > > Matt Mackall wrote:
> > > 
> > > >How big is the userspace client?
> > > >
> > > Hmm.. x86 executable? source?
> > > 
> > > Anyway, there's about 12,000 lines of user space code, and growing. In 
> > > the kernel we have approx. 3,300 lines.
> > > 
> > > >>- 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
> > > >>size);
> > > >
> > > >With what network hardware and drives, please?
> > > >
> > > Neterion's 10GbE adapters. RAM disk on the target side.
> > 
> > Ahh.
> > 
> > Snipped my question about userspace deadlocks - that was the important
> > one. It is in fact why the sfnet one is written as it is - it
> > originally had a userspace component and turned out to be easy to
> > deadlock under load because of it.
> 
> As Scott Ferris pointed out, the main reason for deadlock in sfnet was
> blocking behavior of page cache when daemon tried to do filesystem IO,
> namely syslog().

That was just one of several problems. And ISTR deciding that
particular one was quite nasty when we first encountered it though I
no longer remember the details.

> That was 2.4.x kernel. We don't know whether it is
> fixed in 2.6.x. If someone knows, please let us know. Meanwhile we came
> up with work-around design in user-space. "Paged out" problem fixed
> already in our subversion repository by utilizing mlockall()
> syscall.

I presume this is dynamically linked against glibc?

> Also we have IMHO, working solution for OOM during ERL=0 TCP re-connect.

Care to describe it?

-- 
Mathematics is the supreme nostalgia of our time.

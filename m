Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVCIG0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVCIG0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVCIG0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:26:36 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:49488 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262177AbVCIG0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:26:12 -0500
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Alex Aizman <itn780@yahoo.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050309060544.GW3120@waste.org>
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org>
	 <422E8EEB.7090209@yahoo.com>  <20050309060544.GW3120@waste.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 22:25:58 -0800
Message-Id: <1110349558.4451.8.camel@mylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:05 -0800, Matt Mackall wrote:
> On Tue, Mar 08, 2005 at 09:51:39PM -0800, Alex Aizman wrote:
> > Matt Mackall wrote:
> > 
> > >How big is the userspace client?
> > >
> > Hmm.. x86 executable? source?
> > 
> > Anyway, there's about 12,000 lines of user space code, and growing. In 
> > the kernel we have approx. 3,300 lines.
> > 
> > >>- 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
> > >>size);
> > >
> > >With what network hardware and drives, please?
> > >
> > Neterion's 10GbE adapters. RAM disk on the target side.
> 
> Ahh.
> 
> Snipped my question about userspace deadlocks - that was the important
> one. It is in fact why the sfnet one is written as it is - it
> originally had a userspace component and turned out to be easy to
> deadlock under load because of it.

As Scott Ferris pointed out, the main reason for deadlock in sfnet was
blocking behavior of page cache when daemon tried to do filesystem IO,
namely syslog(). That was 2.4.x kernel. We don't know whether it is
fixed in 2.6.x. If someone knows, please let us know. Meanwhile we came
up with work-around design in user-space. "Paged out" problem fixed
already in our subversion repository by utilizing mlockall() syscall.
Also we have IMHO, working solution for OOM during ERL=0 TCP re-connect.

Dmitry


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVCIHSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVCIHSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVCIHSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:18:43 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:6069 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262245AbVCIHSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:18:22 -0500
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Alex Aizman <itn780@yahoo.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050309065027.GX3120@waste.org>
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org>
	 <422E8EEB.7090209@yahoo.com> <20050309060544.GW3120@waste.org>
	 <1110349558.4451.8.camel@mylaptop>  <20050309065027.GX3120@waste.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 23:18:08 -0800
Message-Id: <1110352689.4451.32.camel@mylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:50 -0800, Matt Mackall wrote:
> On Tue, Mar 08, 2005 at 10:25:58PM -0800, Dmitry Yusupov wrote:
> > On Tue, 2005-03-08 at 22:05 -0800, Matt Mackall wrote:
> > > On Tue, Mar 08, 2005 at 09:51:39PM -0800, Alex Aizman wrote:
> > > > Matt Mackall wrote:
> > > > 
> > > > >How big is the userspace client?
> > > > >
> > > > Hmm.. x86 executable? source?
> > > > 
> > > > Anyway, there's about 12,000 lines of user space code, and growing. In 
> > > > the kernel we have approx. 3,300 lines.
> > > > 
> > > > >>- 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
> > > > >>size);
> > > > >
> > > > >With what network hardware and drives, please?
> > > > >
> > > > Neterion's 10GbE adapters. RAM disk on the target side.
> > > 
> > > Ahh.
> > > 
> > > Snipped my question about userspace deadlocks - that was the important
> > > one. It is in fact why the sfnet one is written as it is - it
> > > originally had a userspace component and turned out to be easy to
> > > deadlock under load because of it.
> > 
> > As Scott Ferris pointed out, the main reason for deadlock in sfnet was
> > blocking behavior of page cache when daemon tried to do filesystem IO,
> > namely syslog().
> 
> That was just one of several problems. And ISTR deciding that
> particular one was quite nasty when we first encountered it though I
> no longer remember the details.

that's bad. since all those details might help us to avoid problems and
save time in the future daemon design. I will really appreciate you will
point me to other potential problems once you recall.

> 
> > That was 2.4.x kernel. We don't know whether it is
> > fixed in 2.6.x. If someone knows, please let us know. Meanwhile we came
> > up with work-around design in user-space. "Paged out" problem fixed
> > already in our subversion repository by utilizing mlockall()
> > syscall.
> 
> I presume this is dynamically linked against glibc?

over time it will be linked against klibc as dm-multipath do. It will
also help to implement iSCSI boot, when control plane daemon will be
part of initramfs image.

> > Also we have IMHO, working solution for OOM during ERL=0 TCP re-connect.
> 
> Care to describe it?

sure. the idea was to always keep second reserved/redundant TCP
connection per session opened. (please note, TCP connection, not iSCSI
connection). This way during recovery cycle in case of sane target,
initiator will switch into redundant TCP connection and send Login
request over. This could be implemented as a feature and might be
disabled via configuration utility if needed.

Dmitry


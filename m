Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWCCUds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWCCUds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWCCUds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:33:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbWCCUds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:33:48 -0500
Date: Fri, 3 Mar 2006 12:32:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] map multiple blocks in get_block() and
 mpage_readpages()
Message-Id: <20060303123222.2fff68cf.akpm@osdl.org>
In-Reply-To: <1141405539.10542.68.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<20060301175230.4b96e9ad.akpm@osdl.org>
	<1141405539.10542.68.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Wed, 2006-03-01 at 17:52 -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > I noticed decent improvements (reduced sys time) on JFS, XFS and ext3.
> > > (on simple "dd" read tests).
> > > 
> > >          (rc3.mm1)      (rc3.mm1 + patches)
> > > real    0m18.814s       0m18.482s
> > > user    0m0.000s        0m0.004s
> > > sys     0m3.240s        0m2.912s
> > 
> > With which filesystem?  XFS and JFS implement a larger-than-b_size
> > ->get_block, but ext3 doesn't.  I'd expect ext3 system time to increase a
> > bit, if anything?
> 
> These numbers are on JFS. With the current ext3 (mainline) - I did
> find not-really-noticible increase in sys time (due to code overhead).
> 
> I tested on ext3 with Mingming's ext3 getblocks() support in -mm also,
> which showed reduction in sys time.
> 

OK, no surprises there.  Things will improve when someone gets around to
doing multi-block get_block for ext3.

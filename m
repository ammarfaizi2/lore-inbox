Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbUJZW7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUJZW7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbUJZW7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:59:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40837 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261515AbUJZW7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:59:04 -0400
Subject: Re: [Ext2-devel] Re: [PATCH 2/3] ext3 reservation allow turn off
	for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ray-lk@madrabbit.org, sct@redhat.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20041026131842.45b99834.akpm@osdl.org>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com> <109787 
	<1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
	<1098294941.18850.4.camel@orca.madrabbit.org>
	<1098736389.9692.7243.camel@w-ming2.beaverton.ibm.com>
	<1098745548.9754.7427.camel@w-ming2.beaverton.ibm.com>
	<20041025164516.1f02bb9f.akpm@osdl.org>
	<1098809607.8919.7466.camel@w-ming2.beaverton.ibm.com> 
	<20041026131842.45b99834.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2004 16:01:25 -0700
Message-Id: <1098831688.9920.7632.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 13:18, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > > I wonder how important this optimisation really is?  I bet no applications
> >  > are using posix_fadvise(POSIX_FADV_RANDOM) anyway.
> >  > 
> >  I don't know if there is application using the POSIX_FADV_RANDOM. No? If
> >  this is the truth, I think we don't need this optimization at present.
> >  Logically reservation does not benefit seeky random write, but there is
> >  no benchmark showing performance issue so far. We have already provided
> >  ways for applications turn off reservation through the existing ioctl
> >  for specified file and -o noreservation mount option for the whole
> >  filesystem.
> 
> Well we definitely don't want to be encouraging application developers to be
> adding ext3-specific ioctls.  So we need to work out if any applications
> can get significant benefit from manually disabling reservations and if
> so, wire up fadvise() into filesystems and do it that way.
> 
Okey. Also, if there is such a need to disable reservation, maybe we
could think about closing the reservation window dynamically based on
past I/O pattern, when user application did not give any hint.

> Do you know if disabling reservations helps any workloads?
> 
Not that I aware of.  We have done several microbenchmark on sequential
and random workload, haven't seen regression with reservations so far.
But our testing is certainly not comprehensive.

Mingming


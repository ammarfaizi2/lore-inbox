Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJSBAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJSBAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268210AbUJSBAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:00:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31619 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268180AbUJSBAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:00:02 -0400
Subject: Re: [PATCH 2/3] ext3 reservation allow turn off for specifed file
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20041018164218.70fb08d3.akpm@osdl.org>
References: <1097846833.1968.88.camel@sisko.scot.redhat.com>
	<1097856114.4591.28.camel@localhost.localdomain>
	<1097858401.1968.148.camel@sisko.scot.redhat.com>
	<1097872144.4591.54.camel@localhost.localdomain>
	<1097878826.1968.162.camel@sisko.scot.redhat.com>
	<1097879695.4591.61.camel@localhost.localdomain>
	<1098140129.9754.1064.camel@w-ming2.beaverton.ibm.com> 
	<20041018164218.70fb08d3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2004 18:01:42 -0700
Message-Id: <1098147705.8803.1084.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:42, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > Allow user shut down reservation-based allocation(using ioctl) on a specific file(e.g. for seeky random write).
> 
> Applications currently pass a seeky-access hint into the kernel via
> posix_fadvise(POSIX_FADV_RANDOM).  It would be nice to hook into that
> rather than adding an ext3-specific ioctl.  Maybe just peeking at
> file->f_ra.ra_pages would suffice.
> 
> 

Ha, I think I did not make this clear in the description: The patch did
not add a new ext3-specific ioctl. We added two ioctl before for ext3
reservation code to allow user to get and set reservation window size,
so application could set it's desired reservation window size. It allows
the window size to be 0, however the current reservation code just
simply set the window size value to 0, but still try to allocate a size
0 reservation window. We should skip doing reservation-based allocation
at all if the desired window size is 0.

Just thought seeky random write application could use the existing ioctl
to let the kernel know it does not need reservation at all. Isn't that
more straightforward?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVCJCI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVCJCI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVCJCF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:05:28 -0500
Received: from fmr21.intel.com ([143.183.121.13]:64642 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262702AbVCJCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:04:13 -0500
Message-Id: <200503100204.j2A244g28335@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 18:04:04 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlEUiJXG7NNZKzRr2d0jQxLsIaVQAAIIbwAABvbBA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote on Wednesday, March 09, 2005 5:45 PM
> Andrew Morton wrote on Wednesday, March 09, 2005 5:34 PM
> > What are these percentages?  Total CPU time?  The direct-io stuff doesn't
> > look too bad.  It's surprising that tweaking the direct-io submission code
> > makes much difference.
>
> Percentage is relative to total kernel time.  There are three DIO functions
> showed up in the profile:
>
> __blockdev_direct_IO	4.97%
> dio_bio_end_io		2.70%
> dio_bio_complete	1.20%

For the sake of comparison, let's look at the effect of performance patch on
raw device, in place of the above three functions, we now have two:

raw_file_rw			1.59%
raw_file_aio_rw		1.19%

A total saving of 6.09% (4.97+2.70+1.20 -1.59-1.19).  That's only counting
the cpu cycles.  We have tons of other data showing significant kernel path
length reduction with the performance patch.  Cache misses reduced across
the entire 3 level cache hierarchy, that's a secondary effect can not be
ignored since kernel is also competing cache resource with application.

- Ken



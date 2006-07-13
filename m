Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWGMAlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWGMAlM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGMAlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:41:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751482AbWGMAlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:41:12 -0400
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <44B55AEA.1010608@google.com>
References: <44B52A19.3020607@google.com>
	 <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>
	 <44B55A9E.2010403@us.ibm.com>  <44B55AEA.1010608@google.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 17:43:31 -0700
Message-Id: <1152751411.22840.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 13:26 -0700, Martin Bligh wrote:
> Badari Pulavarty wrote:
> > Martin Bligh wrote:
> > 
> >> Eric Dumazet wrote:
> >>
> >>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
> >>>
> >>>> http://test.kernel.org/abat/40891/debug/test.log.1
> >>>>
> >>>> Filesystem type for /mnt/tmp is xfs
> >>>> write failed on handle 13786
> >>>> 4 clients started
> >>>> Child failed with status 1
> >>>> write failed on handle 13786
> >>>> write failed on handle 13786
> >>>> write failed on handle 13786
> >>>>
> >>>> Works fine in -git4
> >>>> All other fs's seemed to run OK.
> >>>>
> >>>> Machine is a 4x Opteron.

Sorry !! its my screw up again :(
Here is the patch to fix it.

Thanks,
Badari

Fix a bug in __xfs_file_write() which is causing writes to fail
with -EINVAL.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.18-rc1/fs/xfs/linux-2.6/xfs_file.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/xfs/linux-2.6/xfs_file.c	2006-07-11 21:28:08.000000000 -0700
+++ linux-2.6.18-rc1/fs/xfs/linux-2.6/xfs_file.c	2006-07-12 17:43:13.000000000 -0700
@@ -99,7 +99,7 @@ __xfs_file_write(
 	BUG_ON(iocb->ki_pos != pos);
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= IO_ISDIRECT;
-	return bhv_vop_write(vp, iocb, &iov, nr_segs, &iocb->ki_pos,
+	return bhv_vop_write(vp, iocb, iov, nr_segs, &iocb->ki_pos,
 				ioflags, NULL);
 }
 





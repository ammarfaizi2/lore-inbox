Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUFIFVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUFIFVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 01:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUFIFU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 01:20:59 -0400
Received: from system65-210-78-197.hpti.com ([65.210.78.197]:64605 "EHLO
	hptimail01.HPTI.COM") by vger.kernel.org with ESMTP id S265537AbUFIFU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 01:20:57 -0400
Subject: Re: NFS corruption (duplicated data)
From: Craig Tierney <ctierney@hpti.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Andy <genanr@emsphone.com>, cattelan@sgi.com, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20040609095109.E1200131@wobbly.melbourne.sgi.com>
References: <20040608154422.GA3946@thumper2>
	 <20040609095109.E1200131@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Message-Id: <1086758368.3004.312.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 23:19:29 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2004 05:20:58.0938 (UTC) FILETIME=[8C42B9A0:01C44DE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 17:51, Nathan Scott wrote:
> Hi Andy,
> 
> Be good to try this with files served from ext2/3 as well,
> to try isolate it to XFS/NFS.  We have a known issue thats
> possibly related to this in XFS - Russell, does this sound
> like that problem you've been looking at?
> 
> If you have a simple test case to reproduce it (we have an
> extremely complex test case to reproduce that other issue,
> but from your description I'm not sure its the same), that
> would be very helpful Andy.
> 
> thanks.

> 
> On Tue, Jun 08, 2004 at 10:44:22AM -0500, Andy wrote:
> > I really don't understand what could be causing this, but it happens on
> > several machine and at least on kernels 2.4.22, 2.4.25, 2.4.26.
> > NFS v3 : hard, udp, rsize=8192,wsize=8192
> > local filesystems are XFS
> > 
> > Trond, this is data corruption not dropped packets so the protocol
> > being UDP is not the problem.
> > 
> > Here is what is happening :
> > 
> > Copying a file of offsets from machine A to machine B over NFS and then
> > comparing the file on B with the file on A over NFS, the file on machine B
> > is corrupted in the following ways. 
> > 
> > Usually, data earlier in the file will show up again later.
> > For example :
> > 
> > 57344 bytes of data from 672190464-672247807 is also in positions
> > 1449664512-1449721855
> > 
> > sometimes, data later in the file is dupped to a position before it
> > should be
> > 
> > 53248 bytes of data from 1197158400-1197211647 is also in positions
> > 1036660736-1036713983
> > 

Are you performing other IO on the NFS system while this copy is
occuring?  Are you copying the same file over and over to try and
cause this problem?

Is it possible to zero all or as much disk as possible?  If you are 
copying the same file over and over, you might be seeing old data on
the disk and not necessarily seeing the filesystem putting the data in
the wrong place.  This might help isolate the problem to the one Russell
is working on vs. a different problem.

Craig



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272559AbTHPCPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 22:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272561AbTHPCPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 22:15:50 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:8715 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272559AbTHPCPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 22:15:48 -0400
Date: Fri, 15 Aug 2003 19:15:44 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: possible auto-partition bug? (linux-2.4.20-8)
Message-ID: <20030816021544.GD3479@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030815135013.01b05bf8@oscarmayer.east.sun.com> <20030815222304.A3272@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815222304.A3272@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:23:04PM +0200, Andries Brouwer wrote:
> On Fri, Aug 15, 2003 at 01:55:59PM -0400, Pete Nishimoto wrote:
> 
> >          My name is Pete Nishimoto and I work for Sun Microsystems
> >          as a linux device driver developer, currently working with
> >          RedHat 9.0 (2.4.20-8) and I believe I have found a problem
> >          with the partitioning logic and the pager, which I've
> >          detailed below.  I look forward to any replies/comments
> >          and thanks in advance to all who review/read this.
> 
> Hi. You sent a long story, but at first sight it seems not relevant
> for this linux-kernel mailing list.
> 
> A disk is made by a manufacturer, and has a number of sectors that we
> must regard as given. If a filesystem is created on this disk then
> often the disk size will turn out not to be precisely an integral
> number of filesystem blocks.
> 
> Many people first partition the disk in some more or less arbitrary way.
> Partitions may belong to other operating systems. Again we have no control.
> 
> In short, absolutely nothing is wrong if a disk, or a partition, has a size
> that is not an integral number of filesystem blocks.
> 
> You talk about badblocks, but that is a userspace utility. If something
> is wrong with it, that is not a kernel matter. Moreover, this utility
> allows one to specify blocksize and last block to test.
> 
> So - the relevance to the kernel is not clear to me.
> 
> Concerning "RedHat 9.0 (2.4.20-8)" - discussion about vendor specific kernels
> is probably best done on vendor lists.

I can see no relevance to the kernel here.

With the advent of zone recording only sector size, total
sector count and head count have any meaning and head count
is often false so that other geometry numbers will fit into
specified field sizes.  You cannot fit 255 heads in a half
height 3.5" drive.  Therefore cylinder boundaries are
illusory and should be ignored when partitioning if the
partition table allows LBA addressing.

Partition definition is not a kernel function.  It is user space.

badblocks is, as Andries reports, user space, not kernel.
If you read the manpage for badblocks you will see
       -b block-size
	     Specify the size of blocks in bytes.
So even badblocks doesn't need changing to work with
partitions having (sector_count % 8 != 0).

This sounds like an install script problem to me.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

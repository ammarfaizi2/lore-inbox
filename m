Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVESToH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVESToH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 15:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVESToH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 15:44:07 -0400
Received: from chaos.egr.duke.edu ([152.3.195.82]:2433 "EHLO
	chaos.egr.duke.edu") by vger.kernel.org with ESMTP id S261229AbVESTn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 15:43:56 -0400
Date: Thu, 19 May 2005 15:43:48 -0400 (EDT)
From: Joshua Baker-LePain <jlb17@duke.edu>
X-X-Sender: jlb@chaos.egr.duke.edu
To: Gregory Brauer <greg@wildbrain.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Jakob Oestergaard <jakob@unthought.net>, Chris Wedgwood <cw@f00f.org>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
In-Reply-To: <428BA8E4.2040108@wildbrain.com>
Message-ID: <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org>
 <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org>
 <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
 <428BA8E4.2040108@wildbrain.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005 at 1:43pm, Gregory Brauer wrote

> Joshua Baker-LePain wrote:
> > Do you have a test case that would show this up?  I've been testing a 
> > centos-4 based server with the RH-derived 2.6.9-based kernel tweaked to 
> > disable 4K stacks and enable XFS and haven't run into any issues yet.  
> > This includes running the parallel IOR benchmark from 10 clients (and 
> > getting 200MiB/s throughput on reads).
> > 
> 
> We first saw the problem after 5 days in production, but since then
> we took the server out of production and used the script
> nfs_fsstress.sh located in this package:
> 
> http://prdownloads.sourceforge.net/ltp/ltp-full-20050505.tgz?download
> 
> We run the script on 5 client machines that are running RedHat 9
> with kernel-smp-2.4.20-20.9 and nfs-utils-1.0.1-3.9.1.legacy and
> are NFS mounting our 2.6 kernel server.  The longest time to OOPS

My clients are all RHEL3.  I'll give the nfs_fsstress scripts a shot.

> has been about 8 hours.  We have not tried the parallel IOR
> benchmark.  (Where can we get that?)

http://www.llnl.gov/asci/purple/benchmarks/limited/ior/

> You didn't mention if you are using md at all.  We have a
> software RAID-0 of 4 x 3ware 8506-4 controllers running the
> latest 3ware driver from their site.  The filesystem is XFS.
> The network driver is e1000 (two interfaces, not bonded).  The
> system is a dual Xeon.  We upped the number of NFS daemons
> from 8 to 64.  The nfs_fsstress.sh client mounts the servers
> both UDP and TCP, and our in-production oops likely happened
> with a combination of both protocols in use simultaneously as
> well.  We've seen the OOPS with both the default and with 32K
> read and write NFS block sizes.  The machine was stable for
> over a year with RedHat 9 and 2.4.20.

The server I'll be testing is dual Xeon, 2GB RAM, 2 x 3ware 9500-12 
controllers running the 9.1.5.2 firmware and using the stock centos-4 
drivers.  (I see a huge performance hit using the latest 3ware driver set, 
9.2.)  The 3wares are doing hardware RAID5, and I do software RAID0 across 
'em.  Networking is the same -- 2 e1000s, not bonded.  I'm running 256 NFS 
daemons, well, just because.

-- 
Joshua Baker-LePain
Department of Biomedical Engineering
Duke University

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGLREY>; Fri, 12 Jul 2002 13:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGLREX>; Fri, 12 Jul 2002 13:04:23 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:4340 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316675AbSGLREX>; Fri, 12 Jul 2002 13:04:23 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 12 Jul 2002 11:05:32 -0600
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020712170532.GI8738@clusterfs.com>
Mail-Followup-To: Dax Kelson <dax@gurulabs.com>,
	linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026490866.5316.41.camel@thud>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 12, 2002  10:21 -0600, Dax Kelson wrote:
> ext3 data=ordered
> ext3 data=writeback
> reiserfs
> reiserfs notail
> 
> http://www.gurulabs.com/ext3-reiserfs.html
> 
> Any suggestions or comments appreciated.

Did you try data=journal mode on ext3?  For real-life workloads sync-IO
workloads like mail (e.g.  not benchmarks where the system is 100% busy)
you can have considerable performance benefits from doing the sync IO
directly to the journal instead of partly to the journal and partly to
the rest of the filesystem.

The reason why "real life" is important here is because the data=journal
mode writes all the files to disk twice - once to the journal and again
to the filesystem, so you must have some "slack" in your disk bandwidth
in order to benefit from this increased throughput on the part of the
mail transport.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


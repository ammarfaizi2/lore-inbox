Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSIYSAq>; Wed, 25 Sep 2002 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262041AbSIYSAq>; Wed, 25 Sep 2002 14:00:46 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:13566 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262040AbSIYSAp>; Wed, 25 Sep 2002 14:00:45 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 25 Sep 2002 12:03:55 -0600
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop device broken in 2.5.38
Message-ID: <20020925180355.GD22795@clusterfs.com>
Mail-Followup-To: tytso@mit.edu, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17uG42-0002gm-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17uG42-0002gm-00@think.thunk.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2002  13:35 -0400, tytso@mit.edu wrote:
> The loop device driver was broken in 2.5.38 when it was converted over
> to use gendisk.  I discovered this while doing final regression testing
> on the ext3 htree code.
> 
> The problem is that figure_loop_size() is setting the capacity of the
> loop device in kilobytes (because that's what compute_loop_size()
> returns), but set_capacity() expects the size in 512 byte sectors.
> 
> I've enclosed a patch which fixes the problem, as well as simplifying
> the code by eliminating compute_loop_size(), since it is a static
> function is only used once by figure_loop_size().

Is there a historic reason why we pre-compute and store the loop device
size instead of re-calculating it each time we do a BLKGETSZ ioctl?
Re-calculating it each time allows you to increase the size of the
backing file if needed while it is in use, and I don't think we actually
get the size of the loop device very often, so it is not a big deal,
especially given the simple calculation needed.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


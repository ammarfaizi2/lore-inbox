Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbTERWpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTERWpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:45:41 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:59630 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262247AbTERWpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:45:39 -0400
Date: Sun, 18 May 2003 16:57:18 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] fast EA for ext3
Message-ID: <20030518165718.B11651@schatzie.adilger.int>
Mail-Followup-To: Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <87n0hkmbiw.fsf@gw.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87n0hkmbiw.fsf@gw.home.net>; from bzzz@tmi.comex.ru on Sun, May 18, 2003 at 05:04:39PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2003  17:04 +0000, Alex Tomas wrote:
> this patch implements possibility to store EA into inode body
> which may be larger 128 bytes in 2.5 kernel.

What Alex didn't mention was the reason why we developed this patch in the
first place - speed.  Storing EAs in external blocks is slow, and if you
have a lot of inodes with external EAs it is fatal, as the EA blocks consume
so much RAM that they force all of the inode/directory data out of cache.


Some benchmarks (from Alex):
> environment for  old EA: just mkfs'ed EXT3, inode size 128, 33000 files
> environment for fast EA: just mkfs'ed EXT3, inode size 256, 33000 files
> 
>                      old EA       fast EA
> add attributes       2m35.241s    1m4.151s   (+142%)
> dump attributes      0m28.716s    0m13.466s  (+113%)
> change attributes    2m42.108s    1m4.413s   (+153%)
> remove attributes    1m15.373s    1m3.909s   (+19%)

Some minor improvements could be made, such as not storing user EAs inside
the inode if there are system EAs that could be stored there.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


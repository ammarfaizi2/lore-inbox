Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWCXTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWCXTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCXTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:31:29 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:59832 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964801AbWCXTb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:31:27 -0500
Date: Fri, 24 Mar 2006 12:31:25 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Valerie Henson <val_henson@linux.intel.com>,
       pbadari@gmail.com, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net, arjan@linux.intel.com, tytso@mit.edu,
       zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324193125.GL14852@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Valerie Henson <val_henson@linux.intel.com>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, tytso@mit.edu, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324104818.0016c2f2.akpm@osdl.org> <1143227599.4561.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143227599.4561.139.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006  11:13 -0800, Mingming Cao wrote:
> There are reasons for zeroing indirect blocks on truncate: 
> 
>       * There are limits to the size of a single journal transaction
>         (1/4 of the journal size). When truncating a large fragmented
>         file, it may require modifying so many block bitmaps and group
>         descriptors that it forces a journal transaction to close out,
>         stalling the unlink operation.
>       * Because of this per-transaction limit, truncate needs to zero
>         the [dt]indirect blocks starting from the end of the file, in
>         case it needs to start a new transaction in the middle of the
>         truncate (ext3 guarantees that a partially-completed truncate
>         will be consistent/completed after a crash).
>       * The read/write of the file's [dt]indirect blocks from the end of
>         the file to the beginning can take a lot of time, as it does
>         this in single-block chunks and the blocks are not contiguous.

See my recent post on how this performance problem could be fixed.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWC3UTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWC3UTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWC3UTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:19:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:61658 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750804AbWC3UTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:19:03 -0500
Subject: Re: [Ext2-devel] [BENCHMARK] fswide dirty bit for ext2
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Zach Brown <zach.brown@oracle.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20060329065724.GD16173@goober>
References: <20060329065724.GD16173@goober>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 30 Mar 2006 12:18:49 -0800
Message-Id: <1143749930.3896.59.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 22:57 -0800, Valerie Henson wrote:
> I am working on a file system wide dirty bit for ext2.  This allows
> you to skip a full fsck if you crash while the file system is not
> being actively modified.
> 
> Zach Brown was kind enough to run a few benchmarks comparing various
> versions of ext2 and ext3.  Results:
> 
>            ext2   ext2r *ext2fw*   ext3  ext3wb
> kuntar    17.86   19.59   17.58   21.10   30.60
> postmark   6.41    6.57    8.48   30.87   15.47
> tiobench  34.11   34.96   34.26   34.00   34.06
> 
> ext2: ext2: 4k blocks, noatime
> ext2r: ext2: 4k blocks, noatime, reservations
> ext2fw: ext2: 4k blocks, noatime, reservations, fswide
> ext3: ext3: 4k blocks, 256m journal, noatime
> ext3wb: ext3: 4k blocks, 256m journal, noatime, data=writeback
> kuntar: expanding a cached uncompressed kernel tarball and syncing
> postmark: postmark: numbers = 10000, transactions = 10000
> tiobench: tiobench: 16 threads, 256m size
> 
> The summary is that ext2+fswide bit is the same as plain ext2 except
> 30% slower on postmark.  Slower postmark is expected given the orphan
> inode list requires at least two writes to either the superblock or
> another inode per file removal.  An obvious improvement would be
> per-block group orphan inode lists, which would require a non-trivial
> but not frightening patch to fsck. (This might also be ported to
> ext3.) Other ideas?
> 
> I split out the ext2 reservations port into its own patch.
> ext2+reservations alone is strangely slower than ext2+fswide on one
> benchmark; I did some preliminary debugging but didn't find anything
> obvious wrong as yet.  The patches are available for anyone who wants
> to track this down themselves before I get around to it.
> 
Patch looks fine from 5 minutes review. I will look more closely at your
port later. Does this regression on kuntar tests happened on ext3 also?

> Patches against 2.6.16-rc5-mm3 here:
> 
> Fswide bit (includes reservations):
> 
> http://infohost.nmt.edu/~val/patches/fswide_shorter_patch
> 
> Reservations only:
> 
> http://infohost.nmt.edu/~val/patches/resv_only_patch
> 
> -VAL
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel


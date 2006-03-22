Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWCVSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWCVSSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWCVSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:18:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:42402 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932312AbWCVSSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:18:48 -0500
Subject: Re: [Ext2-devel] Re: [RFC] [PATCH] Reducing average ext2 fsck time
	through fs-wide dirty bit]
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Valerie Henson <val_henson@linux.intel.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@linux.intel.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Zach Brown <zach.brown@oracle.com>
In-Reply-To: <1143032930.3584.5.camel@localhost.localdomain>
References: <20060322011034.GP12571@goober>
	 <1143032930.3584.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 22 Mar 2006 10:18:45 -0800
Message-Id: <1143051525.3884.16.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 13:08 +0000, Alan Cox wrote:
> On Maw, 2006-03-21 at 17:10 -0800, Valerie Henson wrote:
> > The combination of the orphan inode and preallocation blocks problem
> > led me to another idea: create in-memory-only allocation bitmaps for
> > both inodes and blocks.  
> 
> This was actually done by Interactive Unix long ago to get sane
> performance of System 5 file systems which didnt directly use bitmaps.
> 
> I suspect you don't need a complete in memory bitmap list however, you
> just need an exceptions table of extents that are preallocated.
> Furthermore you can bound this by either releasing oldest preallocations
> or refusing new ones when you hit some kind of resource bound.
> 

This is pretty much what ext3 block reservation does, every inode has a
range of disk blocks(or call it extent) that are reserved (or call it
preallocated). 

> Similarly for inodes, except that you actually have the in memory
> exception list in the ext2 inodes in memory already (no inode is orphan
> unless open) so you may only need another list pointer to walk the
> orphans
> 
> Alan
> 
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


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWCVNCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWCVNCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWCVNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:02:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30669 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750843AbWCVNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:02:15 -0500
Subject: Re: [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide
	dirty bit]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Arjan van de Ven <arjan@linux.intel.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060322011034.GP12571@goober>
References: <20060322011034.GP12571@goober>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Mar 2006 13:08:50 +0000
Message-Id: <1143032930.3584.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-21 at 17:10 -0800, Valerie Henson wrote:
> The combination of the orphan inode and preallocation blocks problem
> led me to another idea: create in-memory-only allocation bitmaps for
> both inodes and blocks.  

This was actually done by Interactive Unix long ago to get sane
performance of System 5 file systems which didnt directly use bitmaps.

I suspect you don't need a complete in memory bitmap list however, you
just need an exceptions table of extents that are preallocated.
Furthermore you can bound this by either releasing oldest preallocations
or refusing new ones when you hit some kind of resource bound.

Similarly for inodes, except that you actually have the in memory
exception list in the ext2 inodes in memory already (no inode is orphan
unless open) so you may only need another list pointer to walk the
orphans

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWFJSB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWFJSB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWFJSB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:01:27 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:42369 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030472AbWFJSB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:01:26 -0400
Date: Sat, 10 Jun 2006 12:01:32 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, Mike Snitzer <snitzer@gmail.com>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610180132.GB5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, Mike Snitzer <snitzer@gmail.com>,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org
References: <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com> <20060610134946.GC11634@stusta.de> <20060610135122.GA9039@infradead.org> <448ADD15.3040109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448ADD15.3040109@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2006  10:54 -0400, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> >Alex mentioned a few times that the extents code just adds three if.
> >I'm pretty sure that will not give you any regressions in the existing
> >codebase.  Can we concentrate on the more useful discussion topics now?
> 
> Alex is off by an order of magnitude.  I've re-read the 13-patch series, 
> and this is the result of the review:

Thanks for at least looking at the code, which was the intention of posting
the patches...  It caused quite a few more ruffled feathers than we expected.

> Three added in extent map support.

As Christoph quoted Alex, "the extents code", which you confirm is 3 "ifs".

> There are _five_ "if (new) .. else .." constructs added in JBD alone.

Actually, 64-bit support in the JBD code was written by Zach Brown
for OCFS, so I think they want this patch into the kernel regardless.
It's relatively simple change though - all conditional on a single flag.

> Twenty-seven (27) such constructs in 48-bit physical block support.

Though there are really only 2 conditionals (in macros, one for read and
one for write) that are used everywhere, so it's not as bad as it seems.

> Two more in 48-bit ACL support.
> 
> And finally, the superblock changes don't add any branches, like the 
> other code does, but it does double the endian conversion work that 
> -every- user must do, even if they don't use 48bit at all.

These are all related to 48-bit filesystem support, not strictly
extents.  Much of the 48-bit code is dependent upon CONFIG_LBD or
sizeof(ext3_fsblk_t), so if people have no desire to use large (2TB+) or
larger (16TB+) filesystems these conditionals disappear at compile time.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWFJOWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWFJOWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWFJOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:22:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33210 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030393AbWFJOWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:22:19 -0400
Message-ID: <448AD590.40005@garzik.org>
Date: Sat, 10 Jun 2006 10:22:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Valerie Henson <val_henson@linux.intel.com>
CC: Matthew Wilcox <matthew@wil.cx>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Continuation Inodes Explained! (was Re: [Ext2-devel] [RFC 0/13]
 extents and 48bit ext3)
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <20060609153116.GM1651@parisc-linux.org> <20060610032623.GG10524@goober>
In-Reply-To: <20060610032623.GG10524@goober>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valerie Henson wrote:
> So what the heck are continuation inodes?  Actually, we named this
> "chunkfs" - not particularly descriptive, maybe continuation inodes is
> a better term.
[...]
> The basic idea is to create a bunch of small file systems - chunks -
> which look like one big file system to the administrator.  Major

Back when I was still playing with my experimental filesystem, one of 
the short-list features I was planning on implementing was the 
allocation of both metadata and data from the same underlying data 
store, essentially collections of "buckets" for data.

The data store would be a succession of progressively-smaller buckets. 
Typical bucket sizes (chosen by admin) on a single filesystem might be: 
1G, 128M, 4M, 1M, 64k, 4k.  The largest (top-most) bucket is the 
fundamental unit of allocation for the filesystem, from which all other 
metadata and data is read/allocated.

So in my example above, the 1G bucket is analagous to a single chunk in 
chunkfs, and any number of 1G buckets -- from any number of block 
devices -- may comprise a single filesystem.

New inode tables, bitmap chunks, directories, large files, etc. are all 
allocated from an "appropriate" bucket.  IMO this type of solution 
provides fsck-friendly isolation, and adds sufficient flexibility for 
doing things like delayed alloc, metadata-is-a-file, etc.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWEKQEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWEKQEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWEKQEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:04:43 -0400
Received: from palrel13.hp.com ([156.153.255.238]:41702 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1030303AbWEKQEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:04:42 -0400
Date: Thu, 11 May 2006 11:04:17 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] make kernel ignore bogus partitions
Message-ID: <20060511160417.GA7730@beardog.cca.cpqcorp.net>
References: <20060503210055.GB31048@beardog.cca.cpqcorp.net> <20060509124138.43e4bac0.akpm@osdl.org> <20060509224848.GA29754@apps.cwi.nl> <20060511040014.66ea16fc.akpm@osdl.org> <20060511115117.GA870@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511115117.GA870@apps.cwi.nl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 01:51:17PM +0200, Andries Brouwer wrote:
> On Thu, May 11, 2006 at 04:00:14AM -0700, Andrew Morton wrote:
> 
> > > Yes, it should.
> > > And no "ignoring". And no "continue". E.g.:
> > > 
> > > 	printk(" %s: warning: p%d exceeds device capacity.\n", ...);
> > > 
> > 
> > So you're saying that after detecting this inconsistency we should proceed
> > to use the partition anyway?
> > 
> > For what reason?
> 
> The normal situation is that partitions are contained within
> the disk. In the normal situation the test is superfluous.
> 
> Suppose the test fails. Why might that be? There isn't really
> a good scenario where this is a mistake. In all the (rare) cases
> that I can imagine, it would make matters worse to reject the
> partition and make access impossible (or at least more difficult).
> 
> Case 1: The kernel is mistaken about the size of the disk.
> (There are commands to clip a disk to a certain capacity,
> there are jumpers to tell a disk that it should report a certain
> capacity etc. Usually this is because of BIOS bugs. In bad cases
> the machine will crash in the BIOS and hence fail to boot if
> the disk reports full capacity.)
> In such cases actually accessing the blocks of the partition
> may work fine, or may work fine after running an unclip utility.
> I wrote "setmax" some years ago precisely for this reason.
> 
> Case 2: There was a messy partition table (maybe just a rounding
> error) but the actual filesystem on the partition is contained
> in the physical disk. Now using the filesystem goes without problem.
> 
> Case 3: Both partition and filesystem extend beyond the end of the disk.
> In forensic or debugging situations one often uses a copy of the start
> of a disk. Now access beyond the end gives an expected I/O error.


Continuing to use the partition will result in io errors when accessing 
any block that is past the end of the physical device. We see this as
unacceptable. Why would it make matters worse to prevent access to the
partition? The partition _should_ be correct.

mikem

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTLET7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbTLET7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:59:35 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:53748 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264376AbTLET64
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:58:56 -0500
Subject: Re: partially encrypted filesystem
From: Pat LaVarre <p.lavarre@ieee.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>
In-Reply-To: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
References: <20031205112050.GA29975@wohnheim.fh-wedel.de>
	 <200312051616.hB5GGpef027492@agora.fsl.cs.sunysb.edu>
	 <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1070654324.12411.478.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Dec 2003 12:58:44 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2003 19:58:55.0429 (UTC) FILETIME=[36A61F50:01C3BB6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... but I don't think Linux has very good support for filesystems that
> want to drop 64 pages into the page cache when the VM/VFS only asked
> for one.
> 
> If it did, that would allow ext2/3 to grow block sizes beyond the
> current 4k limit on i386, which would be a good thing to do.  Or
> perhaps we just need to bite the bullet and increase PAGE_CACHE_SIZE
> to something bigger, like 64k.  People are going to want that on
> 32-bit systems soon anyway.

Issue now yes.  Three pieces of evidence:

1)

I hear CD-RW commonly report 64 KiB per write block, DVD-RAM/ DVD+RW
often report 32 KiB per write block.

2)

http://marc.theaimsgroup.com/?l=linux-scsi&m=106700651518749
Subject:  Re: aligned /dev/scd$n reads less rare how
Date: 2003-10-24 14:41:16
is me saying a naive lk 2.6 test like `dd if=/dev/scd0 bs=1M` doesn't
yet improve read thruput by polite alignment, much less improve write
thruput by polite alignment.

Specifically I see we lose alignment in the second cdb and following,
til the end of the disc.

3)

http://marc.theaimsgroup.com/?l=linux-scsi&m=107004995921559
Subject: cdrom sr ide-cd - CDC_WR, 1999 op x46 GPCMD_GET_CONFIGURATION
Date: 2003-11-28 20:05:03
is me saying cdrom.ko does not yet fetch via SCSI over whatever (USB2HS/
ATAPIUDMA133/ 1394a/ ...) the 1999 ANSI T10 standard plug 'n play
descriptor that distinguishes the 32/64 KiB bytes per write block from
the 2 KiB bytes per read block.  (Relevant patches appear incomplete,
nearby.)

Pat LaVarre



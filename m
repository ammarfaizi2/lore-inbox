Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSG3UEA>; Tue, 30 Jul 2002 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSG3UEA>; Tue, 30 Jul 2002 16:04:00 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:41672 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S316342AbSG3UD4>; Tue, 30 Jul 2002 16:03:56 -0400
Date: Tue, 30 Jul 2002 15:07:18 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
In-Reply-To: <200207191332.IAA65963@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.33.0207301447130.28219-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Jesse Pollard wrote:
[snip]
> In even earlier OSs (DEC RSX, TOPS 10) the file index table was actually a file
> in the filesystem (usually named index.idx (or was it file.idx...).

INDEXF.SYS, on TOPS-10.

>                                                                     I don't
> know what it was called in MULTICs where the UNIX varient would have
> started.
>
> Most of these filesystems were based on contigeuous allocation, or allocations
> of contigeous segments.

"Extents".  "Segments" were contiguous hunks of real memory that the MMU
knew about, then as now.

TOPS-20 used pagemaps.  A file on disk had a pagemap block filled with
special invalid PTEs which pointed to the data blocks.  To open a file,
locate its pagemap and page that in, then make references through it and
the pager will pull in the data for you and update the map page.  (This is
all separate from mapping a file over *process* virtual memory, but I seem
to recall that PMAP% borrowed a lot of code from the disk I/O subsystem in
this case.  It's been 20 years, though....)  TOPS-20 happily scattered
file blocks all over the volume-set if need be.

[snip]
> Note - the version number had nothing to do with the file version -
> it was used to aid file recovery and was only a reuse count of the index
> node. The index node contents had to have the same version number as the
> directory entry, or the directory entry was considered invalid. The
> file name was a rad50, or sixbit (packed) characters, and sometimes was
> stored in both inode and directory - again, for rebuilding the file system.

No, RAD50 and SIXBIT are different.  You can (de)compose SIXBIT words with
simple shift-and-mask operations, but RAD50 requires arithmetic.  (Hmmm,
on TOPS-10 we called it RADIX50, so maybe it's different.)

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Who just last weekend rediscovered an MF10 core-plane hiding in the filing
cabinet.


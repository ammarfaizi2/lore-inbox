Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265941AbRGFEDn>; Fri, 6 Jul 2001 00:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbRGFEDd>; Fri, 6 Jul 2001 00:03:33 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:16392 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265941AbRGFEDV>;
	Fri, 6 Jul 2001 00:03:21 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107060403.f66431H81627@saturn.cs.uml.edu>
Subject: Re: max sizes for files and file systems
To: derek@cynicism.com (Derek Vadala)
Date: Fri, 6 Jul 2001 00:03:01 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0107052009500.28636-100000@gecko.roadtoad.net> from "Derek Vadala" at Jul 05, 2001 08:17:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Vadala writes:

> It's clear that under 2.4, the kernel imposes a limit of 2TB as the
> maximum file size and that some portion of the kernels before 2.4 had a
> limit of 2GB.
>
> However, it's not clear to me when the file size limit was increased, or
> what the maximum file system sizes under 2.0, 2.2 and 2.4 are. I realize
> that both of these values are also contingent on the filesystem used, but
> I'm wondering about what limits the kernel itself imposes. 
> 
> I'm also a bit unclear as to where the 2GB limit in kernels < 2.4 comes
> from. It appears to be a kernel imposed limit, but there also seems to be
> a lot conflicting information out there, blaming the problem on
> EXT2. However, from what I can tell, 2.0.39, 2.2.19 and 2.4.5 all use the
> same version (0.5b-95/08/09) of ext2-- either that or EXT2FS_VERSION and
> EXT2FS_DATE in .../include/linux/ext2_fs.h simply haven't been updated.

No 32-bit Linux system could exceed 1 TB on anything until this week.
This is caused by signed 32-bit math on units of 512 bytes.
Now there are experimental patches for larger devices.

The file access API was limited to signed 32-bit byte values.
Officially, this was fixed for the 2.4 series. Most distributions
shipped 2.2 series kernels with patches to allow large files.

The ext2, FAT, and NFSv2 filesystems all had a 32-bit file
size limit. For ext2 this was lifted just as the 2.2 series
came out, but only Alpha systems could use the large files.
FAT has not been fixed. NFSv2 has been replaced by NFSv3.

EXT2FS_VERSION has not been updated because feature flag bits
are being used instead.

I have a graph of ext2 limits:
http://www.cs.uml.edu/~acahalan/linux/ext2.gif


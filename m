Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJQUXt>; Thu, 17 Oct 2002 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSJQUXt>; Thu, 17 Oct 2002 16:23:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1272 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261728AbSJQUXp>;
	Thu, 17 Oct 2002 16:23:45 -0400
Importance: Normal
Sensitivity: 
Subject: statfs64 missing
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF6D978045.B4B59726-ON87256C55.006F1ED5@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Thu, 17 Oct 2002 15:28:51 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/17/2002 02:29:42 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting question for other distributed filesystems as well, not just
NFS.
There are two calls sent in the CIFS case to get this info.  One requesting
"FILE_SYSTEM_ATTRIBUTE_INFO" to get f_namelen (which presumably does not
vary so does not need to be requeried every statfs and the field length is
big enough
as is) and "FILE_SYSTEM_INFO" which returns 64 bit quantities for Total and
Free
"Allocation Units" and  then a  32 bit quantity for Sectors per Allocation
Unit
and a 32 bit quantity for bytes for sector.   With big SAN based arrays of
disks
running under some of the high end CIFS based server appliances from
EMC, NetApp etc. it would not be surprising to me to see an overflow
problem for
the 32 bit statfs fields today (mapping from the values in the
FILE_SYSTEM_INFO
returned by the server to statfs struct on i386 clients) unless the local
fs lies
about the block size.   For the cifs vfs adding a statfs64 func would
certainly
be technically feasible from the protocol's perspective and pretty easy.

> 2.5 has 64bit sector_t but no statfs64() system call for
>32bit architectures. How is df supposed to report it? statfs
> uses 32bit block counts.
>
>The currently limit depends on the block size, the bigger your
>block size the more bytes it can report.
>
> You can actually access NFS servers which have more
> than 2TB of disk space. NFS uses the local write size
> as block size. When you are lucky then 0xfffffffff*wsize
> is bigger than what your NFS server reports. If not
> you get wrong results.
>
> -Andi


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com



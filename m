Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUDHWqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUDHWqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:46:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:14007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbUDHWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:46:06 -0400
Date: Thu, 8 Apr 2004 15:47:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: kenneth.w.chen@intel.com, raybry@sgi.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: HUGETLB commit handling.
Message-Id: <20040408154742.3faf7141.akpm@osdl.org>
In-Reply-To: <15037082.1081445730@42.150.104.212.access.eclipse.net.uk>
References: <15037082.1081445730@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> We have been looking at the HUGETLB page commit issue (offlist) and are
> close a final merged patch.

Be aware that I've merged a patch from Bill which does all the hugetlb code
unduplication.  A thousand lines gone:

 25-akpm/arch/i386/mm/hugetlbpage.c    |  264 ----------------------------------
 25-akpm/arch/ia64/mm/hugetlbpage.c    |  251 --------------------------------
 25-akpm/arch/ppc64/mm/hugetlbpage.c   |  257 ---------------------------------
 25-akpm/arch/sh/mm/hugetlbpage.c      |  258 ---------------------------------
 25-akpm/arch/sparc64/mm/hugetlbpage.c |  259 ---------------------------------
 25-akpm/fs/hugetlbfs/inode.c          |    2 
 25-akpm/include/linux/hugetlb.h       |    7 
 25-akpm/kernel/sysctl.c               |    6 
 25-akpm/mm/Makefile                   |    1 
 25-akpm/mm/hugetlb.c                  |  245 +++++++++++++++++++++++++++++++
 10 files changed, 263 insertions(+), 1287 deletions(-)

Of course, this buggers up everyone else's patches, but I do think this
work has to come first.

I still need to test this on ppc64 and ia64.  I've dropped a rollup against
2.6.5 at http://www.zip.com.au/~akpm/linux/patches/stuff/mc3.bz2 which you
should work against until I get -mc3 out for real.


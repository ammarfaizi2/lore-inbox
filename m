Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262931AbTDAX2y>; Tue, 1 Apr 2003 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbTDAX2y>; Tue, 1 Apr 2003 18:28:54 -0500
Received: from [12.47.58.55] ([12.47.58.55]:10865 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262931AbTDAX2x>;
	Tue, 1 Apr 2003 18:28:53 -0500
Date: Tue, 1 Apr 2003 15:39:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [patch][rfc] Memory Binding (1/1)
Message-Id: <20030401153945.17d26219.akpm@digeo.com>
In-Reply-To: <3E8A151A.1040800@us.ibm.com>
References: <3E8A135B.3030106@us.ibm.com>
	<3E8A151A.1040800@us.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 23:40:11.0344 (UTC) FILETIME=[0943FD00:01C2F8A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson <colpatch@us.ibm.com> wrote:
>
> Okee dokee...  Here's the real core of the patch.

Looks saneish to me.  I'd like to see thorough benchmark results when it is
complete.  And it would be nice to make address_space.binding go away if
!CONFIG_NUMA.

The explicit knowledge of ZONE_DMA/ZONE_NORMAL/ZONE_HIGHMEM in get_zonetype()
should not be necessary - you don't want it to explode if ZONE_DMA32 is
added.  It should be indexing into node_zonelists in some manner.

Will this code work if all memory is in ZONE_DMA, as some architectures do?

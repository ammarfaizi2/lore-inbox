Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUG2LMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUG2LMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUG2LMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:12:20 -0400
Received: from [217.67.22.1] ([217.67.22.1]:18663 "EHLO mail.6com.net")
	by vger.kernel.org with ESMTP id S264153AbUG2LMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:12:18 -0400
Date: Thu, 29 Jul 2004 13:12:17 +0200
From: Jan Oravec <jan.oravec@6com.sk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LSI 53c1030 (Fusion MPT) performance with O_SYNC
Message-ID: <20040729111217.GA29466@omega.6com.net>
Reply-To: Jan Oravec <jan.oravec@6com.sk>
References: <20040729095648.GA27925@omega.6com.net> <1091095493.2792.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091095493.2792.6.camel@laptop.fenrus.com>
X-Operating-System: UNIX
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 12:04:53PM +0200, Arjan van de Ven wrote:
> On Thu, 2004-07-29 at 11:56, Jan Oravec wrote:
> 
> > I've noticed poor performance with MySQL/InnoDB when compared to another
> > S2880-based box with IDE disks.
> 
> your ide disk probably has write back caching enabled while your
> mptfusion doesn't..... if you value data integrity over performance the
> mptfusion has a saner default ;)

It was enabled:

# sginfo -c /dev/sda
Caching mode page (0x8)
-----------------------
Initiator Control                  0
ABPF                               0
CAP                                0
DISC                               1
SIZE                               0
Write Cache Enabled                1
MF                                 0
Read Cache Disabled                0
Demand Read Retention Priority     0
Demand Write Retention Priority    0
Disable Pre-fetch Transfer Length  65535
Minimum Pre-fetch                  0
Maximum Pre-fetch                  0
Maximum Pre-fetch Ceiling          65535
FSW                                1
LBCSS                              0
DRA                                0
Number of Cache Segments           8
Cache Segment size                 0
Non-Cache Segment size             0

When I've disabled it on both mptfusion and IDE, it took 40s on mpt and 83s
on IDE.

It seems like write-cache is not as effective on mptfusion as it is on IDE?

I am considering plugging there a ZCR with battery, so write-cache has a
sense for me.


Jan

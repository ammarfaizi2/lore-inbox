Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSH1Rz5>; Wed, 28 Aug 2002 13:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSH1Rz5>; Wed, 28 Aug 2002 13:55:57 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:5639 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316434AbSH1Rz4>; Wed, 28 Aug 2002 13:55:56 -0400
Date: Wed, 28 Aug 2002 19:59:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: ide-2.4.20-pre4-ac2.patch
Message-ID: <20020828175957.GA15860@louise.pinerecords.com>
References: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3 days, 9:59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is out and has been forwarded to AC for review.

Okay, I tested this the hard way -- the root of one of my machines
got trashed. The controller used was a PDC20268 (Ultra100TX2), the
disks (with two partitions of equal size on each forming a raid0)
are IBM and WD. Soon after the kernel came up, it started spitting
messages like 'DMA disabled' and 'No DRQ after WRITE has been issued',
after which the machine froze entirely. Rebooting w/ an alternate
kernel revealed massive fs corruption with the superblock completely
overwritten.

  *** Everybody please treat this patch with extreme care. ***

Reiserfs people, this unfortunate event also made me find out about
the inability of reiserfsck 3.6.3-pre1 to rebuild the node tree --
the program pretends to work just fine but the in-kernel fs code
barfs when it's to operate on a repaired fs. 3.x.1b was able to
get the job done for me, though.

T.

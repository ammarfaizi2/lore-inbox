Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267832AbTBVHgM>; Sat, 22 Feb 2003 02:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTBVHgM>; Sat, 22 Feb 2003 02:36:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:20883 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267832AbTBVHgL>; Sat, 22 Feb 2003 02:36:11 -0500
Date: Fri, 21 Feb 2003 23:46:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-ID: <22560000.1045899976@[10.10.2.4]>
In-Reply-To: <20030221122024.040055a0.akpm@digeo.com>
References: <32720000.1045671824@[10.10.2.4]><20030219101957.05088aa1.akpm@digeo.com><17280000.1045811967@[10.10.2.4]><17930000.1045812486@[10.10.2.4]><20030220234522.185f3f6c.akpm@digeo.com><11870000.1045848448@[10.10.2.4]> <20030221122024.040055a0.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mark_inode_dirty() tends to be called _very_ frequently.  Too frequently.
> 
> Could you try remounting all filesystems noatime with
> 
> 	mount /mnt/point -o remount,noatime
> 
> and the below patch will prevent us calling the barrier-happy
> current_kernel_time() for noatime mounts.

Cool, that works nicely - thanks.

2.5.59-mjb6:             84 __mark_inode_dirty
2.5.61-mjb1:            594 __mark_inode_dirty
2.5.61-mjb1-no_mb:       74 __mark_inode_dirty
2.5.61-mjb1-noatime:     65 __mark_inode_dirty

M.


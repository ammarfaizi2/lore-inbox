Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTBURR2>; Fri, 21 Feb 2003 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTBURR2>; Fri, 21 Feb 2003 12:17:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17868 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267597AbTBURR1>; Fri, 21 Feb 2003 12:17:27 -0500
Date: Fri, 21 Feb 2003 09:27:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-ID: <11870000.1045848448@[10.10.2.4]>
In-Reply-To: <20030220234522.185f3f6c.akpm@digeo.com>
References: <32720000.1045671824@[10.10.2.4]><20030219101957.05088aa1.akpm@digeo.com><17280000.1045811967@[10.10.2.4]><17930000.1045812486@[10.10.2.4]> <20030220234522.185f3f6c.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some more stats ... which look rather suspicious. 600% increase for
>> dentry_open and __mark_inode_dirty? Hmmmmm.
> 
> __mark_inode_dirty() just got itself an smp_mb().  Would be instructive to
> disable that.
> 
> dentry_open(): don't know - fs/open.c hasn't changed at all.  Perhaps
> dcache_rcu has caused additional pingpong?

2.5.59-mjb6             84 __mark_inode_dirty
2.5.61-mjb1            594 __mark_inode_dirty
2.5.61-mjb1-no_mb       74 __mark_inode_dirty

Yup, that fixed that one ... but presumably it was put there for a reason,
so I can't just rip it out ;-) Thanks, I'll go take a closer look at the
others.

M


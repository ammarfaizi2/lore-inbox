Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTB1Ci7>; Thu, 27 Feb 2003 21:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTB1Ci7>; Thu, 27 Feb 2003 21:38:59 -0500
Received: from h-64-105-34-105.SNVACAID.covad.net ([64.105.34.105]:35458 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267431AbTB1Ci7>; Thu, 27 Feb 2003 21:38:59 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 27 Feb 2003 18:49:13 -0800
Message-Id: <200302280249.SAA08737@adam.yggdrasil.com>
To: andrew@walrond.org
Subject: Re: Patch: 2.5.62 devfs shrink
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, Andrew Walrond wrote:
>I assume you meant devfs_helper here:

> > devfsd is not a deamon.  Instead, the new devfs invokes devfs_helper
>   ------

	Right.  I've checked in the fix.  Thanks.


>Looks good to me. I want to give this another whirl, but your latest 
>patch doesn't apply cleanly against 2.5.63+ (fs/devfs/base.c fails). Any 
>chance of an update?

	I've just come across a bug with in in 2.5.63 where
devfs_helper hangs while trying to down a semaphore.  I think it is
doing down(&dir->i_sem) in some lookup routine in fs/namei.c.
I am trying to figure out what exactly inode->i_sem protects
so I can determine if it is OK for the routine that calls
defvs_helper to release it and reacquire it when devfs_helper
exits.  Once I think I've fixed this, I'll post a new patch.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSLMAHY>; Thu, 12 Dec 2002 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbSLMAHX>; Thu, 12 Dec 2002 19:07:23 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:6071 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264986AbSLMAHX>; Thu, 12 Dec 2002 19:07:23 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Dec 2002 16:14:36 -0800
Message-Id: <200212130014.QAA00316@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, viro@math.psu.edu
Subject: Re: 2.5.51 + devfs root + SMP = lockup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm embarrassed to say that I wrote:
>	Linux 2.5.51 with SMP and devfs hangs at boot time when trying
>to find the initial root device (/dev/ram0 in my case). [...]

	This was self-inflicted.  When I removed the spontaneous
partition table rereading code from devfs, I did not notice that
get_removal_partition does a read_unlock(&parent->u.dir.lock), so I
was leaving a read lock in place where I deleted the call to this
routine.  Sorry for wasting anyone else's time with it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


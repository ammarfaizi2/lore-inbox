Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTAQNSf>; Fri, 17 Jan 2003 08:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTAQNSf>; Fri, 17 Jan 2003 08:18:35 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:15810 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267499AbTAQNSe>; Fri, 17 Jan 2003 08:18:34 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Jan 2003 05:27:23 -0800
Message-Id: <200301171327.FAA05948@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I believe I'm experiencing the same problem that Mikael Pettersson
reported, although the symptom is normally a hang with SMP, because
the bad pointer dereference in __find_symbol results in the fault
hanndler calling search_exception_tables, which calls search_module_extable,
which tries to grab the modlist_lock spinlock, but that lock was
already taken by resolve_symbol (which called __find_symbol in the first
place).

	Somone else on irc reported a similar problem when I asked.

	Thanks Mikael, for posting the kernel oops listing.  You
probably just saved me about 45 minutes of switching over to a
non-SMP kernel to check for that oops.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

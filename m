Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265185AbUD3SX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265185AbUD3SX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUD3SX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:23:28 -0400
Received: from vena.lwn.net ([206.168.112.25]:44963 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265185AbUD3SVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:21:40 -0400
Message-ID: <20040430182138.8758.qmail@lwn.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 30 Apr 2004 18:11:46 +0200."
             <200404301611.i3UGBkdK026345@harpo.it.uu.se> 
Date: Fri, 30 Apr 2004 12:21:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The change to mm/slab.c between 2.6.6-rc2-bk4 and -bk5
> broke x86-64 SMP. The symptoms are general protection
> faults in __switch_to shortly after init starts, and
> then the machine is dead. (Can't be more specific, my
> box can't log early boot oopses.)
> 
> I'm only seeing this with x86-64 SMP; x86-64 UP and i386
> SMP on the same machine (Athlon64 UP) have no problems.

FWIW, this sure looks a lot like the boot-time crash I'm seeing; I get the
same __switch_to oopses once init starts.  *But* I'm running a UP,
no-preempt kernel.  And I get it with -rc1 as well.  Might reverting the
later slab change be concealing a different problem?

jon

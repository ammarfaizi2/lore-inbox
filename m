Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUIZXvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUIZXvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIZXvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:51:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:12169 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265051AbUIZXvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:51:31 -0400
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200409262305.i8QN59b4012254@harpo.it.uu.se>
References: <200409262305.i8QN59b4012254@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1096242585.4965.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 09:49:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tested on an MPC7455 (G4-type chip). The patch applies cleanly
> to and compiles ok in 2.6.9-rc2-mm3, but 2.6.9-rc2-mm3 has
> other problems on PPC32 so I tested it with 2.6.9-rc2 vanilla.

Be careful that some G4's have a bug which can cause a
perf monitor interrupt to crash your kernel :( Basically, the
problem is if any of TAU or PerfMon interrupt happens at the
same time as a DEC interrupt, some revs of the CPU can get
confused and lose the previous exception state.

Check out the erratas, but it may be worth adding a cputable
feature bit entry to note which models have useable interrupt
and which don't.




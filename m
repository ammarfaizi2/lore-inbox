Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUCECLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 21:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbUCECLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 21:11:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:15305 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262157AbUCECLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 21:11:00 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <4047CBB3.9050608@nortelnetworks.com>
References: <40479A50.9090605@nortelnetworks.com>
	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1078452637.5700.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 13:10:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It did in 2.4, and we added a syscall to export it to userspace.  Now 
> I'm supposed to figure out what to do for 2.6, and it appears that the 
> kernel version is gone and the one in boot is screwed.

Ugh ? No, the kernel doesn't contain a routine that you can
use to flush the entire cache. It contains and use routines
to flush regions of the dcache & icache, and those can prefectly
be used in userland. In fact, none of the cache flush code is
relying on supervisor mode, you don't need to add a syscall for
that, just copy the code you need in userland.

> The only remaining ppc version of flush_data_cache is used by 
> flush_instruction_cache in arc/ppc/boot/common/util.S

That's wrong. You should flush the cache over the range
where you need it flushed. Also, there are very few reasons
why one would want to flush the dcache, so it would be interesting
to know what you are really trying to do.

> There is also another version of flush_instruction_cache implemented in 
> arch/ppc/kernel/misc.S.

That is only used on some embedded CPUs afaik.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTKHGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 01:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbTKHGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 01:49:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62364 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261614AbTKHGtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 01:49:15 -0500
Date: Sat, 8 Nov 2003 07:48:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.co.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <1068224623.1746.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0311071935390.3222@earth>
References: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org> 
 <Pine.LNX.4.56.0311070918310.18447@earth> <1068224623.1746.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Mark Gross wrote:

> Its hard for me to tell if its better to being more careful with
> throughing around the IPI's at the cost of the extra opperations within
> your kick code.

an IPI creates quite some overhead both on the source and on the target
CPU, so i think it's definitely worth this extra check. Also, with
increasingly higher load it's increasingly more likely that we can skip
the IPI (because the task might be on the runqueue but it is not
executing), so further increasing the load via additional IPIs is the
wrong answer.

> Looks correct, and works good too!  I just verified that it solves my
> signal latency issue on both my HT system and my dual PIII box. Where I
> first found the problem.

great!

	Ingo

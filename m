Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUI2Ugw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUI2Ugw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUI2Uga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:36:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34451
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269046AbUI2Uf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:35:57 -0400
Date: Wed, 29 Sep 2004 13:35:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Greg Banks <gnb@sgi.com>
Cc: jbarnes@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jeremy@sgi.com, johnip@sgi.com, netdev@oss.sgi.com
Subject: Re: [PATCH] I/O space write barrier
Message-Id: <20040929133500.59d78765.davem@davemloft.net>
In-Reply-To: <20040929103646.GA4682@sgi.com>
References: <200409271103.39913.jbarnes@engr.sgi.com>
	<20040929103646.GA4682@sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 20:36:46 +1000
Greg Banks <gnb@sgi.com> wrote:

> Ok, here's a patch for the tg3 network driver to use mmiowb().  Tests
> over the last couple of days has shown that it solves the oopses in
> tg3_tx() that I reported and attempted to patch some time ago:
> 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=108538612421774&w=2
> 
> The CPU usage of the mmiowb() approach is also significantly better
> than doing PCI reads to flush the writes (by setting the existing
> TG3_FLAG_MBOX_WRITE_REORDER flag).  In an artificial CPU-constrained
> test on a ProPack kernel, the same amount of CPU work for the REORDER
> solution pushes 85.1 MB/s over 2 NICs compared to 146.5 MB/s for the
> mmiowb() solution.

Please put this macro in asm/io.h or similar and make sure
every platform has it implemented or provides a NOP version.

A lot of people are going to get this wrong btw.  The only
way it's really going to be cured across the board is if someone
like yourself who understands this audits all of the drivers.

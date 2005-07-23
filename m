Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVGWRuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVGWRuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVGWRuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:50:12 -0400
Received: from [216.208.38.107] ([216.208.38.107]:7564 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S261242AbVGWRuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:50:10 -0400
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <Pine.LNX.4.58.0507231033370.6074@g5.osdl.org>
References: <200507230313_MC3-1-A554-6927@compuserve.com>
	 <Pine.LNX.4.58.0507231033370.6074@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 23 Jul 2005 13:46:31 -0400
Message-Id: <1122140791.3582.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-23 at 10:38 -0700, Linus Torvalds wrote:

> So maybe a few hints to the binutils people might just make them go: "try 
> this patch/cmdline flag", and solve many more problems. They likely have a 
> lot of this kind of code _already_, or have at least been thinking about 
> it.
> 
> I personally believe that there's likely a lot more to be had from code 
> (and data) layout than there is from things like alias analysis or 
> aggressive inlining.

for userland it's not that complex and exists already; basically gprof
has this analysis capability, and from that there's tooling (well I
wrote it and I'm sure others did too) to create a linker script
automatically to order things according to their gprof desired order.
This gprof based approach is taking actual runtime patterns into account
not just static callgraph analysis.

For the kernel the runtime measurement is obviously tricky (kgprof
anyone?) but the static analysis method really shouldn't be too hard.
(well I guess "optimal" will be NP complete, but "pretty damn close"
ought to be reasonable)



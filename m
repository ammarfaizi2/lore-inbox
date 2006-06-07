Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWFGAb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWFGAb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWFGAb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:31:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:22972
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751405AbWFGAb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:31:27 -0400
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: khc@pm.waw.pl, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <20060606171209.2b21dbb4.rdunlap@xenotime.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
	 <1149622813.11929.3.camel@amdx2.microgate.com>
	 <m3u06yc9mr.fsf@defiant.localdomain>
	 <20060606134816.363cbeca.rdunlap@xenotime.net>
	 <20060606140822.c6f4ef37.rdunlap@xenotime.net>
	 <m3zmgpc3ba.fsf@defiant.localdomain>
	 <20060606160745.2f88ff9c.rdunlap@xenotime.net>
	 <m3ejy1c0uw.fsf@defiant.localdomain>
	 <1149638211.2633.21.camel@localhost.localdomain>
	 <20060606171209.2b21dbb4.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 19:31:12 -0500
Message-Id: <1149640272.2633.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 17:12 -0700, Randy.Dunlap wrote:
> They are random in the sense that HDLC depends on WAN but only
> HDLC was being selected.  In theory I would have expected
> config (software) to automatically enable higher-level config
> symbols in this case (select HDLC to cause select WAN),
> but that doesn't happen

I absolutely agree, that is the way I thought it would work
as all the information to build correctly is contained in the
Kconfig files.

But, as you say, kbuild does not work that way.
Changing kbuild to do that would take more time than
I can commit, so I don't have any room to complain about it.

> , so we got some "random" config
> which isn't supported (or even valid) ("random" being "invalid"
> in this case).

Yes, the config is random, but the select statements are
specifically chosen to work with the existing kbuild.
Bottom line is the existing kbuild does not seem to
propagate reverse dependencies, so you have to explicitly
add them all with the select facility. Ugly, but not random.

In the end, it is your original patch (select WAN minus the Makefile
changes) that makes it work.

BTW: Thanks for spending your time on this (Randy and Krzysztof),
the exchange has been educational and useful.

--
Paul




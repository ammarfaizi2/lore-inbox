Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUCVAuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCVAuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:50:35 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1675
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261597AbUCVAud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:50:33 -0500
Date: Mon, 22 Mar 2004 01:51:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: m.c.p@wolk-project.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Message-ID: <20040322005124.GG3649@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <200403211105.05908@WOLK> <20040321114939.GA10787@dualathlon.random> <20040321152427.61d88cea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040321152427.61d88cea.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 03:24:27PM -0800, Andrew Morton wrote:
> I'd prefer to retain VM_RESERVED and work toward removing PageReserved(). 
> The latter has a real and measurable cost in put_page().

agreed. Unfortunately removing PageReserved won't be so trivial since
it'll be a change to userspace API too, today a PageReserved page
through fork() will act as a MAP_SHARED even if it's under a
MAP_PRIVATE, so slightly subtle userspace stuff can break then.

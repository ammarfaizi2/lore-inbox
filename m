Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265180AbUEYWXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265180AbUEYWXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEYWUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:20:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:32130 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265158AbUEYWSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:18:44 -0400
Date: Wed, 26 May 2004 02:18:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040526021845.A1302@den.park.msu.ru>
References: <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random> <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org> <20040525215500.GI29378@dualathlon.random> <Pine.LNX.4.58.0405251500250.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0405251500250.9951@ppc970.osdl.org>; from torvalds@osdl.org on Tue, May 25, 2004 at 03:01:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 03:01:55PM -0700, Linus Torvalds wrote:
> A "not-present" fault is a totally different fault from a "protection 
> fault". Only the not-present fault ends up walking the page tables, if I 
> remember correctly.

Precisely. The architecture reference manual says:
"Additionally, when the software changes any part (except the software
field) of a *valid* PTE, it must also execute a tbi instruction."

Ivan.

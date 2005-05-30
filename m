Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVE3TNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVE3TNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVE3TNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:13:01 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:38095 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261702AbVE3TL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:11:27 -0400
Date: Mon, 30 May 2005 12:11:23 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
In-Reply-To: <Pine.LNX.4.62.0505301202380.25345@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.62.0505301209010.25345@twinlark.arctic.org>
References: <20050530181626.GA10212@kvack.org> <Pine.LNX.4.62.0505301202380.25345@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, dean gaudet wrote:

> On Mon, 30 May 2005, Benjamin LaHaise wrote:
> 
> > Below is a patch that uses 128 bit SSE instructions for copy_page and 
> > clear_page.  This is an improvement on P4 systems as can be seen by 
> > running the test program at http://www.kvack.org/~bcrl/xmm64.c to get 
> > results like:
> 
> it looks like the patch uses SSE2 instructions (pxor, movdqa, movntdq)... 
> if you use xorps, movaps, movntps then it works on SSE processors as well.

oh and btw... on x86-64 you might want to look at using movnti with 64-bit 
registers... the memory datapath on these processors is actually 64-bits 
wide, and the 128-bit stores are broken into two 64-bit pieces internally 
anyhow.  the advantage of using movnti over movntdq/movntps is that you 
don't have to save/restore the xmm register set.

-dean

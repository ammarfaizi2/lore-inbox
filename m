Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVCVRmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVCVRmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCVRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:42:49 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:16008
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261463AbVCVRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:42:47 -0500
Date: Tue, 22 Mar 2005 09:41:06 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322094106.1a566aff.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503220543100.5484@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050321142650.7364fac1.davem@davemloft.net>
	<Pine.LNX.4.61.0503220543100.5484@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 05:47:13 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> > 1) start --> end straddles sparc64 address space hole
> 
> That's an interesting remark.  I hadn't noticed the signed long type.
> I believe the vma gathering in free_pgtables will have no problem with
> that, but what about the old code?  What happens if an app does a huge
> munmap straddling the address space hole?  Or is all the user address
> space below the hole?

It will BUG(), crap. :(  Good catch, I'll fix this.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVCVT0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVCVT0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVCVTZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:25:37 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:32472
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261691AbVCVTZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:25:03 -0500
Date: Tue, 22 Mar 2005 11:23:29 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       tony.luck@intel.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322112329.70bde057.davem@davemloft.net>
In-Reply-To: <20050322112125.0330c4ee.davem@davemloft.net>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
	<20050322034053.311b10e6.akpm@osdl.org>
	<Pine.LNX.4.61.0503221617440.8666@goblin.wat.veritas.com>
	<20050322110144.3a3002d9.davem@davemloft.net>
	<20050322112125.0330c4ee.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 11:21:25 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> I'm trying to analyze my traces some more.

I think I see what's going wrong.  On the first
address space traversal (free_pgd_range()), we
clear out the pgd, even though there are still
more PMD's to process in that PGD.

So the future loops never do anything since the
PGD is cleared out already.

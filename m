Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVCVX5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVCVX5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVCVX5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:57:48 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:5836
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262492AbVCVX5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:57:41 -0500
Date: Tue, 22 Mar 2005 15:56:01 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hugh@veritas.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322155601.28369fe9.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 15:53:08 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> But I'm still confused by all the math on addr/end at each
> level.  Rounding up/down at each level should presumably be
> based on the size of objects at the next level.  So the pgd
> code should round using PUD_MASK, pud should use PMD_MASK etc.
> Perhaps I missed some updates, but the version of the patch
> that I have (and the simulator) is using PMD_MASK in the
> pgd_free_range() function ... which is surely wrong.

PMD_MASK decides the smallest page table chunk, so we mask
it at the top level.

Look at the next level down in the call chain, the masking
maskes more sense there.

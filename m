Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVCVXca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVCVXca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVCVXc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:32:29 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:45238
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262417AbVCVXcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:32:16 -0500
Date: Tue, 22 Mar 2005 15:30:33 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hugh@veritas.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322153033.57a1fea6.davem@davemloft.net>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03211751@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211751@scsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 14:40:55 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> Then I don't see how we decide when to clear a pointer at each
> level.  Are there counters of how many entries are active in each
> table at all levels (pgd/pud/pmd/pte)?

No, there are no counters.

How it works is that it knows the extent in each direction
where mappings do not exist.

Once we know we have a clear span up to the next PMD_SIZE
modulo (and PUD_SIZE and so on and so forth) we know we
can liberate the page table chunks covered by such ranges.

Say we are unmapping a page at some address.  The next VMA
in the address space says where the next potentially valid
mapping resides.  The previous VMA says similarly.  If this
is the first or last VMA, we use the beginning or end of
the virtual address space as our value.

Play around with my little simulator I posted, you'll see how
it works ;-)  Actually, this is the second such simulator you
have seen Tony :-)


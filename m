Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVCWBBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVCWBBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVCWA77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:59:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:55479 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262685AbVCWA5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:57:18 -0500
Date: Wed, 23 Mar 2005 00:56:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Luck, Tony" <tony.luck@intel.com>
cc: "David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Luck, Tony wrote:
> 
> But I'm still confused by all the math on addr/end at each
> level.

You think the rest of us are not ;-?

> Rounding up/down at each level should presumably be
> based on the size of objects at the next level.  So the pgd
> code should round using PUD_MASK, pud should use PMD_MASK etc.
> Perhaps I missed some updates, but the version of the patch
> that I have (and the simulator) is using PMD_MASK in the
> pgd_free_range() function ... which is surely wrong.

It's confusing but not wrong (in principle).  It's trying to decide
immediately on entry whether it will be worth going down to the lower
levels: if even the lowest level will have no work to do, no point in
proceeding.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbUCXMSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 07:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCXMSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 07:18:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29986 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263317AbUCXMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 07:18:14 -0500
Date: Wed, 24 Mar 2004 12:18:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: nonlinear swapping w/o pte_chains [Re: VMA_MERGING_FIXUP and
    patch]
In-Reply-To: <Pine.LNX.4.44.0403240931430.7474-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403241214220.7669-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This subtlety in try_to_unmap_nonlinear_pte:

	page_map_lock(page);
	/* check that we're not in between set_pte and page_add_rmap */
	if (page_mapped(page)) {
		unmap_pte_page(page, vma, address + offset, ptep);

Harmless, but isn't our acquisition of the page_table_lock guaranteeing
that it cannot be in between set_pte and page_add_rmap?

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVF1OWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVF1OWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVF1OVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:21:10 -0400
Received: from holomorphy.com ([66.93.40.71]:28634 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261685AbVF1OTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:19:09 -0400
Date: Tue, 28 Jun 2005 07:19:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2] mm: speculative get_page
Message-ID: <20050628141903.GR3334@holomorphy.com>
References: <42C0AAF8.5090700@yahoo.com.au> <20050628040608.GQ3334@holomorphy.com> <42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627.220827.21920197.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 10:08:27PM -0700, David S. Miller wrote:
> BTW, I disagree with this assertion.  spin_unlock() does imply a
> memory barrier.
> All memory operations before the release of the lock must execute
> before the lock release memory operation is globally visible.

The affected architectures have only recently changed in this regard.
ppc64 was the most notable case, where it had a barrier for MMIO
(eieio) but not a general memory barrier. PA-RISC likewise formerly had
no such barrier and was a more normal case, with no barrier whatsoever.

Both have since been altered, ppc64 acquiring a heavyweight sync
(arch nomenclature), and PA-RISC acquiring 2 memory barriers.


-- wli

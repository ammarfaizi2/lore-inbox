Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUHSDcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUHSDcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 23:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUHSDcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 23:32:05 -0400
Received: from holomorphy.com ([207.189.100.168]:47036 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267943AbUHSDcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 23:32:01 -0400
Date: Wed, 18 Aug 2004 20:31:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: Hugh Dickins <hugh@veritas.com>, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32     and    512 cpu SMP
Message-ID: <20040819033127.GB11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	Hugh Dickins <hugh@veritas.com>,
	"David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
	benh@kernel.crashing.org, manfred@colorfullife.com,
	linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <2uexw-1Nn-1@gated-at.bofh.it> <2uCTq-2wa-55@gated-at.bofh.it> <pan.2004.08.18.23.50.13.562750@umich.edu> <20040819000151.GU11200@holomorphy.com> <Pine.GSO.4.58.0408182005080.9340@sapphire.engin.umich.edu> <20040819002038.GW11200@holomorphy.com> <Pine.LNX.4.58.0408182307400.7247@red.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408182307400.7247@red.engin.umich.edu>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, William Lee Irwin III wrote:
>> Something like this?

On Wed, Aug 18, 2004 at 11:19:25PM -0400, Rajesh Venkatasubramanian wrote:
> Yeah, something similar... A small nitpick: page_table_lock
> nests within i_mmap_lock and anon_lock.
> do_unmap() also frees page tables first and then removes vmas from
> i_mmap (and/or) anon_vma list. Is there a reason to preserve
> this ordering ?

I don't see a reason to rearrange it. We can just as easily drop and
reacquire ->page_table_lock.


-- wli

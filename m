Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUC2Nw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbUC2Nw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:52:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38558
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262518AbUC2NvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:51:19 -0500
Date: Mon, 29 Mar 2004 15:51:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa4
Message-ID: <20040329135118.GN3039@dualathlon.random>
References: <20040326082100.GB9604@dualathlon.random> <200403291636.38698.rathamahata@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403291636.38698.rathamahata@php4.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:36:38PM +0300, Sergey S. Kostyliov wrote:
> Hello Andrea,
> 
> On Friday 26 March 2004 11:21, Andrea Arcangeli wrote:
> > Fixup an hugetlbfs prio-tree truncate bug.
> > 
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4.gz
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa4/
> > 
> > Files 2.6.5-rc2-aa3/extraversion and 2.6.5-rc2-aa4/extraversion differ
> > 
> > 	Rediffed.
> > 
> > Files 2.6.5-rc2-aa3/prio-tree.gz and 2.6.5-rc2-aa4/prio-tree.gz differ
> > 
> > 	Avoid missing vmas starting at pg_off > truncate offset in
> > 	hugetlbfs truncate. From Rajesh Venkatasubramanian.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Here is what I get after one day of uptime:
> 
> ------------[ cut here ]------------
> kernel BUG at mm/objrmap.c:111!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0142ed7>]    Not tainted
> EFLAGS: 00010282   (2.6.5-rc2-aa4)
> EIP is at find_pte+0xa7/0xc0

this this is a false positive, my mistake:

out_wrong_vma:
	BUG_ON(vma->vm_file);
	goto out;


it had to be a PageAnon check instead, this is likely a MAP_PRIVATE with
an anonymous space, and the vma has been splitted.

I will change the bug check to BUG_ON(PageAnon(page)), let's see if it
triggers again then.

Many thanks for helping fixing it!

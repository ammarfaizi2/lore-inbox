Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUH1CI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUH1CI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH1CI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:08:28 -0400
Received: from ozlabs.org ([203.10.76.45]:12944 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266189AbUH1CIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:08:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16687.59671.869708.795999@cargo.ozlabs.ibm.com>
Date: Sat, 28 Aug 2004 12:08:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, davem@davemloft.net, clameter@sgi.com, ak@suse.de,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
In-Reply-To: <20040827183940.33b38bc2.akpm@osdl.org>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> hm.  What's the maximum virtual size on power5?

The hardware MMU maps a full 64-bit effective address to a physical
address (one of the (few) advantages of using a hash table :).  That's
true on all the ppc64 processors.  I'm not sure how many bits of
physical address the power5 chip uses, but it is around 50.

Under Linux we are currently limited to a 41-bit virtual address space
(2TB) for user processes, because of the three-level page tables and
the 4kB page size (the pgd and pmd entries are 32 bits).  Due to
various things the linear mapping (and thus the amount of RAM we
can use) is currently also limited to 2TB.  We can increase that
without too much pain, and we'll have to do that at some stage (no one
has yet offered us a 2TB box to play with, but the time will come, for
sure :).

Regards,
Paul.


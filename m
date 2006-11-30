Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031560AbWK3WWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031560AbWK3WWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031561AbWK3WWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:22:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:61319 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1031560AbWK3WWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:22:05 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bugme-new] [Bug 7602] New: Failure on compilation: include/asm/bitops.h:122: error: inconsistent operand constraints in an `asm' in nfs_access_add_cache()
Date: Thu, 30 Nov 2006 23:22:00 +0100
User-Agent: KMail/1.9.5
Cc: bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org,
       mjw99@ic.ac.uk
References: <200611302118.kAULIrxS011661@fire-2.osdl.org> <20061130133748.11261443.akpm@osdl.org>
In-Reply-To: <20061130133748.11261443.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611302322.00167.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
> {
> 	int oldbit;
> 
> 	__asm__(
> 		"btsl %2,%1\n\tsbbl %0,%0"
> 		:"=r" (oldbit),"+m" (ADDR)
> 		:"dIr" (nr));
> 	return oldbit;
> }
> 
> explodes with gcc-3.4.4.

Known issue.  The new form is correct and needed, but the old gcc doesn't accept
it. I haven't gotten a form that is both and correct and works on the old compiler
out of the gcc hackers I asked.

Probably need to #ifdef it.

-Andi

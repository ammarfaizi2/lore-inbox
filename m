Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWERXuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWERXuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWERXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:50:10 -0400
Received: from ozlabs.org ([203.10.76.45]:47029 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751110AbWERXuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:50:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17517.2088.150094.338667@cargo.ozlabs.ibm.com>
Date: Fri, 19 May 2006 09:50:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org, amodra@bigpond.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510.171127.42619262.davem@davemloft.net>
References: <20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
	<17506.31456.68099.57515@cargo.ozlabs.ibm.com>
	<20060510.171127.42619262.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> If you have to hide the operation so deeply like this, maybe you can
> do something similar to sparc64, by explicitly doing the per-cpu fixed
> register and offsets, and still get the single instruction relocs that
> powerpc can do for up to 64K by doing something like:
> 
> 	&per_cpu_blah - &per_cpu_base
> 
> to calculate the offset.

I don't know how to tell gcc that (&per_cpu_blah - &per_cpu_base) is a
quantity that the linker can compute and that will fit into a 16-bit
offset.  If I use an inline asm, then I have to generate the address
and let gcc dereference it, because __get_cpu_var is used both as an
lvalue and an rvalue.  That means two instructions where one would
suffice.  So there doesn't seem to be a way to get the optimal code,
unless the gcc folks are willing to add a -fkernel or something for
us. :)

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967919AbWK3ViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967919AbWK3ViA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967922AbWK3ViA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:38:00 -0500
Received: from smtp.osdl.org ([65.172.181.25]:30698 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967919AbWK3Vh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:37:59 -0500
Date: Thu, 30 Nov 2006 13:37:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org,
       mjw99@ic.ac.uk
Subject: Re: [Bugme-new] [Bug 7602] New: Failure on compilation:
 include/asm/bitops.h:122: error: inconsistent operand constraints in an
 `asm' in nfs_access_add_cache()
Message-Id: <20061130133748.11261443.akpm@osdl.org>
In-Reply-To: <200611302118.kAULIrxS011661@fire-2.osdl.org>
References: <200611302118.kAULIrxS011661@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 13:18:53 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7602
> 
>            Summary: Failure on compilation: include/asm/bitops.h:122: error:
>                     inconsistent operand constraints in an `asm' in
>                     nfs_access_add_cache()
>     Kernel Version: 2.6.19
>             Status: NEW
>           Severity: high
>              Owner: trond.myklebust@fys.uio.no
>          Submitter: mjw99@ic.ac.uk
> 
> 
> Most recent kernel where this bug did *NOT* occur: 
> 2.6.18.3
> 
> Distribution: 
> RHEL4-U2 AS
> 
> Hardware Environment:
> 8 CPU Dual Core Opteron box with 32Gb of ram 
> http://www.iwill.net/product_2.asp?p_id=90&sp=Y
> 
> Software Environment:
> RHEL4-U2
> gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)
> 
> Problem Description:
> 
> Compilation fails with the error message:
> ....
>   CC      fs/nfs/client.o
>   CC      fs/nfs/dir.o
> fs/nfs/dir.c: In function `nfs_access_add_cache':
> include/asm/bitops.h:122: error: inconsistent operand constraints in an `asm'

Seems that this:

static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
{
	int oldbit;

	__asm__(
		"btsl %2,%1\n\tsbbl %0,%0"
		:"=r" (oldbit),"+m" (ADDR)
		:"dIr" (nr));
	return oldbit;
}

explodes with gcc-3.4.4.



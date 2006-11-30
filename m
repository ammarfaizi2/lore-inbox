Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031584AbWK3Wc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031584AbWK3Wc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031585AbWK3Wc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:32:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59789 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031584AbWK3Wc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:32:57 -0500
Date: Thu, 30 Nov 2006 14:32:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org,
       mjw99@ic.ac.uk
Subject: Re: [Bugme-new] [Bug 7602] New: Failure on compilation:
 include/asm/bitops.h:122: error: inconsistent operand constraints in an
 `asm' in nfs_access_add_cache()
Message-Id: <20061130143246.4a4bb970.akpm@osdl.org>
In-Reply-To: <200611302322.00167.ak@suse.de>
References: <200611302118.kAULIrxS011661@fire-2.osdl.org>
	<20061130133748.11261443.akpm@osdl.org>
	<200611302322.00167.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 23:22:00 +0100
Andi Kleen <ak@suse.de> wrote:

> > 
> > static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
> > {
> > 	int oldbit;
> > 
> > 	__asm__(
> > 		"btsl %2,%1\n\tsbbl %0,%0"
> > 		:"=r" (oldbit),"+m" (ADDR)
> > 		:"dIr" (nr));
> > 	return oldbit;
> > }
> > 
> > explodes with gcc-3.4.4.
> 
> Known issue.  The new form is correct and needed, but the old gcc doesn't accept
> it. I haven't gotten a form that is both and correct and works on the old compiler
> out of the gcc hackers I asked.

Oh, thanks.

What does "d" do, btw?  My gcc info page only covers "x86" and says only "`d' register"

(And, more importantly, where is the best description of gcc asm constraints?)

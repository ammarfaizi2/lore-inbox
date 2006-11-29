Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758963AbWK2XPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963AbWK2XPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758965AbWK2XPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:15:45 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:41224 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1758960AbWK2XPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:15:44 -0500
Date: Wed, 29 Nov 2006 23:15:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: eranian@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] i386 add idle notifier
Message-ID: <20061129231535.GE15186@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, eranian@hpl.hp.com,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	ak@suse.de
References: <20061129162540.GL28007@frankl.hpl.hp.com> <20061129170939.GA29203@infradead.org> <20061129130944.82e3d9bb.akpm@osdl.org> <20061129221853.GD29670@frankl.hpl.hp.com> <20061129150544.ebd952f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129150544.ebd952f3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 03:05:44PM -0800, Andrew Morton wrote:
> btw, I don't think anyone promised that __test_and_set_bit is atomic wrt
> interrupts on all architectures.  Is OK for x86.

Correct.  The generic version found in include/asm-generic/bitops/non-atomic.h
is not interrupt safe:

/**
 * __test_and_set_bit - Set a bit and return its old value
 * @nr: Bit to set
 * @addr: Address to count from
 *
 * This operation is non-atomic and can be reordered.
 * If two examples of this operation race, one can appear to succeed
 * but actually fail.  You must protect multiple accesses with a lock.
 */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

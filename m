Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTEMVEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTEMVEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:04:31 -0400
Received: from holomorphy.com ([66.224.33.161]:51900 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262031AbTEMVEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:04:30 -0400
Date: Tue, 13 May 2003 14:17:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: mjacob@quaver.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4 fix to allow vmalloc at interrupt time
Message-ID: <20030513211707.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	mjacob@quaver.net, linux-kernel@vger.kernel.org
References: <20030512225654.GA27358@cm.nu> <20030513140629.I83125@mailhost.quaver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513140629.I83125@mailhost.quaver.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:11:12PM -0700, Matthew Jacob wrote:
> This fixes a buglet wrt doing vmalloc at interrupt time for 2.4.
> get_vm_area should call kmalloc with GFP_ATOMIC- after all, it's
> set up to allow for an allocation failure. As best as I read
> the 2.4 code, the rest of the path through _kmem_cache_alloc
> should be safe.

Try write_lock_irq(&vmlist_lock)/read_lock_irq(&vmlist_lock) and
passing in a gfp mask with an alternative API etc. for the interrupt
time special case. It's deadlockable without at least the locking bits.

But it's worse than that, the implicit smp_call_function() means this
is stillborn and infeasible period.



-- wli

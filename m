Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUGAP1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUGAP1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUGAP1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:27:55 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:18638 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S265930AbUGAP1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:27:47 -0400
Date: Thu, 1 Jul 2004 11:27:28 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Ian Molton <spyro@f2s.com>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040701152728.GA20634@yoda.timesys>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630235921.C1496@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 11:59:22PM +0100, Russell King wrote:
> Ok, to fill in for just this bit, the domain covering user space mappings
> always remains in "client" mode, so page protections are always checked.
> PAGE_NONE does not have the "user" bit set, so both user space accesses
> and ldrt/strt instructions will be unable to access the pages, which is
> the desired behaviour.
> 
> However, plain ldr and str instructions will access the page, but
> get_user/put_user doesn't use them, and copy_from_user/copy_to_user
> are carefully crafted to ensure that we hit the necessary permission
> checks for each page it touches on the first access.

What if CONFIG_PREEMPT is enabled, and you get preempted after that
first access, and another thread unmaps the page before you're
finished with it?

-Scott

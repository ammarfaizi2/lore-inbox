Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUGBOgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUGBOgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUGBOgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:36:31 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:56574 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S262605AbUGBOga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:36:30 -0400
Date: Fri, 2 Jul 2004 10:36:10 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Scott Wood <scott@timesys.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040702143610.GA31894@yoda.timesys>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk> <20040701152728.GA20634@yoda.timesys> <20040701235354.GD8950@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701235354.GD8950@mail.shareable.org>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 12:53:54AM +0100, Jamie Lokier wrote:
> The ARM uaccess code was written before CONFIG_PREEMPT was added, and
> this couldn't happen then.  It could panic a kernel now.  I wonder why
> it hasn't been noticed.  Maybe nobody turns on CONFIG_PREEMPT on ARM?

Given that such behavior implies some raciness in userspace, you'd
probably need either malicious or buggy user code to trigger it, and
in the latter case, you're limited to apps using threads.  Thus, it's
probably not that surprising that it hasn't been seen.

It could also happen in other rare cases, such as if the page gets
swapped out, and you get an I/O error swapping it back in, or if
forced filesystem unmounting were implemented.

-Scott

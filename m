Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUEGGRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUEGGRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUEGGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:17:23 -0400
Received: from zero.aec.at ([193.170.194.10]:31502 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263227AbUEGGRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:17:22 -0400
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, JBeulich@novell.com
Subject: Re: sys_ioctl export consolidation
References: <1SPff-rH-29@gated-at.bofh.it> <1SSw7-35a-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 07 May 2004 08:17:03 +0200
In-Reply-To: <1SSw7-35a-11@gated-at.bofh.it> (Christoph Hellwig's message of
 "Thu, 06 May 2004 17:00:15 +0200")
Message-ID: <m3fzac69sw.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> Should ioctl32 handlers in drivers really call sys_ioctl?  Calling sys_ioctl
> makes sense for ioctls that are supported by a broad range of drivers, but
> in that case the ioctl32 translation should be in the core compat code.
>
> Drivers using register_ioctl32_conversion should rather call their own
> ioctl handlers directly if you ask me.

I think it is better to call sys_ioctl always from the wrappers and
only convert the arguments. This way you are guaranteed to not get
subtle differences in behaviour. This gives a clear layering. Otherwise 
driver writers have to do this ad-hoc and only chaos can evolve from
that.

In addition this is how all the current ioctl handlers work, no need
to be different.

-Andi


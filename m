Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVHAQzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVHAQzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVHAQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:55:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:62441 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261194AbVHAQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:55:47 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
References: <20050729161343.A18249@flint.arm.linux.org.uk>
	<20050730.124052.104057695.davem@davemloft.net>
	<tnxzms1c0bf.fsf@arm.com>
	<20050801174030.C14401@flint.arm.linux.org.uk>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 01 Aug 2005 17:54:33 +0100
Message-ID: <tnxzms1a986.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Aug 2005 16:55:03.0930 (UTC) FILETIME=[C347B5A0:01C596B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Aug 01, 2005 at 01:24:04PM +0100, Catalin Marinas wrote:
>> "David S. Miller" <davem@davemloft.net> wrote:
>> > If one cpu stores, does it get picked up in the other cpu's I-cache?
>> 
>> It only gets picked up by the other CPU's D-cache (which is fully
>> coherent between cores). The I-cache needs to be invalidated on each
>> CPU.
>
> Are you sure about this requirement?  I see no evidence of it in Harry's
> patch set.

I asked the people that know more about this architecture than me and
they confirmed that this is a requirement. I will double check
tomorrow with the people that did the initial Linux support.

I haven't checked the original patch but it might work (by luck)
without the I-cache invalidation (and without stressing it too
much). This is because you might do a full mm flush when a process
exits and the I-cache would be clean for newly allocated pages (only
the D-cache needs flushing). If you don't overload memory, you don't
get pages swapped-out/removed and the code in a page for a given
process might remain unchanged until the process exits.

-- 
Catalin


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVDFP4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVDFP4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVDFP4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:56:43 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:64724 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262237AbVDFP4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:56:36 -0400
To: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NOMMU - How to reserve 1 MB in top of memory in a clean way
References: <1112781027.2687.6.camel@laptop.blackstar.nl>
	<tnxzmwc9gun.fsf@arm.com>
	<1112800564.2687.40.camel@laptop.blackstar.nl>
From: Catalin Marinas <catalin.marinas@gmail.com>
Date: Wed, 06 Apr 2005 16:56:34 +0100
In-Reply-To: <1112800564.2687.40.camel@laptop.blackstar.nl> (Bas Vermeulen's
 message of "Wed, 06 Apr 2005 17:16:04 +0200")
Message-ID: <tnxd5t7aogd.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Vermeulen <bvermeul@blackstar.xs4all.nl> wrote:
> This will put me in the zone of 'it ain't ever going to be integrated'.
> I'd preferrably find a solution without changing the zones. My ideal
> solution would be grabbing pages before they are assigned to a zone, or
> at least for the zone to recognize them as used.

The order of the zones was initially chosen based on x86 and ISA
bus. This is no longer valid for all the platforms (for example, the
1st MB can be SSRAM and not usable for DMA).

This might be possible but I've never tried (and not sure how it would
work with nommu) - define CONFIG_NUMA and use 2 memory banks, one from
0 to max - 1M and the 2nd being 1MB. You can define the zone sizes for
each node when calling free_area_init_node() so that the first node
doesn't have any DMA area and the 2nd one has only DMA.

Maybe other could comment on this, not sure it will work. What core
are you using?

A third option could be to define your own dma_alloc* functions and
not give the top MB to the kernel (mem=...).

-- 
Catalin


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUFSNwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUFSNwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUFSNwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:52:36 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:15081 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265756AbUFSNvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:51:18 -0400
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
References: <1087481331.2210.27.camel@mulgrave>
	<m33c4tsnex.fsf@defiant.pm.waw.pl> <1087523134.2210.97.camel@mulgrave>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 19 Jun 2004 01:07:36 +0200
In-Reply-To: <1087523134.2210.97.camel@mulgrave> (James Bottomley's message
 of "17 Jun 2004 20:45:33 -0500")
Message-ID: <m3fz8s79dz.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:

> It falls victim to the 95/5 rule---when you engineer an API, if 95% of
> the complexity is dealing with the 5% of special cases, you're over
> engineering.
>
> So the original proposal is the remaining 5% that covers 95% of the use
> cases (and will do better even on the remaining 5%).

I don't think so. We already have separate masks for coherent
and non-coherent mappings (in PCI API, and I'm told it's to be extended
to DMA API as well). And we need them.

The problem is we're missing DMA masks for non-alloc calls (depending
on the platform) and thus that it isn't very reliable. Drivers which
need this are forced to bounce buffers themselves, and many of them
will not work on 64-bit platforms (as of ~ 2.6.0, I don't check that
regularly). And yes, we really need reliable masks for non-alloc
mappings.

I can't see any added complexity in this scheme, we basically already
do all of that (except the cost, but it's hardly complex and most
drivers would just need to test check_dma_mask() for error).
-- 
Krzysztof Halasa, B*FH

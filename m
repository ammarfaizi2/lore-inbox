Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVJCPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVJCPkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVJCPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:40:23 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:30409 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932288AbVJCPkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:40:23 -0400
X-ORBL: [69.107.75.50]
Date: Mon, 03 Oct 2005 08:40:19 -0700
From: David Brownell <david-b@pacbell.net>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: linux-kernel@vger.kernel.org, basicmark@yahoo.com, arjan@infradead.org
References: <20051003105748.213.qmail@web33014.mail.mud.yahoo.com>
 <1128337656.17024.10.camel@laptopd505.fenrus.org>
 <20051003151457.AD64FEE8CE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <20051003152312.GH16717@flint.arm.linux.org.uk>
In-Reply-To: <20051003152312.GH16717@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003154019.02A66EE8CF@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the issue is that you can't properly control the alignment
> to ensure that you don't inadvertantly dirty the cache lines
> corresponding with the memory you're performing DMA to/from.

That's a much better (== content-ful) explanation; thanks Russell.

Cache line sharing can indeed be a PITA ... and while it's an issue
that's not unique to DMA from the stack, it's something that's less
manageable there.  Plus, DMA isn't always cache-coherent.  Meaning
that for example DMA to the stack might bypass the cache and then
later be overwritten by flushing cached stack updates.  (etc.)

- Dave


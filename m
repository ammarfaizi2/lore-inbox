Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423063AbWAMWp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423063AbWAMWp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423064AbWAMWp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:45:56 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41376
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423063AbWAMWp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:45:56 -0500
Date: Fri, 13 Jan 2006 14:43:01 -0800 (PST)
Message-Id: <20060113.144301.09196399.davem@davemloft.net>
To: James.Bottomley@SteelEye.com
Cc: rmk+lkml@arm.linux.org.uk, htejun@gmail.com, axboe@suse.de,
       bzolnier@gmail.com, james.steward@dynamicratings.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137191930.3365.96.camel@mulgrave>
References: <11371658562541-git-send-email-htejun@gmail.com>
	<20060113220215.GD31824@flint.arm.linux.org.uk>
	<1137191930.3365.96.camel@mulgrave>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Fri, 13 Jan 2006 16:38:49 -0600

> Could someone explain (or give a reference to) the actual problem?  If
> it's a cache coherency issue it should show up with VIPT arhictectures
> as well as VIVT ones ... I have access to parisc systems (with SCSI),
> which are VIPT.

Not true, VIPT caches participate in cache coherency transactions
with the PCI host controller (and thus the PCI device), whereas
VIVT caches do not.

It does make a big difference, it's very hard to share datastructures
with a device concurrently accessing them (what we call PCI consistent
DMA mappings) on a VIVT cache.

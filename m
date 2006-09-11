Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWIKNVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWIKNVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIKNVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:21:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7609
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751477AbWIKNVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:21:03 -0400
Date: Mon, 11 Sep 2006 06:21:44 -0700 (PDT)
Message-Id: <20060911.062144.74719116.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: jbarnes@virtuousgeek.org, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: David Miller <davem@davemloft.net>
In-Reply-To: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
References: <20060909.030854.78720744.davem@davemloft.net>
	<200609101018.06930.jbarnes@virtuousgeek.org>
	<D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 10 Sep 2006 22:01:20 +0200

> Why not just keep writel() etc. for *both* purposes; the address cookie
> it gets as input can distinguish between the required behaviours for
> different kinds of I/Os; it will have to be setup by the arch-specific
> __ioremap() or similar.

This doesn't work when the I/O semantics are encoded into the
instruction, not some virual mapping PTE bits.  We'll have to use
a conditional or whatever in that case, which is silly.

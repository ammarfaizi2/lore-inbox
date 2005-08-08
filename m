Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVHHRpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVHHRpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHHRpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:45:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52194
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932152AbVHHRpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:45:45 -0400
Date: Mon, 08 Aug 2005 10:45:30 -0700 (PDT)
Message-Id: <20050808.104530.85410060.davem@davemloft.net>
To: zab@zabbo.net
Cc: jgarzik@pobox.com, greg@kroah.com, kristen.c.accardi@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6700/6702PXH quirk
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42F7998D.8030606@zabbo.net>
References: <20050805225712.GD3782@kroah.com>
	<20050806033455.GA23679@havoc.gtf.org>
	<42F7998D.8030606@zabbo.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zach Brown <zab@zabbo.net>
Date: Mon, 08 Aug 2005 10:42:37 -0700

> 	if (!foo->enabled)
> 	if (!(foo->flags & FOO_FLAG_ENABLED)

You can hide the "complexity" of the second line behind
macros.  And this is what is done in most places.

Alternatively, you can use the existing bitops interfaces,
and in that case you define bit numbers only then use the
bitops.h interfaces to do all the work (probably the __set_bit()
et al. non-atomic variants in this case).

Really, I think it's worth it.  I absolutely refuse to put sets of
boolean states into C bitfields or even worse integer members.
Just define a u32 bitmask and be done with it.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVHRCs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVHRCs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVHRCs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:48:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7899
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932104AbVHRCs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:48:28 -0400
Date: Wed, 17 Aug 2005 19:48:22 -0700 (PDT)
Message-Id: <20050817.194822.92757361.davem@davemloft.net>
To: akpm@osdl.org
Cc: riel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050817173818.098462b5.akpm@osdl.org>
References: <20050810200943.809832000@jumble.boston.redhat.com>
	<20050810.133125.08323684.davem@davemloft.net>
	<20050817173818.098462b5.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 17 Aug 2005 17:38:18 -0700

> I'm prety sure we fixed that somehow.  But I forget how.

I wish you could remember :-)  I honestly don't think we did.
The DEFINE_PER_CPU() definition still looks the same, and the
way the .data.percpu section is layed out in the vmlinux.lds.S
is still the same as well.

The places which are not handled currently are in not-often-used areas
such as IPVS, some S390 drivers, and some other platform specific
code (likely platforms where the gcc problem in question never
existed).

I do note two important spots where the initialization is not
present, the loopback driver statistics and the scsi_done_q.
Hmmm...

If we are handling it somehow, that would be nice to know for
certain, because we could thus remove all of the ugly
initializers.

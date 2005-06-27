Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVF0Ae2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVF0Ae2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVF0Ae1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:34:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34246
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261681AbVF0Adx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:33:53 -0400
Date: Sun, 26 Jun 2005 17:33:38 -0700 (PDT)
Message-Id: <20050626.173338.41634345.davem@davemloft.net>
To: marcelo.tosatti@cyclades.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: increased translation cache footprint in v2.6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050626185210.GB6091@logos.cnet>
References: <20050626172334.GA5786@logos.cnet>
	<20050626164939.2f457bf6.akpm@osdl.org>
	<20050626185210.GB6091@logos.cnet>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Sun, 26 Jun 2005 15:52:10 -0300

> Well, a TLB entry might cache different sized pages. The platform
> support 4kb, 16kb and 8Mb (IIRC, maybe some other size also).  The
> bigger pages (8Mb) are only used to map 8Mbytes of instruction at
> KERNELBASE, 24Mbytes of data (3 8Mbyte entries) also at KERNELBASE
> and another 8Mbytes of the configuration registers memory space,
> which lives outside RAM space.

Why don't you use 8MB TLB entries when there is a miss to
one of the PAGE_OFFSET pages?  I'm not saying to lock them,
just to use large 8MB TLB entries when a miss is taken for
kernel data accesses to where the kernel maps all of lowmem.

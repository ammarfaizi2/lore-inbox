Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVGVHuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVGVHuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVGVHuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:50:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18911
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262049AbVGVHuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:50:22 -0400
Date: Fri, 22 Jul 2005 00:50:25 -0700 (PDT)
Message-Id: <20050722.005025.26277081.davem@davemloft.net>
To: ncunningham@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QN/PATCH] Why do some archs allocate stack via kmalloc,
 others via get_free_pages?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122005477.3033.56.camel@localhost>
References: <1122005477.3033.56.camel@localhost>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Cunningham <ncunningham@cyclades.com>
Date: Fri, 22 Jul 2005 14:11:17 +1000

> In making some modifications to Suspend, we've discovered that some
> arches use kmalloc and others use get_free_pages to allocate the stack.
> Is there a reason for the variation? If not, could the following patch
> be considered for inclusion (tested on x86 only).

Some platforms really need it to be page aligned (sparc32 sun4c needs
to virtually map the resulting pages into a specific place, for
example).

But, for the ones that don't have this requirement, they want the
cache coloring.

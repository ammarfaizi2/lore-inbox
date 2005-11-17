Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVKQX3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVKQX3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVKQX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:29:00 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29162
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964961AbVKQX27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:28:59 -0500
Date: Thu, 17 Nov 2005 15:29:00 -0800 (PST)
Message-Id: <20051117.152900.72981605.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] unpaged: get_user_pages VM_RESERVED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171928320.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171928320.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:29:17 +0000 (GMT)

> The PageReserved removal in 2.6.15-rc1 prohibited get_user_pages on the
> areas flagged VM_RESERVED in place of PageReserved.  That is correct in
> theory - we ought not to interfere with struct pages in such a reserved
> area; but in practice it broke BTTV for one.
> 
> So revert to prohibiting only on VM_IO: if someone gets into trouble
> with get_user_pages on VM_RESERVED, it'll just be a "don't do that".
> 
> You can argue that videobuf_mmap_mapper shouldn't set VM_RESERVED in the
> first place, but now's not the time for breaking drivers without notice.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

It might be a nice little 2.6.16 project to simplify that
videobuf_mmap_mapper() code, and in fact other driver subsystems want
a similar facility, such as DVB.

So putting some helper routines in the core MM for this, in one spot,
seems like the long term way to handle this peculiar stuff.

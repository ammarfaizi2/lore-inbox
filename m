Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVKQXxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVKQXxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVKQXxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:53:09 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45704
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964900AbVKQXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:53:08 -0500
Date: Thu, 17 Nov 2005 15:52:30 -0800 (PST)
Message-Id: <20051117.155230.25121238.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:37:23 +0000 (GMT)

> Remove the BUG_ON(vma->vm_flags & VM_UNPAGED) from do_wp_page, and let
> it do Copy-On-Write without touching the VM_UNPAGED's page counts - but
> this is incomplete, because the anonymous page it inserts will itself
> need to be handled, here and in other functions - next patch.
> 
> We still don't copy the page if the pfn is invalid, because the
> copy_user_highpage interface does not allow it.  But that's not been
> a problem in the past: can be added in later if the need arises.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Do we even need this?  It is a very serious question...

The cases I've seen, and am aware of, I documented in a previous
mail and those involve MAP_PRIVATE maps of /dev/mem or other
similar fixed page mapping devices.

Which case truly needs COW faults on VM_RESERVED memory which
isn't an application bug of some sort?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVCKExs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVCKExs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVCKExr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:53:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:2141 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261432AbVCKExq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:53:46 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inappropriate use of in_atomic()
X-Message-Flag: Warning: May contain useful information
References: <20050310204006.48286d17.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 10 Mar 2005 20:53:45 -0800
In-Reply-To: <20050310204006.48286d17.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Mar 2005 20:40:06 -0800")
Message-ID: <52k6oe9412.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Mar 2005 04:53:45.0690 (UTC) FILETIME=[4E5E1BA0:01C525F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Consequently the use of in_atomic() in the below files is probably
    > deadlocky if CONFIG_PREEMPT=n:
    ...
    > 	drivers/infiniband/core/mad.c

Thanks for pointing this out.  I'll get you a patch in the next day or
two.  As you can probably tell, the code is just trying to decide
whether to use GFP_ATOMIC or GFP_KERNEL to allocate a couple of
things, depending on what context we're being called from.  So at
worst we can just change to GFP_ATOMIC unconditionally.

I'll check into whether we can do something cleverer, but just going
the GFP_ATOMIC route won't be horrible.

Thanks,
  Roland

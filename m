Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbVLHWwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbVLHWwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbVLHWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:52:09 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30098
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932699AbVLHWwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:52:07 -0500
Date: Thu, 08 Dec 2005 14:51:48 -0800 (PST)
Message-Id: <20051208.145148.36886043.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       jmorris@intercode.com.au, laforge@netfilter.org, akpm@osdl.org
Subject: Re: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512082336.01678.jesper.juhl@gmail.com>
References: <200512082336.01678.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Thu, 8 Dec 2005 23:36:01 +0100

> Here's a small patch to decrease the number of pointer derefs in
> net/netfilter/nfnetlink_queue.c
> 
> Benefits of the patch:
>  - Fewer pointer dereferences should make the code slightly faster.
>  - Size of generated code is smaller
>  - improved readability

And you verified the compiler isn't making these transformations
already?  It should be doing so via Common Subexpression Elimination
unless the derefs are scattered around with interspersed function
calls in which case the compiler cannot prove that the memory
behind the pointer does not change.

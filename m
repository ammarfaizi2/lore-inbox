Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUIIWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUIIWsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUIIWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:48:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:50101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268001AbUIIWsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:48:41 -0400
Date: Thu, 9 Sep 2004 15:52:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-Id: <20040909155226.714dc704.akpm@osdl.org>
In-Reply-To: <20040909163929.GA4484@logos.cnet>
References: <20040909163929.GA4484@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> I do not see a problem with changing pagevec to "15" page pointers either, 
> Andrew, is there a special reason for that "16"? Is intentional to align
> to 64 kbytes (IO device alignment)? I dont think that matters much because
> of the elevator which sorts and merges requests anyway?

No, it was just a randomly-chosen batching factor.

The tradeoff here is between

a) lock acquisition frequency versus lock hold time (increasing the size
   helps).

b) icache misses versus dcache misses. (increasing the size probably hurts).

I suspect that some benefit would be seen from making the size very small
(say, 4). And on some machines, making it larger might help.

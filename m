Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWJMUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWJMUqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWJMUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:46:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751896AbWJMUql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:46:41 -0400
Date: Fri, 13 Oct 2006 13:46:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Add __GFP_ZERO to GFP_LEVEL_MASK
Message-Id: <20061013134635.a983e4d7.akpm@osdl.org>
In-Reply-To: <28729.1160771116@lwn.net>
References: <28729.1160771116@lwn.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 14:25:16 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> There is a very helpful comment in <linux/gfp.h>:
> 
>   /* if you forget to add the bitmask here kernel will crash, period */
> 
> Well, my kernel has been crashing (period) at the BUG() in cache_grow();
> the offending flag is __GFP_ZERO.  I think it needs to be in
> GFP_LEVEL_MASK.  Anybody know a good reason why it's not there now?
> 

It would be a bit odd to pass __GFP_ZERO into the slab allocator.  Slab
doesn't need that hint: it has its own ways of initialising the memory.

What is the callsite?

Thanks.


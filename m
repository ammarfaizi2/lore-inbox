Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbUKKC7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbUKKC7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbUKKC7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 21:59:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:42191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbUKKC7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 21:59:34 -0500
Date: Wed, 10 Nov 2004 18:59:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@linuxmail.org
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-Id: <20041110185925.1c2eb9bf.akpm@osdl.org>
In-Reply-To: <1100137328.7402.45.camel@desktop.cunninghams>
References: <1100135825.7402.32.camel@desktop.cunninghams>
	<20041111012919.GD3217@holomorphy.com>
	<1100137328.7402.45.camel@desktop.cunninghams>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> Remaining culprits are....
> 
>  Reiser4:
>  - do_readpage_tail
>   -reiser4_status_init
>   -reiser4_status_write

obuggerit.  Look, a simple helper is to redefine kmap_atomic() and
kunmap_atomic() to work on char*'s.  This will spit warnings if someone
feeds in a page*.  Which would be a lot more useful if we didn't have all
those infernal __iomem warnings scrolling off the screen but ho hum.

I'll cook something up.

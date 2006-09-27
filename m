Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031169AbWI0WmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031169AbWI0WmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031170AbWI0WmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:42:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031169AbWI0WmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:42:11 -0400
Date: Wed, 27 Sep 2006 15:42:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 real-V5] drivers: add lcd display support
Message-Id: <20060927154208.149069e3.akpm@osdl.org>
In-Reply-To: <653402b90609271358m58950e96k99b2314f9732b5ef@mail.gmail.com>
References: <20060922220346.69f63338.maxextreme@gmail.com>
	<20060926120821.e11f3254.akpm@osdl.org>
	<653402b90609271358m58950e96k99b2314f9732b5ef@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 20:58:24 +0000
"Miguel Ojeda" <maxextreme@gmail.com> wrote:

> On 9/26/06, Andrew Morton <akpm@osdl.org> wrote:
> > It's also probably-incorrect on big-endian CPUs.
> > Perhaps you should not
> > use bitops at all for this driver, use open-coded |
> > and &/~ instead?
> 
> Uhm, someone told me that they shouldn't be used because the kernel
> has generic functions for that.

You can't believe everything you read on the internet ;)

set_bit() and friends are a) atomic wrt other CPUs on SMP and b) only to be
performed on unsigned longs.

> I researched the kernel sources, and looking at bitops.h I found
> setbit(), so I tried to use it in the driver, althought I prefer
> standard |= and &=.

Those are the appropriate operations to use in this driver.


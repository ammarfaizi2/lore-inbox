Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTH1T0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTH1T0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:26:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:28820 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264239AbTH1T0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:26:22 -0400
Date: Thu, 28 Aug 2003 12:10:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
Message-Id: <20030828121016.2c0e2716.akpm@osdl.org>
In-Reply-To: <1062097375.1952.41.camel@mulgrave>
References: <1062097375.1952.41.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> Most is just simple fixes; however, the needless change from atomic to
> non-atomic operations in smp_invalidate_interrupt() caused me a lot of
> pain to track down since it introduced some very subtle bugs.

Yes, the generic code was like that too.  It was causing lockups.  Sorry, I
did not realise that voyager had a private invalidatation implementation.

Officially smp_invalidate_needed should be a cpumask_t and
smp_invalidate_interrupt() should be using cpu_isset() rather than
open-coded bitops.  For all those 64-way voyagers out there ;)

(Actually it is legitimate: you may want to run a NR_CPUS=48 kernel on a
2-way voyager just for testing purposes).  I'll drop your patch in as-is,
and maybe Bill can take a look at cpumaskifying it sometime?


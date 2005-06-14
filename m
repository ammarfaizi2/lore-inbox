Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFNX5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFNX5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFNX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:57:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVFNX5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:57:33 -0400
Date: Tue, 14 Jun 2005 16:58:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: christoph <christoph@scalex86.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-Id: <20050614165818.6f83fa6c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506141644160.4099@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
	<20050608131839.GP23831@wotan.suse.de>
	<Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
	<20050614162354.6aabe57e.akpm@osdl.org>
	<Pine.LNX.4.62.0506141644160.4099@ScMPusgw>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph <christoph@scalex86.org> wrote:
>
> On Tue, 14 Jun 2005, Andrew Morton wrote:
> 
> > I think readmostliness and alignment are mostly-unrelated concepts and
> > should have separate tag thingies.  IOW,
> > __cacheline_aligned_mostly_readonly goes away and to handle things like the
> > cpu maps we do:
> 
> Yup that makes the whole thing much more sane. Can we specify multiple 
> attributes to a variable?

I suppose so.

Compiling this:

int x   __attribute__((__aligned__(32)))
        __attribute__((__section__(".data.mostly_readonly")));


generates this:

	.file	"t.c"
	.version	"01.01"
gcc2_compiled.:
.globl x
	.section	.data.mostly_readonly,"aw",@progbits
	.align 32
	.type	 x,@object
	.size	 x,4
x:
	.zero	4
	.ident	"GCC: (GNU) 2.96 20000731 (Red Hat Linux 7.3 2.96-113)"

Seems OK?

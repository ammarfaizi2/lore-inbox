Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbTIKRFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTIKRFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:05:23 -0400
Received: from ns.suse.de ([195.135.220.2]:20447 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261398AbTIKRFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:05:19 -0400
Date: Thu, 11 Sep 2003 19:05:16 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911190516.64128fe9.ak@suse.de>
In-Reply-To: <20030911165845.GE29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030911165845.GE29532@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 17:58:45 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Andi Kleen wrote:
> > +static int is_prefetch(struct pt_regs *regs, unsigned long addr)
> 
> Do I understand that certain values of "addr" can't be due to the
> erratum?
> 
> In which case, could you skip most of the is_prefetch() instruction
> decoder with a test like this?:
> 
> 	if ((addr & 3) == 0)
> 		return 0;

Maybe. But gcc generates quite good code (binary decision tree) code for
the switch() statement already so I don't think it is worth it to go 
through complications just to avoid that.

The decoder looks big in C, but when you take a look at its hot path in 
assembly it is quite fast.

-Andi

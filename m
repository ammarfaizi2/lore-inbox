Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTIKRnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbTIKRlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:41:04 -0400
Received: from ns.suse.de ([195.135.220.2]:44672 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261435AbTIKRkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:40:37 -0400
Date: Thu, 11 Sep 2003 19:39:54 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911193954.63724a82.ak@suse.de>
In-Reply-To: <20030911173245.GJ29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030911165845.GE29532@mail.jlokier.co.uk>
	<20030911190516.64128fe9.ak@suse.de>
	<20030911173245.GJ29532@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 18:32:45 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Andi Kleen wrote:
> > > 	if ((addr & 3) == 0)
> > > 		return 0;
> > 
> > Maybe. But gcc generates quite good code (binary decision tree) code for
> > the switch() statement already so I don't think it is worth it to go 
> > through complications just to avoid that.
> > 
> > The decoder looks big in C, but when you take a look at its hot path in 
> > assembly it is quite fast.
> 
> I wonder.  No part of the signal path looks especially slow, and yet
> as a whole it isn't that fast.  The odd percentage slowdown here and
> there is quite bothersome.
> 
> GCC generates a decision tree.  You realise that about half of the
> branches in that tree will be mispredicted?

True. Doing a BTSL in a bitmap would be probably faster to check
bytes in a switch. Or maybe gcc should do that, but it doesn't.

But I doubt the small performance advantage of that for an still quite 
obscure path is worth the code uglification that would be require to do
it without gcc support.

To put it into perspective:

signal exception path is thousands of cycles, we're talking about tens
of cycles here.

-Andi

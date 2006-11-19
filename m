Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933269AbWKSUtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269AbWKSUtj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbWKSUtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:49:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:55988 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933269AbWKSUti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:49:38 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20061119202348.GA27649@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:49:42 +1100
Message-Id: <1163969383.5826.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 21:23 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > dont worry, it's -rt only stuff.
> > 
> > Still, I'm curious :-) Besides, there have been people talking about 
> > having -rt work on ppc64 so ...
> 
> ok :)
> 
> > What do you need an ack() for on fasteoi ? On all fasteoi controllers 
> > I have, ack is implicit by obtaining the vector number and all there 
> > is is an eoi...
> 
> it's a compatibility hack only. Threaded handlers are a different type 
> of flow, but often the fasteoi handler is not changed to the threaded 
> handler so i changed it to be a threaded handler too.
> 
> threaded handlers need a mask() + an ack(), because that's the correct 
> model to map them to kernel threads - threaded handlers can be delayed 
> for a long time if something higher-prio is preempting them.

Well, the principle of controllers that do fasteoi is that all
interrupts of the same priority or below are masked until eoi happens...
so I still don't see why you need that...

Ben.


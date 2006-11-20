Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966624AbWKTUJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966624AbWKTUJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966626AbWKTUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:09:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:5546 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966624AbWKTUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:09:52 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <20061120165621.GA1504@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>
	 <1163985380.5826.139.camel@localhost.localdomain>
	 <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	 <20061120165621.GA1504@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 07:09:45 +1100
Message-Id: <1164053385.8073.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 17:56 +0100, Ingo Molnar wrote:
> * Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> > >on PPC64, 'get the vector' initiates an ACK as well - is that done 
> > >before handle_irq() is done?
> > 
> >    Exactly. How else do_IRQ() would know the vector?
> 
> the reason i'm asking is that in this case masking is a bit late at this 
> point and there's a chance for a repeat interrupt.

What do you mean by a bit late ?

You can't mask before you know what interrupt occured so you don't
really have a choice there :-) I'm pretty sure that mask + eoi is what
Apple does on Darwin too though.

Cheers,
Ben.



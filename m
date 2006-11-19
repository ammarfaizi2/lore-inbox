Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933126AbWKSUEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbWKSUEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933127AbWKSUEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:04:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:59530 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933126AbWKSUEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:04:12 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: mingo@elte.hu, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       dwalker@mvista.com
In-Reply-To: <1163966437.5826.99.camel@localhost.localdomain>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:04:09 +1100
Message-Id: <1163966649.5826.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 07:00 +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2006-11-19 at 22:43 +0300, Sergei Shtylyov wrote:
> > As fasteoi type chips never had to define their ack() method before the
> > recent Ingo's change to handle_fasteoi_irq(), any attempt to execute handler
> > in thread resulted in the kernel crash. So, define their ack() methods to be
> > the same as their eoi() ones...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > ---
> > Since there was no feedback on three solutions I suggested, I'm going the way
> > of least resistance and making the fasteoi type chips behave the way that
> > handle_fasteoi_irq() is expecting from them...
> 
> Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi
> handler is being changed and what is the rationale for adding an ack
> that was not necessary before ?

To be more precise, I don't see in what circumstances a fasteoi type PIC
would need an ack routine that does something different than the eoi...
and if it always does the same thing, why not just call eoi ?

Ben.



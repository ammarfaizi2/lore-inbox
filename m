Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbUKQGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUKQGLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUKQGLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:11:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:4063 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262181AbUKQGLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:11:45 -0500
Subject: Re: 2.6.10-rc2 pbook oops on resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041116214938.65601546.akpm@osdl.org>
References: <1100605854.6333.7.camel@localhost>
	 <20041116214938.65601546.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 17 Nov 2004 17:09:22 +1100
Message-Id: <1100671762.14626.103.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 21:49 -0800, Andrew Morton wrote:
> Soeren Sonnenburg <kernel@nn7.de> wrote:
> >
> > machine comes up ok, but I see this oops in dmesg... Any ideas ?
> 
> That would be due to this code in ohci_pci_resume():
> 
> #ifdef CONFIG_PMAC_PBOOK
> 		if (_machine == _MACH_Pmac)
> 			enable_irq (to_pci_dev(hcd->self.controller)->irq);
> #endif
> 
> enabling an already-enabled IRQ.
> 
> I think Ben plays in this area?

Yes. It's not an oops tho, and is harmless for now... The pmac code used
to disable/enable irq around sleep, but that caused this problem when
David added code to unregister/re-register the irq during sleep as well
to the generic HCD stuff.

I have some pending patches, haven't had time to finish them tho... I
have a lot of sleep-related pmac update that are waiting for me to
finish getting the stuff working on the iBook G4, and it's part of that
pile... I'll let you know tomorrow.

Ben.


